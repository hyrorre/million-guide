let itemList = null;

$(document).ready(function(){
	let layzr = new Layzr({normal: 'data-normal'});
	layzr.update().check().handlers(true);

	// #で始まるアンカーをクリックした場合に処理
	$('a[href^="#"]').click(function(){
		// スクロールの速度
		let speed = 400; // ミリ秒
		// アンカーの値取得
		let href = $(this).attr("href");
		// 移動先を取得
		let target = $(href === "#" || href === "" ? 'html' : href);
		// 移動先を数値で取得
		let position = target.offset().top;
		// スムーススクロール
		$('body,html').animate({scrollTop: position}, speed, 'swing');
		return false;
	});
	
	let body = $('body');
	if(body.attr('data-controller') === 'musics'){
		if(body.attr('data-action') === 'index' && !itemList){
			let options = {
				// 検索するターゲットデータ
				valueNames: [
					'title',
					'kana',
					'order',
					'musictype',
					'diffnum0',
					'diffnum1',
					'diffnum2',
					'diffnum3',
					'diffnum4',
					'added_on'
				]
			};
			// ターゲットとなるID
			itemList = new List('itemLists', options);
			
			$('#date_sw').change(function(){
				$('.added_on').toggle();
			})
		}
		else if(body.attr('data-action') === 'show'){
			load_cookie();
			$('select').change(function(){
				load_draw();
				save_cookie();
			});
			load_draw();
		}
	}
});

function save_cookie(){
	for(let select of [$('#width_select'), $('#height_select')]){
		Cookies.set(select.attr('id'), select.val(), {expires: 365});
	}
}

function load_cookie(){
	for(let select of [$('#width_select'), $('#height_select')]){
		let id = select.attr('id');
		let val = Cookies.get(id);
		if(val !== undefined){
			select.children().prop("selected", false);
			$("#" + id + " .opval" + val).prop("selected", true);
		}
	}
}

function load_draw(){
	let max_section = 5;
	let resolution = 192;
	
	function Note(lane, section, index, pulse){
		this.lane = lane;
		this.section = section;
		this.index = index;
		this.pulse = pulse;
	}
	
	let ex_large_section = 0;
	let notes = [];
	
	/**
	 * @return {number}
	 */
	function ChannelToLane(channel){
		return (Math.floor(channel / 10) - 1) * 6 + (channel % 10) - 1;
	}
	
	/**
	 * @return {number}
	 */
	function EndXToLane(endx, difficulty, index){
		if(index === 36){
			return 5;
		}
		if(difficulty === 0 || difficulty === 1){
			return endx * 6 + 2;
		}
		if(difficulty === 2){
			return (endx + 1) * 2;
		}
		if(difficulty === 3 || difficulty === 4){
			return endx * 2;
		}
		return 0;
	}
	
	let slide_range = [[0, 0, 0], [0, 0, 0]];
	
	/**
	 * @return {number}
	 */
	function TypeSizeDirectionToIndex(type, size, direction, slide_id, pulse){
		let base_index = 0;
		if(slide_id === 0 || slide_id === 1){
			base_index = (slide_id + 1) * 10;
		}
		let index = 0;
		if(type === 1){
			index = 1;
		}
		else if(type === 2){
			if(direction === 1){
				index = 4;
			}
			else if(direction === 2){
				index = 3;
			}
			else if(direction === 3){
				index = 5;
			}
			else{
				index = 1;
			}
		}
		else if(type === 3 || type === 4){
			if(direction === 1){
				index = 4;
				index -= size * 2;
			}
			else if(direction === 2){
				index = 3;
				index -= size * 2;
			}
			else if(direction === 3){
				index = 5;
				index -= size * 2;
			}
			else{
				index = 1;
				if(base_index !== 0){
					index = 1 - size;
				}
			}
			if(base_index === 0){
				if(slide_range[0][1] < pulse){
					base_index = 10;
					slide_range[0] = [pulse, pulse, size];
				}
				else{
					base_index = 20;
					slide_range[1] = [pulse, pulse, size];
				}
			}
			else{
				slide_range[slide_id][1] = pulse;
				index += slide_range[slide_id][2];
			}
		}
		else if(type === 100){
			index = 36;
		}
		index += base_index;
		index += size;
		return index;
	}
	let score_str = $("#score_str").text();
	if($("#format").text() === "0"){ //bms format
		let lines = score_str.split("\n");
		for(let line of lines){
			if(7 < line.length && line[0] === "#" && line[6] === ":"){
				if(line[line.length - 1] === "\r"){
					line = line.substr(0, line.length - 1);
				}
				let section = Number(line.substr(1, 3));
				let channel = Number(line.substr(4, 2));
				let lane = ChannelToLane(channel);
				let objstr = line.substr(7);
				for(let i = 0; i < objstr.length; i += 2){
					let index = Number(objstr.substr(i, 2));
					if(index !== 0){
						let pulse = resolution * (section + i / objstr.length);
						notes.push(new Note(lane, section, index, pulse));
						if(index === 36){
							ex_large_section = section + 1;
						}
					}
				}
			}
		}
	}
	else{ //notes format
		resolution = 23040;
		let section_offset = -1;
		let notes_obj = JSON.parse(score_str);
		let snotes = notes_obj.Notes;
		for(let snote of snotes){
			let pulse = snote.Ticks;
			let section = Math.floor(pulse / resolution);
			if(section_offset === -1){
				section_offset = section - 1;
			}
			section -= section_offset;
			pulse -= section_offset * resolution;
			let index = TypeSizeDirectionToIndex(snote.Type, snote.Size, snote.FlickDirection, -1, pulse);
			let lane = EndXToLane(snote.EndX, Number($("#difficulty").text()), index);
			notes.push(new Note(lane, section, index, pulse));
			if(index === 36){
				ex_large_section = section + 1;
			}
			else if(snote.FollowingNotes !== null){
				let len = snote.FollowingNotes.length;
				let i = 0;
				for(let fnote of snote.FollowingNotes){
					let fpulse = fnote.Ticks - section_offset * resolution;
					let fsection = Math.floor(fpulse / resolution);
					let slide_id = Math.floor(index / 10) - 1;
					let findex = 0;
					if(i === len - 1){
						findex = TypeSizeDirectionToIndex(fnote.Type, snote.Size, fnote.FlickDirection, slide_id, fpulse);
					}
					else{
						findex = (slide_id + 1) * 10 + 7;
					}
					let flane = EndXToLane(fnote.EndX, Number($("#difficulty").text()), findex);
					notes.push(new Note(flane, fsection, findex, fpulse));
					i++;
				}
			}
		}
	}
	notes.sort(
		function(a, b){
			if(a.pulse < b.pulse) return -1;
			if(a.pulse > b.pulse) return 1;
			return 0;
		}
	);
	max_section = notes[notes.length - 1].section + 1;
	
	// Canvas APIが利用できるかを判定（1）
	if(HTMLCanvasElement){
		// コンテキストオブジェクトを取得（2）
		let cv = [document.querySelector('#cv0'), document.querySelector('#cv1')];
		let context = [cv[0].getContext('2d'), cv[1].getContext('2d')];
		let small_r = 13;
		let flick_r = 16;
		let arrow_r = flick_r - 6;
		let large_r = 18;
		let ex_large_r = 30;
		
		let sqrt2 = Math.sqrt(2);
		
		let box_x = 30;
		let div_x = 45 * $('#width_select').val() / 100;
		let div_y = 45 * $('#height_select').val() / 100;
		let section_num_w = 70;
		
		cv[1].height = div_y * 8 * ex_large_section;
		cv[0].height = div_y * 8 * (max_section - ex_large_section);
		for(let c of cv){
			c.width = box_x + div_x * 7 + section_num_w + 50;
		}
		
		function getContextY(pulse){
			section_f = pulse / resolution;
			if(section_f < ex_large_section){
				return {
					c: context[1],
					y: div_y * 8 * (ex_large_section - pulse / resolution)
				};
			}
			else{
				return {
					c: context[0],
					y: div_y * 8 * (max_section - pulse / resolution)
				};
			}
		}
		
		for(let section = 0; section < max_section; ++section){
			let context_y = getContextY(section * resolution);
			let c = context_y.c;
			c.font = "30px Arial"
			let box_y = context_y.y - div_y * 8;
			
			c.lineWidth = 2;
			c.strokeStyle = 'rgb(0, 0, 0)';
			c.strokeRect(box_x, box_y, div_x * 7 + section_num_w, div_y * 8);
			c.beginPath();
			c.moveTo(box_x + div_x * 7, box_y);
			c.lineTo(box_x + div_x * 7, box_y + div_y * 8);
			c.stroke();
			c.fillText(section.toString(), box_x + div_x * 7 + 20, box_y + div_y * 4);
			
			c.lineWidth = 0.5;
			c.strokeStyle = 'rgb(0, 0, 0)';
			for(let i = 1; i < 7; ++i){
				c.beginPath();
				c.moveTo(box_x + div_x * i, box_y);
				c.lineTo(box_x + div_x * i, box_y + div_y * 8);
				c.stroke();
			}
			for(let i = 1; i < 8; ++i){
				c.beginPath();
				c.lineWidth = (i % 2 ? 0.5 : 1);
				c.moveTo(box_x, box_y + div_y * i);
				c.lineTo(box_x + div_x * 7, box_y + div_y * i);
				c.stroke();
			}
		}
		let last_note = null;
		let last_slide_notes = [null, null];
		for(let note of notes){
			let context_y = getContextY(note.pulse);
			let c = context_y.c;
			let x = box_x + (div_x * (note.lane + 2) / 2);
			let y = context_y.y;
			
			if(last_note !== null && note.pulse === last_note.pulse && note.index % 10 !== 7 && last_note.index % 10 !== 7){
				let last_x = box_x + (div_x * (last_note.lane + 2) / 2);
				c.lineWidth = 5;
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.beginPath();
				c.moveTo(x, y);
				c.lineTo(last_x, y);
				c.stroke();
			}
			// handle slide notes
			let slide_id = Math.floor(note.index / 10) - 1;
			if(slide_id === 0 || slide_id === 1){
				if(last_slide_notes[slide_id] === null){
					last_slide_notes[slide_id] = note;
				}
				else{
					c.lineWidth = 26;
					c.strokeStyle = c.fillStyle = 'rgb(240, 120, 120)';
					let last_x = box_x + (div_x * (last_slide_notes[slide_id].lane + 2) / 2);
					let last_y = getContextY(last_slide_notes[slide_id].pulse).y;
					last_slide_notes[slide_id] = (note.index % 10 === 7 ? note : null);
					
					c.beginPath();
					c.moveTo(last_x, last_y);
					c.lineTo(x, y);
					c.stroke();
					if(note.index % 10 === 7){
						c.beginPath();
						c.arc(x, y, c.lineWidth / 2, 0, Math.PI * 2, false);
						c.fill();
					}
				}
			}
			last_note = note;
		}
		for(let note of notes){
			let context_y = getContextY(note.pulse);
			let c = context_y.c;
			let x = box_x + (div_x * (note.lane + 2) / 2);
			let y = context_y.y;
			
			c.lineWidth = 2;
			
			c.beginPath();
			if(note.index % 10 === 0){
			}
			else if(note.index % 10 === 1){
				c.strokeStyle = 'rgb(250, 250, 250)';
				c.fillStyle = 'rgb(240, 20, 20)';
				c.arc(x, y, small_r - 2, 0, Math.PI * 2, false);
				c.fill();
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.arc(x, y, small_r, 0, Math.PI * 2, false);
				c.stroke();
			}
			else if(note.index % 10 === 2){
				c.strokeStyle = 'rgb(250, 250, 250)';
				c.fillStyle = 'rgb(240, 20, 20)';
				c.arc(x, y, large_r - 2, 0, Math.PI * 2, false);
				c.fill();
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.arc(x, y, large_r, 0, Math.PI * 2, false);
				c.stroke();
			}
			else if(note.index % 10 === 3){
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.fillStyle = 'rgb(250, 250, 250)';
				c.moveTo(x + flick_r / sqrt2, y - flick_r / sqrt2);
				c.lineTo(x, y - 2 * flick_r / sqrt2);
				c.lineTo(x - flick_r / sqrt2, y - flick_r / sqrt2);
				c.fill();
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(250, 250, 250)';
				c.fillStyle = 'rgb(0, 170, 0)';
				c.arc(x, y, flick_r - 2, 0, Math.PI * 2, false);
				c.fill();
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.arc(x, y, flick_r, Math.PI * 5 / 4, Math.PI * 7 / 4, true);
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(250, 250, 250)';
				c.moveTo(x, y + arrow_r);
				c.lineTo(x, y - arrow_r);
				c.lineTo(x - arrow_r, y);
				c.moveTo(x, y - arrow_r);
				c.lineTo(x + arrow_r, y);
				c.stroke();
			}
			else if(note.index % 10 === 4){
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.fillStyle = 'rgb(250, 250, 250)';
				c.moveTo(x - flick_r / sqrt2, y - flick_r / sqrt2);
				c.lineTo(x - 2 * flick_r / sqrt2, y);
				c.lineTo(x - flick_r / sqrt2, y + flick_r / sqrt2);
				c.fill();
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(250, 250, 250)';
				c.fillStyle = 'rgb(20, 20, 240)';
				c.arc(x, y, flick_r - 2, 0, Math.PI * 2, false);
				c.fill();
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.arc(x, y, flick_r, Math.PI * 3 / 4, Math.PI * 5 / 4, true);
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(250, 250, 250)';
				c.moveTo(x + arrow_r, y);
				c.lineTo(x - arrow_r, y);
				c.lineTo(x, y - arrow_r);
				c.moveTo(x - arrow_r, y);
				c.lineTo(x, y + arrow_r);
				c.stroke();
			}
			else if(note.index % 10 === 5){
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.fillStyle = 'rgb(250, 250, 250)';
				c.moveTo(x + flick_r / sqrt2, y - flick_r / sqrt2);
				c.lineTo(x + 2 * flick_r / sqrt2, y);
				c.lineTo(x + flick_r / sqrt2, y + flick_r / sqrt2);
				c.fill();
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(250, 250, 250)';
				c.fillStyle = 'rgb(225, 225, 0)';
				c.arc(x, y, flick_r - 2, 0, Math.PI * 2, false);
				c.fill();
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.arc(x, y, flick_r, Math.PI / 4, Math.PI * 7 / 4, false);
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(250, 250, 250)';
				c.moveTo(x - arrow_r, y);
				c.lineTo(x + arrow_r, y);
				c.lineTo(x, y - arrow_r);
				c.moveTo(x + arrow_r, y);
				c.lineTo(x, y + arrow_r);
				c.stroke();
			}
			else if(note.index === 36){
				c.strokeStyle = 'rgb(250, 250, 250)';
				c.fillStyle = 'rgb(240, 20, 20)';
				c.arc(x, y, ex_large_r - 2, 0, Math.PI * 2, false);
				c.fill();
				c.stroke();
				c.beginPath();
				c.strokeStyle = 'rgb(30, 30, 30)';
				c.arc(x, y, ex_large_r, 0, Math.PI * 2, false);
				c.stroke();
			}
		}
	}
}

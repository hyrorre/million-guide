require 'open-uri'
require 'fileutils'
require 'pathname'
require 'digest/sha2'

HOST = "http://localhost:3000"

def output_html(array)
	for path in array
		url = HOST + path
		open(url, "rb") do |html|
			content = html.read
			file_path = Dir.pwd + "/html" + path + (path.end_with?("/") ? "index.html" : "")
			is_asset = false
			file_path.scan(/\.(js|css|png|jpg)$/) do |asset_ext|
				is_asset = true
				ext = Pathname(file_path).extname
				file_path = Pathname(file_path).sub_ext("").to_s + "-" + Digest::SHA256.hexdigest(content) + ext
			end
			file_dir = File.split(file_path)[0]
			FileUtils.mkdir_p(file_dir) unless FileTest.exist?(file_dir)
			open(file_path, "w+b") do |file|
				if is_asset
					file.write(content)
				else 
					file.write(content.gsub(%r(http://(localhost|0.0.0.0|127.0.0.1):3000), "https://million.hyrorre.com"))
				end
			end
		end
	end
end

ids = %w(
	afterschool
	aikost
	anpara
	asacre
	astation
	bharmony
	bibabo
	blmstar
	bncsmile
	boc
	brand
	chulov
	datpri
	dear
	dreaming
	dretra
	ethamo
	fairytale
	fancani
	fesillumi
	fwind
	goodsleep
	grosto
	happydarling
	happyeffect
	happylucky
	harmonics
	harumachi
	hatsuboshimix
	heartdays
	homesf
	hsymph
	humming
	hweekend
	idolchang
	inthena
	jibure
	jireha
	jparty
	kimihanabi
	koimask
	kokokae
	kokoroex
	kuraki
	lastress
	lesson
	liar
	locomo
	machipri
	meltyf
	merry
	neversleep
	nijile
	orikoe
	pdreamer
	pregra
	priamb
	prologue
	raisef
	ready
	rolltri
	ruriiro
	senti
	siscafe
	smileichi
	sss
	stamelo
	standing
	sunrhythm
	sutekise
	sympho
	thankyou
	tokimekionpu
	top
	unibeat
	union
	utamas
	vividcolor
	welcome
	why
	zettaibreak
)

array = Array.new
array.push "/assets/application.js"
array.push "/assets/application.css"
array.push "/robots.txt"
array.push "/sitemap.xml"
array.push "/.htaccess"

array.push "/assets/1x1.png"
for i in 0..3 do
	array.push sprintf("/assets/musictypes/%d.png", i)
end

array.push "/"
ids.each do |id|
	array.push sprintf("/assets/jackets/%s.jpg", id)
	for i in 0..4 do
		array.push sprintf("/musics/%s/%d/", id, i)
	end
end

output_html(array)
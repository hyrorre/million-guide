class MusicsController < ApplicationController
  def index
    @musics = Music.all.order(:order)
    @musictype_str = ["Pr", "Fa", "An", "All"]
    @difficulty_str = ["2M", "2M+", "4M", "6M", "MM", "MM+"]
    @bms_exist = {}
    @levels = {}
    @musics.each do |music|
      tmp_exist = []
      for i in 0..5 do
        filepath = "#{Rails.root}/app/assets/scores/#{music.idstr}#{i}.bms"
        tmp_exist[i] = File.exist?(filepath)
        if tmp_exist[i] == false
          filepath = "#{Rails.root}/app/assets/scores/#{music.idstr}#{i}.notes"
          tmp_exist[i] = File.exist?(filepath)
        end
      end
      @bms_exist[music.idstr] = tmp_exist
      @levels[music.idstr] = [
        music.level_2m,
        music.level_2mp,
        music.level_4m,
        music.level_6m,
        music.level_mm,
        music.level_mmp
      ]
    end
  end

  def show
    @music = Music.find_by(idstr: params[:idstr])
    gon.format = 0 # 0 : bms, 1 : notes
    gon.score_str = ""
    @difficulty = gon.difficulty = params[:difficulty]
    @difficulty_str = ["2M", "2M+", "4M", "6M", "MM", "MM+"]
    filepath = "#{Rails.root}/app/assets/scores/#{@music.idstr}#{params[:difficulty]}.bms"
    if !File.exist?(filepath)
      filepath = "#{Rails.root}/app/assets/scores/#{@music.idstr}#{params[:difficulty]}.notes"
      gon.format = 1
    end
    File.open(filepath) do |file|
      file.each_line do |line|
        gon.score_str += line
      end
    end
  end
end

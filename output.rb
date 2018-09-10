require 'open-uri'
require 'fileutils'

HOST = "http://localhost:3000"

def output_html(array)
  for path in array
    url = HOST + path
    open(url) do |html|
      file_path = Dir.pwd + "/html" + path + (path.end_with?("/") ? "index.html" : "");
      file_dir = File.split(file_path)[0]
      FileUtils.mkdir_p(file_dir) unless FileTest.exist?(file_dir)
      open(file_path, "w+b") do |file|
        file.write(html.read.gsub(%r(http://(localhost|0.0.0.0|127.0.0.1):3000), "https://million.hyrorre.com"))
      end
    end
  end
end

ids = %w(afterschool aikost anpara bharmony bibabo blmstar boc brand dear dretra ethamo fairytale fancani goodsleep grosto happydarling happyeffect happylucky homesf hsymph humming hweekend jibure jireha kimihanabi kokokae kokoroex kuraki lesson liar locomo machipri meltyf neversleep nijile orikoe pregra priamb prologue ready ruriiro senti smileichi sss standing sunrhythm sutekise sympho thankyou tokimekionpu top unibeat union utamas vividcolor welcome why zettaibreak)

array = Array.new
array.push "/assets/application.js"
array.push "/assets/application.css"
array.push "/robots.txt"
array.push "/sitemap.xml"
array.push "/.htaccess"

array.push "/musics/"
ids.each do |id|
  for i in 0..4 do
    array.push sprintf("/musics/%s/%d/", id, i)
  end
end

output_html(array)
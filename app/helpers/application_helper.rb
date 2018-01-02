# app/helpers/application_helper.rb
module ApplicationHelper
	def full_title(page_title)
	  base_title = "ミリシタ簡易譜面ビューア" # 自分のアプリ名を設定する
	  if page_title.empty?
		base_title
	  else
		"#{page_title} | #{base_title}"
	  end
	end
  end
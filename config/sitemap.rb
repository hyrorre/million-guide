# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://million.hyrorre.com"
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  latest = Date.new(2000, 1, 1)

  # '/musics/idstr/difficulty' を追加する
  Music.find_each do |music|
    for i in 0..4 do
      filepath = "#{Rails.root}/app/assets/scores/#{music.idstr}#{i}.bms"
      exist = File.exist?(filepath)
      if exist == false
        filepath = "#{Rails.root}/app/assets/scores/#{music.idstr}#{i}.notes"
        exist = File.exist?(filepath)
      end
      if exist then
        add musics_show_path(music.idstr, i), :priority => (i * 0.2 + 0.1), :lastmod => music.updated_on
        if latest < music.updated_on then
          latest = music.updated_on
        end
      end
    end
  end

  # '/musics' を追加する
  add musics_index_path, :priority => 0.9, :changefreq => 'weekly', :lastmod => latest
end

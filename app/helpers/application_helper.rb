# app/helpers/application_helper.rb
module ApplicationHelper
	def default_meta_tags
	{
		site: 'ミリシタ譜面ビューア',
		title: '',
		reverse: true,
		charset: 'utf-8',
		description: 'アイドルマスター ミリオンライブ！シアターデイズ(ミリシタ)の音ゲー譜面を見やすく表示します。譜面確認にどうぞ。',
		keywords: 'ミリシタ,譜面確認,アイドルマスター,ミリオンライブ',
		canonical: request.original_url,
		separator: '|',
		icon: [
			{ href: image_url('musictypes/3.png') },
		],
		og: {
			site_name: 'ミリシタ譜面ビューア',
			title: 'ミリシタ譜面ビューア',
			description: 'アイドルマスター ミリオンライブ！シアターデイズ(ミリシタ)の音ゲー譜面を見やすく表示します。譜面確認にどうぞ。',
			type: 'website',
			url: request.original_url,
			image: image_url('musictypes/3.png'),
			locale: 'ja_JP',
		},
		twitter: {
			card: 'summary',
			site: '@MillionScore',
			creator: '@hyrorre',
		}
	}
  end
end
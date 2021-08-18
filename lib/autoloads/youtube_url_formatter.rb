class YoutubeUrlFormatter
  #iframeタグのsrc属性のURLを取得するための正規表現
  SRC_REGEX = /sec\s*=\s*"([^"]*)"/
  #URLから動画IDを取得するための正規表現
  YOUTUBE_ID_REGEX = %r{\A(?:http(?:s)?://)?(?:www\.)?(?:m\.)?(?:youtu\.be/|youtube\.com/(?:(?:watch)?\?(?:.*&)?v(?:i)?=|(?:embed|v|vi|user)/))([^?&"'>]+)(&t=.*)?\z}

  def self.format(url)
    # YouTube の埋め込み用 iframe である場合は src 属性のURLに置き換える
    src_match = SRC_REGEX.match(url)
    url = src_match[1] if src_match
    # YouTube の動画である場合は 埋め込み用URL を戻り値とする
    # そうでない場合は nil を返す
    youtube_id_match = YOUTUBE_ID_REGEX.match(url)
    if youtube_id_match
      "https://www.youtube.com/embed/#{youtube_id_match[1]}"
    end
  end
end
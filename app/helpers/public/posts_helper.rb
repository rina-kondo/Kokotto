module Public::PostsHelper
  def image_assets(category)
    Dir.glob("app/assets/images/tag/#{category}/*").map do |tag|
      tag.split('/')[-3..-1].join('/')
    end
  end
end

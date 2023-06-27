module Public::PostsHelper
  def image_assets(category)
    Dir.glob("app/assets/images/tag/#{category}/*").map do |tag|
      tag.split('/')[-3..-1].join('/')
    end
  end

  def display_image_tags(asset_name, size: "100x100")
    image_assets(asset_name).each do |tag|
      concat(image_tag(tag, size: size, class: "tag #{tag.split('/').pop().split('.')[0]}"))
    end
  end
end

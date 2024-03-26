module ArticlesHelper
  def resize_image_tag(image_path, width, height)
    image_tag image_path, style: "width: #{width}px; height: #{height}px;"
  end
end

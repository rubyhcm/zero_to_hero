class GenerateQr < ApplicationService
  attr_reader :article

  # se tao ra phuong thuc article de truy xuat gia tri cua @article,
  # phuong thuc nay duoc su dung ben duoi  article.qr_code.attach(blob)

  def initialize(article)
    super()
    @article = article
  end

  include Rails.application.routes.url_helpers

  require 'rqrcode'

  def call
    png = generate_qr_code_image
    image_name = SecureRandom.hex

    IO.binwrite("tmp/#{image_name}.png", png.to_s)

    blob = ActiveStorage::Blob.create_and_upload!(
      io: File.open("tmp/#{image_name}.png"),
      filename: image_name,
      content_type: 'png'
    )

    article.qr_code.attach(blob)
  end

  private

  def generate_qr_url
    # url_for(controller: 'articles', action: 'show', id: article.id, only_path: false,
    #         host: 'superails.com', protocol: 'https', source: 'from_qr')
    'https://github.com/rubyhcm'
  end

  def generate_qr_code_image
    qr_url = generate_qr_url
    qrcode = RQRCode::QRCode.new(qr_url)
    qrcode.as_png(bit_depth: 1, border_modules: 4, color_mode: ChunkyPNG::COLOR_GRAYSCALE,
                  color: 'black', fill: 'white', module_px_size: 6, size: 120)
  end
end

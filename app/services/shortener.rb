class Shortener
  def self.call(original)
    short = SecureRandom.alphanumeric(5)
    url = Url.find_by(short:)

    while url.present?
      short = SecureRandom.alphanumeric(5)
      url = Url.find_by(short:)
    end
    Url.create!(original:, short:)
  end
end

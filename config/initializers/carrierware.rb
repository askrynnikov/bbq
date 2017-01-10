require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id:     ENV['S3_ACCESS_key'],
      aws_secret_access_key: ENV['S3_ACCESS_key']
    }

    config.fog_directory = ENV['S3_BUCKET_NAME']
  end
end
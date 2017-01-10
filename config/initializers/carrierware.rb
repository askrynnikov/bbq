require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    # config.fog_provider = 'fog/aws'

    config.fog_credentials = {
      provider: 'AWS',
      region:                'us-west-2',
      # region:                'Oregon',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }

    config.fog_directory = ENV['S3_BUCKET_NAME']
  end
end
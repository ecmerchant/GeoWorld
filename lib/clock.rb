require 'clockwork'
require './config/boot'
require './config/environment'

Bundler.require

include Clockwork

every(3.minutes, 'feeds.refresh') { FeedUploadJob.perform_later("murakami@ec-merchant.com","出品削除") }

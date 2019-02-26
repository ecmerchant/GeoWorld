require 'clockwork'
require './config/boot'
require './config/environment'

Bundler.require

include Clockwork

tg = Schedule.find_by(user: "murakami@ec-merchant.com", schedule_num: 1)
if tg == nil then return end
p tg.schedule_type
p tg.list_type
p tg.set_time

if tg.schedule_type =="平日" then
  
end

#every(3.minutes, 'feeds.refresh') { FeedUploadJob.perform_later("murakami@ec-merchant.com","出品削除") }

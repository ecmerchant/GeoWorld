require 'clockwork'
require './config/boot'
require './config/environment'

Bundler.require

include Clockwork

user = "murakami@ec-merchant.com"

targets = Schedule.where(user: user)

targets.each do |tg|

  list_type = tg.list_type

  if list_type != nil then
    stime = tg.set_time.strftime('%H:%M')

    case tg.schedule_type
    when "平日"
      if Date.today.sunday? != true && Date.today.saturday? != true then
        every(1.day, 'listing.job', :at => stime) do
          FeedUploadJob.perform_later(user, list_type)
        end
      end

    when "毎日"
      every(1.day, 'listing.job', :at => stime) do
        FeedUploadJob.perform_later(user, list_type)
      end

    when "月曜日"
      if Date.today.monday? then
        every(1.day, 'listing.job', :at => stime) do
          FeedUploadJob.perform_later(user, list_type)
        end
      end

    when "火曜日"
      if Date.today.tuesday? then
        every(1.day, 'listing.job', :at => stime) do
          FeedUploadJob.perform_later(user, list_type)
        end
      end

    when "水曜日"
      if Date.today.wednesday? then
        every(1.day, 'listing.job', :at => stime) do
          FeedUploadJob.perform_later(user, list_type)
        end
      end

    when "木曜日"
      if Date.today.thursday? then
        every(1.day, 'listing.job', :at => stime) do
          FeedUploadJob.perform_later(user, list_type)
        end
      end

    when "金曜日"
      if Date.today.friday? then
        every(1.day, 'listing.job', :at => stime) do
          FeedUploadJob.perform_later(user, list_type)
        end
      end

    when "土曜日"
      if Date.today.saturday? then
        every(1.day, 'listing.job', :at => stime) do
          FeedUploadJob.perform_later(user, list_type)
        end
      end

    when "日曜日"
      if Date.today.sunday? then
        every(1.day, 'listing.job', :at => stime) do
          FeedUploadJob.perform_later(user, list_type)
        end
      end
    end
  end

end

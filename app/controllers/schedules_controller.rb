class SchedulesController < ApplicationController

  require 'net/https'
  require "uri"

  def setup
    @login_user = current_user
    user = current_user.email
    @schedules = Schedule.where(user: user)

    if request.post? then
      logger.debug('----------------------')
      stype = params[:schedule_type]
      stime = params[:set_time]
      ltype = params[:list_type]
      lnum = params[:list_num]

      for int in 1..10 do
        logger.debug(int)
        logger.debug(stime[int.to_s].values)
        #if ltype[int.to_s] != "" && ltype[int.to_s] != nil then
          tag = @schedules.find_or_create_by(
            schedule_num: int
          )
          tt = stime[int.to_s].values
          tag.update(
            list_type: ltype[int.to_s],
            list_num: lnum[int.to_s].to_i,
            schedule_type: stype[int.to_s],
            set_time: Time.new(tt[0].to_i, tt[1].to_i, tt[2].to_i, tt[3].to_i, tt[4].to_i)
          )
        #end
      end

      #Heroku APIでclock processを再起動
      api_key = ENV['HEROKU_API_KEY']
      endpoint = 'https://api.heroku.com/apps/'
      url = endpoint + 'geo-world/dynos/clock.1'

      api_header = {
        'Authorization': 'Bearer ' + api_key,
        'Accept': 'application/vnd.heroku+json; version=3',
        'Content-Type': 'application/json'
      }

      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Delete.new(uri, api_header)
      res = http.request(req)

      redirect_to schedules_setup_path
    end
  end

end

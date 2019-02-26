class SchedulesController < ApplicationController

  def setup
    @login_user = current_user
    user = current_user.email
    @schedules = Schedule.where(user: user)

    if request.post? then
      logger.debug('----------------------')
      stype = params[:schedule_type]
      stime = params[:set_time]
      ltype = params[:list_type]

      for int in 1..10 do
        logger.debug(int)
        logger.debug(stime[int.to_s].values)
        if ltype[int.to_s] != "" && ltype[int.to_s] != nil then
          tag = @schedules.find_or_create_by(
            schedule_num: int
          )
          tt = stime[int.to_s].values
          tag.update(
            list_type: ltype[int.to_s],
            schedule_type: stype[int.to_s],
            set_time: Time.new(tt[0].to_i, tt[1].to_i, tt[2].to_i, tt[3].to_i, tt[4].to_i)
          )
        end
      end
      redirect_to schedules_setup_path
    end
  end

end

class ListsController < ApplicationController

  def setup
    @login_user = current_user
    user = current_user.email

    @account = Account.find_or_create_by(user: user)
    if @account.list_num == nil then
      @account.update(list_num: 1)
    end
    if @account.list_type == nil then
      @account.update(list_type: '新規出品')
    end

    @reg_new = List.where(user: user, list_type: '新規出品').where.not(body: nil).pluck(:list_num)
    @not_new = [1,2,3,4,5,6,7,8,9,10] - @reg_new
    @select_new = @account.select_new
    @reg_del = List.where(user: user, list_type: '出品削除').where.not(body: nil).pluck(:list_num)
    @not_del = [1,2,3,4,5,6,7,8,9,10] - @reg_del
    @select_del = @account.select_del

    @list_num = @account.list_num
    @list_type = @account.list_type

    @list = List.find_or_create_by(user: user, list_type: @list_type, list_num: @list_num)
    @comment = nil
    if @list.body != nil then
      buf = @list.body
      @body = Array.new

      rows = buf.split("\n")
      rows.each_with_index do |row, index|
        bb = Array.new
        cols = row.split("\t")
        cols.each do |col|
          bb.push(col)
        end
        @body.push(bb)
        if index > 999 then
          @comment = '※SKUが1000件以上のため1000件目以降は省略しています'
          break
        end
      end
    else
      @body = Array.new(10).map{Array.new(10, " ")}
      logger.debug(@body)
    end
    if request.post? then
      data = params[:list_data]
      list_type = params[:list_type]
      list_num = params[:list_num].to_i
      if data != nil then
        ext = File.extname(data.path)
        if ext == ".txt" then
          File.open(data.path, 'r', encoding: 'Windows-31J', undef: :replace, replace: '*') do |file|
            body = file.read
            t = List.find_or_create_by(user: user, list_type: list_type, list_num: list_num)
            t.update(
              body: body,
            )
          end
          @account.update(
            list_num: list_num,
            list_type: list_type
          )
        end
      else
        if params[:commit] == "実行データ選択" then
          if list_type == "新規出品" then
            @account.update(
              select_new: list_num
            )
          else
            @account.update(
              select_del: list_num
            )
          end
        else
          @account.update(
            list_num: list_num,
            list_type: list_type
          )
        end
      end
      redirect_to lists_setup_path
    end

  end

end

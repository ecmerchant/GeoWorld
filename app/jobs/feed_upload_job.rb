class FeedUploadJob < ApplicationJob
  queue_as :feed_upload

  def perform(user, list_type)
    account = Account.find_by(user: user)
    if account == nil then return end
    if list_type == "新規出品" then
      list_num = account.select_new
    else
      list_num = account.select_del
    end
    body = List.find_by(user: user, list_type: list_type, list_num: list_num).body
    if body == nil then return end
    List.upload(user, body, list_type)
  end
end

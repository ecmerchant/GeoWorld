namespace :task_upload do
  desc "データのアップロード"
  task :operate, ['user', 'list_type', 'list_num'] => :environment do |task, args|
    user = args[:user]
    list_type = args[:list_type]
    list_num = args[:list_num]
    FeedUploadJob.perform_later(user, list_type, list_num)
  end
end

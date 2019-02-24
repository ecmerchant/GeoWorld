namespace :task_upload do
  desc "データのアップロード"
  task :operate, ['user', 'list_type'] => :environment do |task, args|
    user = args[:user]
    list_type = args[:list_type]
    FeedUploadJob.perform_later(user, list_type)
  end
end

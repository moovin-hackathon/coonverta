class SendNotificationWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(phone_number, message)
    sns = Aws::SNS::Client.new(
      region: 'us-east-1', 
      access_key_id: ENV['AWS_ACCESS_KEY'], 
      secret_access_key: ENV['AWS_SECRET_KEY'])

    sns.publish({phone_number: "55#{phone_number}", message: message})
  end

end
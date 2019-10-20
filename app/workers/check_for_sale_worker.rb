class CheckForSaleWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'sale'

  def perform(user_id)
    user = User.find(user_id)
    sales_to_apply = Sale.where('reward_points <= ?', user.reward_points).where.not(id: user.sales.pluck(:id))
    sales_to_apply.each { |sale| UserSale.create(user: user, sale: sale) }
  end

end
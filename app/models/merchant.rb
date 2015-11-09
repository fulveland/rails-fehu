class Merchant < ActiveRecord::Base
  has_many :orders
  # TODO: Add a has_one for the current order
  
  validates :email, :phone_number, :store_name, :your_name, { presence: true }
  validates :email, { uniqueness: { case_sensitive: false } }
  validates :email, { format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ } }
  
  def current_order
    orders.find_by_id(current_order_id)
  end
  
  def current_order=(order)
    if order.present?
      self.current_order_id = order.id
    end
  end
end

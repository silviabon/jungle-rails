class Notifier < ApplicationMailer
  default from: 'no-reply@jungle.com',
          return_path: 'system@jungle.com'

  def order_receipt(order)
    @order = order
    mail(to: order.email, subject: "Order #{@order.id}") 
  end

end

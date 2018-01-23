class OrderMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'

  def received(order)
    @order = order
    mail to: order.email, subject: 'My Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  #def received
    #@greeting = "Hi"

    #mail to: "to@example.org"
  #end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email, subject: 'GeekHub My Store Order Shipped'
  end
  #def shipped
    #@greeting = "Hi"

    #mail to: "to@example.org"
 # end
end
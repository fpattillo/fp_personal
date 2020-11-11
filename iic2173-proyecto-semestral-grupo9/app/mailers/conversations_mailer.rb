class ConversationsMailer < ApplicationMailer
  def new_order_email
    @content = params[:params][:content]
    @from = params[:params][:user_email]
    mail(to: params[:email], subject: "¡Has sido etiquetado!")
  end
end

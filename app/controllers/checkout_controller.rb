class CheckoutController < ApplicationController
  

  def create
    @total = params[:total].to_d
    @event_id = params[:event_id]
    
    # Vérifier que les paramètres sont correctement extraits
    # puts "Total: #{@total}"
    # puts "Event ID: #{@event_id}"
  
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total * 100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        }
      ],
      metadata: {
        event_id: params[:event_id]
      },
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
  
    redirect_to @session.url, allow_other_host: true
  end


  def success
    session_id = params[:session_id]
    #begin
      @session = Stripe::Checkout::Session.retrieve(session_id)
      @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
      @event_id = @session.metadata.event_id

      # Créer une attendance
      @attendance = Attendance.create(user_id: current_user.id, event_id: @event_id)
      flash[:notice] = "La commande a été validée."

      # Charger l'événement associé au paiement
      @event = Event.find(@event_id)      
      
    # rescue Stripe::InvalidRequestError => e
    #   # Gérer les erreurs, par exemple rediriger l'utilisateur vers une page d'erreur
    #   flash[:error] = "Une erreur est survenue lors de la récupération des informations de paiement."
      
    # end
  end

  def cancel
    # Logique pour l'annulation de la commande
    # Vous pouvez gérer ici les actions à entreprendre en cas d'annulation de paiement
    flash[:notice] = "La commande a été annulée."
    
  end
end


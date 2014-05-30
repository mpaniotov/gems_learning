class BraintreesController < ApplicationController
  def index
    @result = Braintree::Transaction.sale(
        :amount => "1000.00",
        :credit_card => {
            :number => "5105105105105100",
            :expiration_month => "05",
            :expiration_year => "12"
        }
    )
  end
end

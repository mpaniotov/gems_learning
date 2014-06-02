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

  def customer_create
    @result = Braintree::Customer.create(
        :credit_card => {
            :number => "5105105105105100",
            :expiration_date => "05/2020",
            :billing_address => {
                :first_name => "Charity",
                :last_name => "Smith",
                :street_address => "1 E Main St",
                :extended_address => "Suite 3",
                :locality => "Chicago",
                :region => "Illinois",
                :postal_code => "60622",
                :country_code_alpha2 => "US"
            }
        }
    )
  end
end

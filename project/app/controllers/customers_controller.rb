class CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def upload
    file = params["csv"].tempfile.path
    File.open(file).each do |column|

      column = column.split(";")

      next if column[0] == "purchaser name"

      purchaser_name = column[0].strip rescue column[0]
      item_description = column[1].strip rescue column[1]
      item_price = column[2].strip rescue column[2]
      purchase_count = column[3].strip rescue column[3]
      merchant_address = column[4].strip rescue column[4]
      merchant_name = column[5].strip rescue column[5]

      Customer.create(purchaser_name: purchaser_name, item_description: item_description, item_price: item_price, purchase_count: purchase_count, merchant_address: merchant_address, merchant_name: merchant_name)

    end
    redirect_to root_path
    flash[:notice] = "Produtos cadastrados com sucesso!!"
  end


#private
#def customer_params
#  params.require(:customer).permit(:purchaser_name,	:item_description, :item_price, :purchase_count, :merchant_address, :merchant_name)
#end
end

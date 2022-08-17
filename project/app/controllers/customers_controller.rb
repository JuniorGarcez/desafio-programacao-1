class CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def new
  @customer = Customer.new
  end

  def destroy
  @customer = Customer.find(params[:id])
  @customer.destroy
  redirect_to customers_path
  end

  def upload

    if params["csv"]

      file = params["csv"].tempfile.path
      row = CSV.parse(File.open(file), headers: true, return_headers: false, col_sep: "\t")
      row.each do |r|

        purchaser_name = r["purchaser name"]
        item_description = r["item description"]
        item_price = r["item price"]
        purchase_count = r["purchase count"]
        merchant_address = r["merchant address"]
        merchant_name = r["merchant name"]

        @customer = Customer.create(purchaser_name: purchaser_name, item_description: item_description, item_price: item_price, purchase_count: purchase_count, merchant_address: merchant_address, merchant_name: merchant_name)
        @customer.save

      end
      flash[:notice] = "Produtos cadastrados com sucesso!!"
      redirect_to customers_path
    else
      flash[:alert] = "Selecione o arquivo de Upload!!"
      redirect_to customers_path
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  #private
  #def customer_params
  #  params.require(:customers).permit(:purchaser_name,	:item_description, :item_price, :purchase_count, :merchant_address, :merchant_name)
  #end
end

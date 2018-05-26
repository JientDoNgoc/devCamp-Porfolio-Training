class PorfoliosController < ApplicationController
    def index
    @porfolio_items = Porfolio.all 
    end
    def new
    @porfolio_items = Porfolio.new
    end
    
    def create
    @porfolio_items = Porfolio.new(params.require(:porfolio).permit(:title, :subtitle, :body))

    respond_to do |format|
      if @porfolio_items.save
        format.html { redirect_to porfolios_path, notice: 'Porfolio item is now live.' }
      else
        format.html { render :new }
      end
    end
    end

end

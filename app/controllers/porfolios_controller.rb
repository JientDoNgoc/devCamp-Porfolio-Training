class PorfoliosController < ApplicationController
  before_action :set_porfolio_item, only: [:edit, :show, :update, :destroy]
  layout "porfolio"
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit, :sort]}, site_admin: :all
  
    def index
    @porfolio_items = Porfolio.by_position
    end
    
    def sort
      params[:order].each do |key, value|
        Porfolio.find(value[:id]).update(position: value[:position])
      end
      render nothing: true
    end
    
    def angular
    @angular_portfolio_items = Porfolio.angular
    end
    
    def new
    @porfolio_item = Porfolio.new
    end
    
    def create
    @porfolio_item = Porfolio.new(porfolio_params)
    
    respond_to do |format|
      if @porfolio_item.save
        format.html { redirect_to porfolios_path, notice: 'Porfolio item is now live.' }
      else
        format.html { render :new }
      end
    end
    end
    
    def edit
    @porfolio_item = Porfolio.find(params[:id])
    end
    
    def update
    @porfolio_item = Porfolio.find(params[:id])    

    respond_to do |format|
      if @porfolio_item.update(porfolio_params)
        format.html { redirect_to porfolios_path, notice: 'Your portfolio item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
    end
    
    def show
    @porfolio_item = Porfolio.find(params[:id])    
    end

    def destroy
    @porfolio_item = Porfolio.find(params[:id])
    
    @porfolio_item.destroy
        respond_to do |format|
          format.html { redirect_to porfolios_path, notice: 'Your portfolio item successfully destroyed.' }
          format.json { head :no_content }
        end
    end
    
    private 
    def porfolio_params
      params.require(:porfolio).permit(:title, 
                                       :subtitle,
                                       :body,
                                       :main_image,
                                       :thumb_image,
                                       technologies_attributes: [:id, :name, :_destroy])
    end
    
    def set_porfolio_item
      @porfolio_item = Porfolio.find(params[:id])
    end
  
end
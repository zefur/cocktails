class DosesController < ApplicationController
    before_action :set_default, except: :destroy
   

    def create
        @dose = Dose.new(dose_params)
        @dose.cocktail = @cocktail

        if @dose.save
            redirect_to cocktail_path(@cocktail)
        else
            render 'new'
        end
    end

    def show
        @dose = Dose.find(params[:cocktail_id])
    end

    def destroy
        
        @dose = Dose.find(params[:id])
        
        @dose.destroy
        redirect_to cocktail_path(@dose.cocktail)
    end

    private

    def dose_params
        params.require(:dose).permit(:description, :ingredient_id)
    end
    def set_default
        @cocktail = Cocktail.find(params[:cocktail_id])
    end
end

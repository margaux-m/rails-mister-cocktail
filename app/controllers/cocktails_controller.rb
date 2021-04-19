class CocktailsController < ApplicationController
  def index
    @home_page = true
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    cocktail = Cocktail.new(cocktail_params)
    capitalized_name = cocktail.name.split.map do |word|
      word.capitalize
    end
    cocktail.name = capitalized_name.join(' ')
    cocktail.save
    redirect_to cocktail_path(cocktail)
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end

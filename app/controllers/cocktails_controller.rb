class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :edit]

  def index
    @home_page = true

    if params[:query].present?
      sql_query = " \
        cocktails.name ILIKE :query \
        OR ingredients.name ILIKE :query \
      "
      @cocktails = Cocktail.joins(:ingredients).where(sql_query, query: "%#{params[:query]}%")
      @placeholder = params[:query]
    else
      @cocktails = Cocktail.all
      @placeholder = 'Search for a cocktail'
    end
  end

  def show
    @dose = Dose.new
    @review = Review.new
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

  def edit; end

  def update
    cocktail = Cocktail.find(params[:id])
    cocktail&.update(cocktail_params)
    redirect_to cocktail_path(cocktail)
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end

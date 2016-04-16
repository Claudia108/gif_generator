class Admin::CategoriesController < Admin::BaseController

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:create] = "Category successfully created."
      redirect_to admin_category_path(@category.id)
    else
      flash[:error] = "Please try again."
      render :new
    end

    def show
      @category = Category.find(params[:id])
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end

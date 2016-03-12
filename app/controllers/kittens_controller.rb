class KittensController < ApplicationController
  def new
    @kitten = Kitten.new
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render json: @kitten}
    end
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:notice] = 'This kitten has been successfully created'
      redirect_to @kitten
    else
      render :new
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def destroy
    Kitten.find(params[:id]).destroy
    flash[:notice] = "Kitten deleted" 
    redirect_to kittens_path
  end

  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json {render json: @kittens}
    end
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes kitten_params
      flash[:notice] = 'The Kitten is successfully updated'
      redirect_to @kitten 
    else
      render :edit
    end
  end

  private

    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end

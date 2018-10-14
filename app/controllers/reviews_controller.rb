class ReviewsController < ApplicationController
   before_action :authenticate

  def new
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id

    if @review.save
    flash[:notice] = 'Review was successfully created.'
    redirect_to product_path(@product)
    else
      flash[:notice] = "Error creating review: #{@review.errors}"
      redirect_to product_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    redirect_to product_path(@product)
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description,
    )
  end

  def authenticate
    if current_user == nil
      redirect_to '/'
    end
  end

end

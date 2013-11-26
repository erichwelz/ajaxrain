class ReviewsController < ApplicationController
  before_filter :load_product
  before_filter :ensure_logged_in, :only => [:edit, :create, :show, :update, :destroy]

  def show
  @review = Review.find(params[:id])
  end

  def create


    #params.require(:review).permit(:comment, :product_id)
    #@review = @product.reviews.build(review_params)
    @review = Review.new( 
      :comment => params[:review][:comment],
      :product_id => @product.id,
      :user_id => current_user.id
      )

    #@review.user_id = current_user.id

    if @review.save
      redirect_to product_path(@product), notice: 'Review created successfully'
    else
      render :action => :show
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to product_path(@product)
  end

  def new
  @review = Review.new
  end

  def update
    @review = Review.find(params[:id])

    if @review.update_attributes(review_params)
      redirect_to product_review_path
    else
      render :edit
    end
  end


  def edit
    @review = Review.find(params[:id])
  end

  private
  def review_params
    params.require(:review).permit(:comment, :product_id)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end

end

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
  respond_to do |format|
      if @review.save
        format.html { redirect_to product_path(@product.id), notice: 'Review added' }
        format.js {} # This will look for /views/reviews/create.js.erb
        #redirect_to product_path(@product), notice: 'Review created successfully'
      else
        #render :action => :show
        format.html { render "products/show", notice: 'There was an error.'}
        format.js {} # This will look for /views/reviews/create.js.erb
      end
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

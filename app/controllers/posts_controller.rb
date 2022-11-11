class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only:[:edit, :update, :destroy]

    def index
      @posts = Post.order(created_at: :desc)
    end

    def new
      @post = Post.new
      
    end

    def create
      @post = Post.new(post_params)
      @post.user = current_user
      if @post.save
        flash[:success] = "Post successfully created"
        redirect_to @post
      else
        flash[:error] = "Something went wrong"
        render 'new'
      end
    end
    
    def show
      @comment = Comment.new
    end

    def edit
      
    end

    def update
      if @post.update(post_params)
          flash[:success] = "Post successfully updated"
          redirect_to @post
        else
          flash[:error] = "Something went wrong"
          render :edit  
        end
    end  
    
    def destroy
      @post.destroy
      redirect_to posts_path
    end
    
    private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def find_post
        @post = Post.find params[:id]
    end

    def authorize_user!
      redirect_to root_path, alert: "Not authorized!" unless can?(:crud, @post)
    end

end

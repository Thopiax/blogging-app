# Below is a class controlling the creation, presentation
# and deletion of messages
class PostsController < ApplicationController
  before_action :set_posts, only: [:index, :create]

  def index
    @post = Post.new
  end

  def create
    @post = Post.new(post_content)
    respond_to do |format|
      format.html do
        if @post.save
          redirect_to posts_path, notice: 'Success! Your post has been created.'
        else
          render action: 'index', error: 'Oh no! Something went wrong.'
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path,
                notice: 'Success! You\'ll never see that post again.'
  end

  private

  def set_posts
    # define this variable for the root path and after creating a new message
    @posts = Post.all
  end

  def post_content
    params.require(:post).permit(:message)
  end
end

# Below is a class controlling the creation, presentation
# and deletion of messages
class PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all()
  end

  def create
    @post = Post.new(post_content)
    respond_to do |format|
      if @post.save
        format.html do
          redirect_to posts_path, notice: "Successufully created your post!" 
        end
      else
        format.html do
          @posts = Post.all
          flash.now[:error] = 'Couldn\'t create the post!'
          render action: 'index'
        end
      end
    end
  end

  def destroy
    @post.destroy

  end

  private

  def post_content
    params.require(:post).permit(:message)
  end
end

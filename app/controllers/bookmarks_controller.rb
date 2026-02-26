class BookmarksController < ApplicationController
  before_action :set_list, only: %i[new create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list

    # Check if movie is already in the list
    if @list.bookmarks.exists?(movie_id: @bookmark.movie_id)
      @bookmark.errors.add(:movie_id, "est déjà dans cette liste")
      # Reset fields so the form is cleared
      @bookmark.movie_id = nil
      @bookmark.comment = nil
      render :new, status: :unprocessable_entity
    elsif @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end

class BooksController < ApplicationController

 before_action :ensure_correct_user, only: [:edit]
  def show
    @book = Book.new
    @show_book = Book.find(params[:id])
    @assosiate_user = @book.user
    @user = current_user
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @user = current_user
    @book = Book.new
    @save_book = Book.new(book_params)
    @books = Book.all
    if @save_book.save
      redirect_to book_path(@save_book), notice: "You have created book successfully."
    else
      @books = Book.all
      flash[:danger] = "error"
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      flash[:danger] = "error"
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end

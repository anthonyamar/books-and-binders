class StaticPagesController < ApplicationController
  def home
    @books = current_user.books
    @facade = BookFacade.new(current_user)
  end
end

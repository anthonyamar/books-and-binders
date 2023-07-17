class StaticPagesController < ApplicationController
  
  def home
    if user_signed_in?
      @books = current_user&.books
      @facade = BookFacade.new(current_user)
    end
  end
  
end
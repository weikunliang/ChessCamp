class HomeController < ApplicationController
  def index
  	@camps = Camp.all.paginate(:page => params[:page]).per_page(10)
  	@families = Family.all.paginate(:page => params[:page]).per_page(10)
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def year
    @camps = Camp.all.paginate(:page => params[:page]).per_page(10)
  end
  
end

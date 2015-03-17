class QueriesController < ApplicationController
  before_action :authenticate_user!

  expose(:queries)
  expose(:query, attributes: :query_params)

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    GoogleSearch.new.perform(params[:query][:name], current_user.id)
    redirect_to root_path, notice: 'Query was successfully created.'
  end

  def update
    if query.update(query_params)
      redirect_to query, notice: 'Query was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    query.destroy
    redirect_to queries_url, notice: 'Query was successfully destroyed.'
  end

  private
    def query_params
      params.require(:query).permit(:name)
    end
end

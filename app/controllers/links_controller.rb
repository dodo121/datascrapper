class LinksController < ApplicationController
  expose(:links)
  expose(:link, attributes: :link_params)

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if link.save
      redirect_to link, notice: 'Link was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if link.update(link_params)
      redirect_to link, notice: 'Link was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    link.destroy
    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end

  private
    def link_params
      params.require(:link).permit(:name, :url)
    end
end

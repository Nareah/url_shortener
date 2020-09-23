class UrlsController < ApplicationController

  def index
    @urls= Url.all
    @urls.each do |url|
      #details = url.url_details
      details = UrlDetails.where(url_id: url.id)
      url.no_of_visits = details.count
      url.ip_address = details.empty?? "" : details.last.ip_address
      url.countries = details.map(&:country).uniq
    end
  end

  def new
    @url = Url.new
    respond_to do |format|
      format.html
    end
  end

  def show
    @url= Url.where(short_url: params[:short_url])[0]
    if @url.present?
      if Date.today-30.days <= @url.created_at.to_date
        @url.create_url_details
        redirect_to @url.original_url
      else
        raise ActionController::RoutingError.new('404')
      end
    else
      raise ActionController::RoutingError.new('URL Not Found')
    end
  end

  def create
    params[:url][:short_url] =([*('a'..'z'),*('1'..'9')]).sample(5).join
    @url=Url.create(params[:url])
    respond_to do |format|
      format.js {}
    end
  end

private
  def url_params
    params.require(:url).permit(:original_url, :short_url, :ip_address)
  end
end

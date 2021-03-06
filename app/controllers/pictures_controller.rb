class PicturesController < ApplicationController
	
	def index
		@most_recent_pictures = Picture.most_recent_five
		@total = Picture.created_before(1.month.ago).count
		@one_month_ago = Picture.created_before(1.month.ago)
	end

	def show
		@picture = Picture.find(params[:id])
	end

	def new
		@picture = Picture.new
	end

	def edit
		@picture = Picture.find(params[:id])
	end

	def update
		@picture = Picture.find(params[:id])

		if @picture.update_attributes(picture_params)
			redirect_to "/pictures/#{@picture.id}"
		else 
			render :edit
		end
	end

	def create
		@picture = Picture.new(picture_params)
		if @picture.save
			redirect_to pictures_url
		else
			render :new
		end
		# render :text => "Saving a picture. URL: #{params[:url]}, Title: #{params[:title]}, Artist: #{params[:artist]}"
	end

	def destroy
		@picture = Picture.find(params[:id])
		@picture.destroy
		redirect_to pictures_url
	end
	
	private
	def picture_params
		params.require(:picture).permit(:artist, :title, :url)
	end

end


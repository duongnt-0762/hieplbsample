class MicropostsController < ApplicationController

	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		@micropost.image.attach(params[:micropost][:image])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to help_path
		else

			@feed_items = current_user.feed.order_by_time.paginate(page: params[:page])
			render 'static_pages/help'
		end
	end
	def destroy
		@micropost.destroy
		flash[:success] = "Micropost deleted"
		redirect_to request.referrer || root_url
	end

	private

	def micropost_params
		params.require(:micropost).permit(:content, :image)
	end
	def correct_user
		 @micropost = Micropost.find_by(id: params[:id])
		redirect_to root_url if !current_user.current_user?(@micropost.user)
	end
end

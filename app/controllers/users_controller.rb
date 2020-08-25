class UsersController < ApplicationController
	before_action :logged_in_user, only: [:show, :index, :edit, :update, :destroy]
	before_action :check_logged_in, only: :new
	before_action :find_user, only: [:show, :edit,:update, :correct_user, :destroy]	
	before_action :correct_user,only: [:edit, :update]
	before_action :admin_user,only: :destroy
	

	def index
		@users = User.paginate(page: params[:page])
	end
  	def show
  		@follow = current_user.active_relationships.build
  		@unfollow = current_user.active_relationships.find_by(followed_id: @user.id)
  		@microposts = @user.microposts.order_by_time.paginate(page: params[:page])
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to root_url
		else
			render 'new'
		end

	end
	def edit
	end	

	def update
		if @user.update(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		# Handle a successful update.
		else
			render 'edit'
		end
	end


	def destroy
		@user.destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end	
	
	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.following.paginate(page: params[:page])
		render 'show_follow'
	end
	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end
	
	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :sinhnhat, :diachi, :gioitinh)
	end
	
	def correct_user
		if !current_user.current_user?(@user)
			flash[:danger] = "không được phép sửa user của người khác"
			redirect_to @user
		end	
	end
	def check_logged_in
		if logged_in?
			flash[:success] = "you are logging"
			redirect_to root_path 
		end
	end
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
	def find_user
		@user = User.find_by id:params[:id]	
		if  @user.nil?
			flash[:danger] = "đã tạo tài khoản này đéo đâu mà đòi xem"
			redirect_to	root_path
		end
	end	
end

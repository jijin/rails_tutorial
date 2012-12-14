class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]# 防止未登陆后修改信息
  before_filter :correct_user, :only => [:edit, :update]# 防止登陆后修改别人的信息
	
  def index
    @users = User.all 
    @title = "All users"
  end

  def show
		@user = User.find(params[:id])
		@title = @user.name
	end

  def new
  	@user = User.new
  	@title = "Sign up"
  end

  def create
  	# raise params[:user].inspect
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		# flash[:success] = 'Welcome to the sample app!'
	  	redirect_to @user, :flash => { :success => "Welcome to the Sample App!" }
	  else
	  	@title = "Sign up"
	  	render 'new'
	  end
  end
  # 2012-12-12/17:00
  def edit
    # raise request.inspect
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  # 2012-12-12/19:00
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
      flash[:success] = 'Profile updated!'
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  private

  def authenticate
    # flash[:notice] = "Please sign in to access this page." 
    # redirect_to signin_path, :notice => "Please sign in to access this page." 
    deny_access unless signed_in? #将上面的方法提取到deny_access，并放置在sessions_helper.rb 里(因为controller里，application_controller.rb 引用了它  )
  end
  # 2012-12-12/20:10
  # 防止登陆后修改别人的信息
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)#sessions_helper.rb有current_user?方法
  end
end

class ProfilesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @profile = Profile.new
  end

  def create
    @user = User.find(params[:user_id])
    @profile = @user.build_profile(profile_params)

    if @profile.save
      flash[:success] = 'Your profile has been updated.'
      redirect_to user_path(params[:user_id])
    else
      flash[:warning] = 'Your profile could not be updated. Please try again.'
      render action: :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end
  
  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    
    if @profile.update_attributes(profile_params)
      flash[:success] = 'Your profile has been updated.'
      redirect_to user_path(params[:user_id])
    else
      flash[:warning] = 'Your profile could not be updated. Please try again.'
      render action: :edit
    end    
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
  end

end
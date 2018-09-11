class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:root, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: 'Logged out!')
  end
end

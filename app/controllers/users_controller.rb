class UsersController < ApplicationController

    def show
        if logged_in?
          render json: current_user
        else
          render json: { error: 'Not authorized' }, status: :unauthorized
        end
    end

    def create
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        render json: user
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end


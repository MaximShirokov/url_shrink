module ApplicationHelper
  def top_bar_except_controllers
    except_controllers = %w[users user_sessions]
    except_controllers.include? params[:controller]
  end
end

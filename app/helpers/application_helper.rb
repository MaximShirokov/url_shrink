module ApplicationHelper
  def top_bar_except_controllers
    except_controllers = %w[users user_sessions]
    except_controllers.include? params[:controller]
  end

  def date_format(date, format)
    case date
    when String
      date.to_date.strftime(format)
    when Date
      date.strftime(format)
    end
  end
end

module ApplicationHelper
  
  
  def fieldError(name, add)
    if name
      return add << " field-error"
    else
      return add
    end
  end
end

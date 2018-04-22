# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Pager
  @@COUNT = 10
  @@LIMIT = 10

  attr_accessor :record, :current, :limit, :count
  
  def initialize(record = 0, current = 1, count = 10, limit = 10)
  
    @record = record 
	
    if !current.present? || (current-1) * limit >= record || current < 1
      @current = 1
    else
      @current = current
    end
	
	@count = count.present? ? count : @@COUNT 

	@limit = limit.present? ? limit : @@LIMIT 
  end

  def get_start_num
    if @record <= 0
      start_num = 0
    else
      start_num = (@current - 1) * @limit + 1
    end
    return start_num
  end

  def get_last_num
    last_num = (@current) * @limit
    if last_num > @record
      last_num = @record
    end
    return last_num
  end

  def get_page_count
    if @record <= 0
      page_count = 0
    end
    page_count = (@record - 1) / @limit + 1
    return page_count
  end

  def is_last_page?
    return @current == get_page_count
  end

  def total_page
    (@record.to_f / @limit.to_f).ceil
  end


  def page_list
    page_array = Array.new
    start_page = 1
    if (total_page > @count)
      if (@current > @count.to_f / 2)
          start_page = @current - (@count / 2)
      end
      if (@current + @count.to_f / 2 > total_page)
          start_page = total_page - @count + 1
      end
    end
    for i in start_page ... start_page + @count
        break if i > total_page
        page_array.push(i)
    end
    page_array
  end
end

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class CuahangController < ApplicationController
  def index
    new = Cuahang.find_id(@db)
    if new.present? 
      @new = Cuahang.new(new)
    else
      @new = Cuahang.new
    end
    
    render "edit"
  end
  
  def update
    @new = Cuahang.new(params[:cuahang])
    unless @new.valid?
      render "edit"
    else
      new = Cuahang.find_id(@db)
      if new.present?
        @new.update(@db)
      else
        @new.save(@db)
      end
      redirect_to '/cuahang'
    end
  end
  
  
end

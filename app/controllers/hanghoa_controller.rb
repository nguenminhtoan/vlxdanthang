# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class HanghoaController < ApplicationController
  def index
    @list = Hanghoa.getlist(@db)
  end
  
  
  def new
    @new = Hanghoa.new
    @loai = Loaihang.getlist(@db)
    @donvi = Donvi.getlist(@db)
    
    render "new"
  end
  
  
  def edit
    new = Hanghoa.find_id(@db, params[:id])
    @new = Hanghoa.new(new)
    @loai = Loaihang.getlist(@db)
    @donvi = Donvi.getlist(@db)
    render "edit"
  end
  
  def save
    @new = Hanghoa.new(params[:hanghoa])
    unless @new.valid?
      @loai = Loaihang.getlist(@db)
      @donvi = Donvi.getlist(@db)
      render "edit"
    else
      @new.save(@db)
      redirect_to '/hanghoa'
    end
  end
  
  def update
    @new = Hanghoa.new(params[:hanghoa])
    unless @new.valid?
      @loai = Loaihang.getlist(@db)
      @donvi = Donvi.getlist(@db)
      render "edit"
    else
      @new.update(@db)
      redirect_to '/hanghoa'
    end
  end
  
  def delete
    Hanghoa.delete(@db, params[:id])
    redirect_to '/hanghoa'
  end

end

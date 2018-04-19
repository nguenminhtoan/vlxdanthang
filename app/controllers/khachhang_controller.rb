# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class KhachhangController < ApplicationController
  def index
    @list = Khachhang.getlist(@db)
    
  end
  
  def new
    @new = Khachhang.new
  end
  
  def edit
    new = Khachhang.find_id(@db, params[:id])
    @new = Khachhang.new(new)
  end
  
  def save
    @new = Khachhang.new(params[:khachhang])
    unless @new.valid?
      render "new"
    else
      @new.save(@db)
      redirect_to '/khachhang'
    end
  end
  
  def update
    @new = Khachhang.new(params[:khachhang])
    unless @new.valid?
      render "new"
    else
      @new.update(@db)
      redirect_to '/khachhang'
    end
  end
  
  def delete
    Khachhang.delete(@db, params[:id])
    redirect_to '/khachhang'
  end
  
end

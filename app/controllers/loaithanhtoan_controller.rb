# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class LoaithanhtoanController < ApplicationController
  def index
    @list = Thanhtoan.getlist(@db)
  end
  
  
  def edit 
    @new = Thanhtoan.new
    loai = Thanhtoan.getlist(@db)
    @error = []
    @list = []
    loai.each do |val|
      @list << Thanhtoan.new(val)
    end
    render "edit"
  end
  
  def save 
    loai = params[:loai]
    @error = []
    @list = []
    loai.each do |val|
      @list << Thanhtoan.new(val)
      
    end
    
    @errors = []

    @list.each do |item|
      item.valid?

      item.errors.full_messages.each do |message|
        @errors << "Mã loại #{item.id_loai} #{message}"
      end
    end

    if @errors.size > 0
      @new = Thanhtoan.new
      render 'edit'
      return
    end
	
    @list.each do |item|
      if Thanhtoan.find_id(@db, item.id_thanhtoan).present?
        item.update(@db)
      else
        item.save(@db)
      end
    end
    redirect_to "/loaithanhtoan"
  end
  
  
  def delete
    id_thanhtoan = params[:id]
    Thanhtoan.delete(@db, id_thanhtoan)
    redirect_to "/loaithanhtoan"
  end
end

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class LoaihangController < ApplicationController
  def index
    @list = Loaihang.getlist(@db)
  end
  
  
  def edit 
    @new = Loaihang.new
    loai = Loaihang.getlist(@db)
    @error = []
    @list = []
    loai.each do |val|
      @list << Loaihang.new(val)
    end
    render "edit"
  end
  
  def save 
    loai = params[:loai]
    @error = []
    @list = []
    loai.each do |val|
      @list << Loaihang.new(val)
      
    end
    
    @errors = []

    @list.each do |item|
      item.valid?

      item.errors.full_messages.each do |message|
        @errors << "Mã loại #{item.id_loai} #{message}"
      end
    end

    if @errors.size > 0
      @new = Loaihang.new
      render 'edit'
      return
    end
	
    @list.each do |item|
      if Loaihang.find_id(@db, item.id_loai).present?
        item.update(@db)
      else
        item.save(@db)
      end
    end
    redirect_to "/loaihang"
  end
  
  
  def delete
    id_loai = params[:id]
    Loaihang.delete(@db, id_loai)
    redirect_to "/loaihang"
  end
end

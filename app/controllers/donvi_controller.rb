# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class DonviController < ApplicationController
  def index
    @list = Donvi.getlist(@db)
  end
  
  def edit
    @new = Donvi.new
    loai = Donvi.getlist(@db)
    @error = []
    @list = []
    loai.each do |val|
      @list << Donvi.new(val)
    end
    render "edit"
  end
  
  def save
    donvi = params[:list]
    @error = []
    @list = []
    donvi.each do |val|
      @list << Donvi.new(val)
      
    end
    
    @errors = []

    @list.each do |item|
      item.valid?

      item.errors.full_messages.each do |message|
        @errors << "Mã loại #{item.id_donvi} #{message}"
      end
    end

    if @errors.size > 0
      @new = Donvi.new
      render 'edit'
      return
    end
	
    @list.each do |item|
      if Donvi.find_id(@db, item.id_donvi).present?
        item.update(@db)
      else
        item.save(@db)
      end
    end
    redirect_to "/donvi"
  end
  
  def delete
    id_donvi = params[:id]
    Donvi.delete(@db, id_donvi)
    redirect_to "/donvi"
  end
end

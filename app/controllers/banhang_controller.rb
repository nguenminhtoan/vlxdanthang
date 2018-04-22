# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class BanhangController < ApplicationController
  
  
  
  def index
    @search = params[:page].present? ? params[:page] : {'current'=>0,'limit'=>25, 'sort'=>'1', 'up_down'=>'ASC'}
    
    @search['up_down'] = session[:current] if session[:current].present?
    @search['limit'] = session[:limit] if session[:limit].present?
    @search['sort'] = session[:sort] if session[:sort].present?
    @search['up_down'] = session[:up_down] if session[:up_down].present?
    @list = Banhang.getlist(@db)
    
  end
  
  def new
    @list = Hanghoa.getlist(@db)
    @khachhang = Khachhang.getlist(@db)
    @thanhtoan = Thanhtoan.getlist(@db)
    @key = Banhang.autokey(@db)
    @new = Banhang.new
    @hanghoa = []
  end
  
  
  def edit
    @id_ban = params[:id]
    @list = Hanghoa.getlist(@db)
    @khachhang = Khachhang.getlist(@db)
    @thanhtoan = Thanhtoan.getlist(@db)
    @new = Banhang.new(Banhang.find_id(@db, @id_ban))
    @hanghoa = []
    list = Ctban.find_id(@db, @id_ban)
    if list.present?
      list.each do |val|
        @hanghoa << Ctban.new(val)
        @hanghoa.last.tenhang = Hanghoa.find_id(@db, val['id_hanghoa'])['tenhang']
      end
    end
  end
  
  def save
    @new = Banhang.new(params[:banhang])
    @new.id_nguoidung = @info.id_nguoidung
    @key = @new.id_ban
    @hanghoa = []
    if params[:list].present?
      params[:list].each do |val|
        @hanghoa << Ctban.new(val)
        @hanghoa.last.tenhang = Hanghoa.find_id(@db, val['id_hanghoa'])['tenhang']
      end
    end

    @errors = []

    @hanghoa.each do |item|
      item.valid?

      item.errors.full_messages.each do |message|
        @errors << "Số báo danh:#{item.id_hanghoa} #{message}"
      end
    end
    
    unless @new.valid? && @errors.count == 0
      @list = Hanghoa.getlist(@db)
      @khachhang = Khachhang.getlist(@db)
      @thanhtoan = Thanhtoan.getlist(@db)
      render "new"
    else
      @new.save(@db)
      @hanghoa.each do |item|
        item.id_cuahang = "CH1"
        item.id_ban = @key
        item.save(@db)
      end
      redirect_to "/banhang/edit/#{@new.id_ban}"
    end
  end
  
  
  def update
    @new = Banhang.new(params[:banhang])
    @key = @new.id_ban
    @hanghoa = []
    if params[:list].present?
      params[:list].each do |val|
        @hanghoa << Ctban.new(val)
        @hanghoa.last.tenhang = Hanghoa.find_id(@db, val['id_hanghoa'])['tenhang']
      end
    end

    @errors = []

    @hanghoa.each do |item|
      item.valid?

      item.errors.full_messages.each do |message|
        @errors << "Số báo danh:#{item.id_hanghoa} #{message}"
      end
    end
    
    unless @new.valid? && @errors.count == 0
      @list = Hanghoa.getlist(@db)
      @khachhang = Khachhang.getlist(@db)
      @thanhtoan = Thanhtoan.getlist(@db)
      render "new"
    else
      @new.update(@db)
      Ctban.delete(@db, @key)
      @hanghoa.each do |item|
        item.id_cuahang = "CH1"
        item.id_ban = @key
        item.save(@db)
      end
      redirect_to "/banhang"
    end
  end
  
end

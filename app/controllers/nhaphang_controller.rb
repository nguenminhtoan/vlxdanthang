# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class NhaphangController < ApplicationController
  
  def index
    @search = params[:page].present? ? params[:page] : {'current'=>0,'limit'=>25, 'sort'=>'1', 'up_down'=>'ASC'}
    
    @search['up_down'] = session[:current] if session[:current].present?
    @search['limit'] = session[:limit] if session[:limit].present?
    @search['sort'] = session[:sort] if session[:sort].present?
    @search['up_down'] = session[:up_down] if session[:up_down].present?
    @list = Nhaphang.getlist(@db)
  end
  
  
  def new
    @list = Hanghoa.getlist(@db)
    @cungcap = Nhacungcap.getlist(@db)
    @thanhtoan = Thanhtoan.getlist(@db)
    @key = Nhaphang.autokey(@db)
    @new = Nhaphang.new
    @hanghoa = []
  end
  
  
  def edit
    @id_nhap = params[:id]
    @list = Hanghoa.getlist(@db)
    @cungcap = Nhacungcap.getlist(@db)
    @thanhtoan = Thanhtoan.getlist(@db)
    @new = Nhaphang.new(Nhaphang.find_id(@db, @id_nhap))
    @hanghoa = []
    list = Ctnhap.find_id(@db, @id_nhap)
    if list.present?
      list.each do |val|
        @hanghoa << Ctnhap.new(val)
        @hanghoa.last.tenhang = Hanghoa.find_id(@db, val['id_hanghoa'])['tenhang']
      end
    end
  end
  
  def save 
    @new = Nhaphang.new(params[:nhaphang])
    @new.id_nguoidung = @info.id_nguoidung
    @key = @new.id_nhap
    @hanghoa = []
    if params[:list].present?
      params[:list].each do |val|
        @hanghoa << Ctnhap.new(val)
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
      @cungcap = Nhacungcap.getlist(@db)
      @thanhtoan = Thanhtoan.getlist(@db)
      render "new"
    else
      @new.save(@db)
      @hanghoa.each do |item|
        item.id_cuahang = "CH1"
        item.id_nhap = @key
        item.save(@db)
        row = Hanghoa.new(Hanghoa.find_id(@db, item.id_hanghoa))
        row.giaban = item.giaban
        row.update(@db)
      end
      redirect_to "/nhaphang/edit/#{@key}"
    end
    
    
  end
  
  
  def update
    @new = Nhaphang.new(params[:nhaphang])
    @new.id_nguoidung = @info.id_nguoidung
    @key = @new.id_nhap
    @hanghoa = []
    if params[:list].present?
      params[:list].each do |val|
        @hanghoa << Ctnhap.new(val)
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
      @cungcap = Nhacungcap.getlist(@db)
      @thanhtoan = Thanhtoan.getlist(@db)
      render "edit"
    else
      @new.update(@db)
      Ctnhap.delete(@db, @new.id_nhap)
      @hanghoa.each do |item|
        item.id_cuahang = "CH1"
        item.id_nhap = @key
        item.save(@db)
        row = Hanghoa.new(Hanghoa.find_id(@db, item.id_hanghoa))
        row.giaban = item.giaban
        row.update(@db)
      end
      redirect_to "/nhaphang"
    end
  end
  
  def phieunhap
    
  end
  
  def tknhaphang
    
  end
end

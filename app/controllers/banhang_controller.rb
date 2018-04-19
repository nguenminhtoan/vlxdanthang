# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class BanhangController < ApplicationController
  def index
    @list = Hanghoa.getlist(@db)
    @khachhang = Khachhang.getlist(@db)
    @thanhtoan = Thanhtoan.getlist(@db)
    @key = Banhang.autokey(@db)
    @new = Banhang.new
    @hanghoa = []
  end
  
  def save
    @new = Banhang.new(params[:banhang])
    @new.id_nguoidung = 'NVA'
    @hanghoa = []
    @hanghoa = params[:list] if params[:list].present?
    unless @new.valid?
      @list = Hanghoa.getlist(@db)
      @khachhang = Khachhang.getlist(@db)
      @thanhtoan = Thanhtoan.getlist(@db)
      @key = Banhang.autokey(@db)
      render "index"
    else
      @new.thanhtien.gsub!(',','')
      @new.save(@db)
      @hanghoa.each do |item|
        @hang = Ctban.new(item)
        @hang.id_ban = @new.id_ban
        @hang.id_cuahang = "CH1"
        @hang.save(@db)
      end
      
      redirect_to "/banhang/edit/#{@new.id_ban}"
    end
  end
  
  
  def hoadon
    @list = Banhang.getlist(@db)
    
  end
  
  def edit 
    @id_ban = params[:id]
    new = Banhang.find_id(@db, @id_ban)
    @new = Banhang.new(new)
    @list = Hanghoa.getlist(@db)
    @khachhang = Khachhang.getlist(@db)
    @thanhtoan = Thanhtoan.getlist(@db)
    @hanghoa = Ctban.find_id(@db, @id_ban)
  end
  
  
  def update
    @new = Banhang.new(params[:banhang])
    @new.id_nguoidung = 'NVA'
    @hanghoa = []
    @hanghoa = params[:list] if params[:list].present?
    unless @new.valid?
      @list = Hanghoa.getlist(@db)
      @khachhang = Khachhang.getlist(@db)
      @thanhtoan = Thanhtoan.getlist(@db)
      @key = Banhang.autokey(@db)
      render "index"
    else
      @new.thanhtien.gsub!(',','')
      @new.update(@db)
      Ctban.delete(@db, @new.id_ban)
      @hanghoa.each do |item|
        @hang = Ctban.new(item)
        @hang.id_ban = @new.id_ban
        @hang.id_cuahang = "CH1"
        @hang.save(@db)
      end
      
      redirect_to "/banhang/hoadon"
    end
  end
  
end

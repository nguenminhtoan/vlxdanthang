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
  
  def thanhtoan
    
    @search = params[:page].present? ? params[:page] : {'current'=>0,'limit'=>25, 'sort'=>'1', 'up_down'=>'ASC'}
    
    @search['up_down'] = session[:current] if session[:current].present?
    @search['limit'] = session[:limit] if session[:limit].present?
    @search['sort'] = session[:sort] if session[:sort].present?
    @search['up_down'] = session[:up_down] if session[:up_down].present?
    
    sql = " SELECT kh.id_khachhang, tenkhachhang, sdt, ngayban, tong, no FROM khachhang kh
          JOIN (SELECT * FROM ( SELECT id_khachhang, ngayban, SUM(thanhtien) as tong, SUM(thanhtoan) as no FROM banhang GROUP BY id_khachhang ORDER BY ngayban ) as nohang) tk  ON tk.id_khachhang = kh.id_khachhang
          GROUP BY kh.id_khachhang
    "
    
    stm = @db.prepare(sql)
    @list = []
    res = stm.execute
    res.each{|v| @list << v} if res.count > 0
    stm.close
    
  end
  
end

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class NhanvienController < ApplicationController
  def index
    @list = Nhanvien.getlist(@db)
  end
  
  def new
    @new = Nhanvien.new
    sql = " SELECT id_quyen, tenquyen FROM phanquyen"
    @quyen = []
    @db.query(sql).each{|v| @quyen << v }
  end
  
  
  def edit
    new = Nhanvien.find_id(@db, params[:id])
    @new = Nhanvien.new(new)
    sql = " SELECT id_quyen, tenquyen FROM phanquyen"
    @quyen = []
    @db.query(sql).each{|v| @quyen << v }
  end
  
  def save
    @new = Nhanvien.new(params[:nhanvien])
    sql = " SELECT id_quyen, tenquyen FROM phanquyen"
    @quyen = []
    @db.query(sql).each{|v| @quyen << v }
    unless @new.valid?
      render "new"
    else
      @new.save(@db)
      redirect_to "/nhanvien"
    end
  end
  
  def update
    @new = Nhanvien.new(params[:nhanvien])
    sql = " SELECT id_quyen, tenquyen FROM phanquyen"
    @quyen = []
    @db.query(sql).each{|v| @quyen << v }
    unless @new.valid?
      render "edit"
    else
      @new.update(@db)
      redirect_to "/nhanvien"
    end
  end
  
  def delete
    Nhanvien.delete(@db, params[:id])
    redirect_to '/nhanvien'
  end
  
  
end

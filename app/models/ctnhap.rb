# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Ctnhap < ModelBase
  Fields = [:id_hanghoa, :id_cuahang, :id_nhap, :soluong, :giaban, :dongia, :tenhang]
  
  attr_accessor *Fields
  def initialize(params={})
    set(params)
    @giaban = params['giaban'].to_s.gsub(/,/,'') if params[:giaban].present?
    @dongia = params['dongia'].to_s.gsub(/,/,'') if params[:dongia].present?
    
  end
  validates :soluong,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
    
  validates :giaban,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :dongia,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
    
  
  def self.find_id(db,id_nhap)
    sql = "SELECT ct.id_hanghoa, ct.id_cuahang, ct.id_nhap, soluong, dongia, hh.giaban, hh.tenhang FROM ct_nhap ct
           JOIN hanghoa hh ON hh.id_cuahang = ct.id_cuahang AND hh.id_hanghoa = ct.id_hanghoa
           WHERE id_nhap = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_nhap)
    list = []
    res.each{|v| list << v} if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO ct_nhap(id_hanghoa, id_cuahang, id_nhap, soluong, dongia) VALUES(?, ?, ?, ?, ?) "
    stm = db.prepare(sql)
    stm.execute(@id_hanghoa, @id_cuahang, @id_nhap, @soluong, @dongia)
    stm.close
  end
  
  def self.delete(db, id_nhap)
    sql = " DELETE FROM ct_nhap WHERE id_nhap = ?"
    stm = db.prepare(sql)
    stm.execute(id_nhap)
    stm.close
  end
end

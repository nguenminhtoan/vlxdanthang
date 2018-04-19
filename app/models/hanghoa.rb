# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Hanghoa < ModelBase
  
  Fields = [:id_hanghoa, :id_loai, :id_donvi, :id_cuahang, :tenhang, :thongso, :giaban, :ghichu]
  
  attr_accessor *Fields
  
  validates :id_hanghoa,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :id_loai,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :id_donvi,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :tenhang,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :thongso,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :giaban,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  def self.getlist(db)
    sql = " SELECT #{Fields.map{|c| 'h.'<<c.to_s}.join(', ')}, donvi, tenloai FROM hanghoa h
          JOIN loaihang lh ON lh.id_loai = h.id_loai
          JOIN donvi dv ON dv.id_donvi = h.id_donvi
      "
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  def self.find_id(db, id_hanghoa)
    sql = " SELECT #{Fields.map{|c| 'h.'<<c.to_s}.join(', ')}, donvi, tenloai FROM hanghoa h
          JOIN loaihang lh ON lh.id_loai = h.id_loai
          JOIN donvi dv ON dv.id_donvi = h.id_donvi WHERE h.id_hanghoa = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_hanghoa)
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO hanghoa(id_loai, id_donvi, id_cuahang, tenhang, thongso, giaban, ghichu, id_hanghoa) 
            VALUES( ?, ?, ?, ?, ?, ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@id_loai, @id_donvi, @id_cuahang, @tenhang, @thongso, @giaban, @ghichu, @id_hanghoa)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE hanghoa SET id_loai= ?, id_donvi= ?, id_cuahang = ?, tenhang = ?, thongso = ?, giaban = ?, ghichu = ? WHERE id_hanghoa = ?"
    stm = db.prepare(sql)
    stm.execute(@id_loai, @id_donvi, @id_cuahang, @tenhang, @thongso, @giaban, @ghichu, @id_hanghoa)
    stm.close
  end
  
  def self.delete(db, id_hanghoa)
    sql = "DELETE FROM hanghoa WHERE id_hanghoa = ?"
    stm = db.prepare(sql)
    stm.execute(id_hanghoa)
    stm.close
  end
end

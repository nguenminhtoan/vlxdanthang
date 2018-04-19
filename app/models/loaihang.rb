# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Loaihang < ModelBase
  
  Fields = [:id_loai, :tenloai, :ghichu]
  
  attr_accessor *Fields
  
  validates :id_loai,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :tenloai,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  
  def self.getlist(db)
    sql = " SELECT id_loai, tenloai, ghichu FROM loaihang"
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  def self.find_id(db, id_loai)
    sql = " SELECT id_loai, tenloai, ghichu FROM loaihang WHERE id_loai = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_loai)
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO loaihang(tenloai, ghichu, id_loai) VALUES( ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@tenloai, @ghichu, @id_loai)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE loaihang SET tenloai = ?, ghichu = ? WHERE id_loai = ?"
    stm = db.prepare(sql)
    stm.execute(@tenloai, @ghichu, @id_loai)
    stm.close
  end
  
  def self.delete(db, id_loai)
    sql = "DELETE FROM loaihang WHERE id_loai = ?"
    stm = db.prepare(sql)
    stm.execute(id_loai)
    stm.close
  end
  
end

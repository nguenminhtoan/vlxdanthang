# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Cuahang < ModelBase
  
  Fields = [:id_cuahang, :tencuahang, :chusohuu, :sdt, :email, :diachi, :ghichu]
  
  attr_accessor *Fields
  
  validates :id_cuahang,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :tencuahang,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  
  def self.getlist(db)
    sql = " SELECT #{Fields.map{|c| c.to_s}.join(', ')} FROM cuahang"
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  def self.find_id(db, id_cuahang = nil)
    sql = " SELECT  #{Fields.map{|c| c.to_s}.join(', ')} FROM cuahang LIMIT 1"
    stm = db.prepare(sql)
    res = stm.execute
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO cuahang(id_cuahang, tencuahang, chusohuu, sdt, email, diachi, ghichu) VALUES( ?, ?, ?, ?, ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@id_cuahang, @tencuahang, @chusohuu, @sdt, @email, @diachi, @ghichu)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE cuahang SET tencuahang = ?, chusohuu = ?, sdt = ?, email = ?, diachi = ?, ghichu = ? WHERE id_cuahang = ?"
    stm = db.prepare(sql)
    stm.execute(@tencuahang, @chusohuu, @sdt, @email, @diachi, @ghichu, @id_cuahang)
    stm.close
  end
  
  def self.delete(db, id_cuahang)
    sql = "DELETE FROM cuahang WHERE id_cuahang = ?"
    stm = db.prepare(sql)
    stm.execute(id_cuahang)
    stm.close
  end
end

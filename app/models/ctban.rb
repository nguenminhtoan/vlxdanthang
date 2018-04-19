# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Ctban < ModelBase
  Fields = [:id_hanghoa, :id_cuahang, :id_ban, :soluong, :giaban]
  
  attr_accessor *Fields
  
  def self.find_id(db,id_ban)
    sql = "SELECT ct.id_hanghoa, ct.id_cuahang, ct.id_ban, soluong, dongia as giaban, hh.tenhang FROM ct_ban ct
           JOIN hanghoa hh ON hh.id_cuahang = ct.id_cuahang AND hh.id_hanghoa = ct.id_hanghoa
           WHERE id_ban = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_ban)
    list = []
    res.each{|v| list << v} if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO ct_ban(id_hanghoa, id_cuahang, id_ban, soluong, dongia) VALUES(?, ?, ?, ?, ?) "
    stm = db.prepare(sql)
    stm.execute(@id_hanghoa, @id_cuahang, @id_ban, @soluong, @giaban)
    stm.close
  end
  
  def self.delete(db, id_ban)
    sql = " DELETE FROM ct_ban WHERE id_ban = ?"
    stm = db.prepare(sql)
    stm.execute(id_ban)
    stm.close
  end
  
end

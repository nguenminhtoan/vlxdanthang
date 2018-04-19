# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Nhacungcap < ModelBase
  
  Fields = [:id_cungcap, :tennhacung, :sdt, :email, :diachi, :ghichu]
  
  attr_accessor *Fields
  
  validates :id_cungcap,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :tennhacung,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :sdt,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  
  
  def self.getlist(db)
    sql = " SELECT #{Fields.map{|c| c.to_s}.join(', ')} FROM nhacungcap"
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  def self.find_id(db, id_cungcap)
    sql = " SELECT #{Fields.map{|c| c.to_s}.join(', ')} FROM nhacungcap WHERE id_cungcap = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_cungcap)
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO nhacungcap(tennhacung, sdt, email, diachi, ghichu, id_cungcap)
            VALUES( ?, ?, ?, ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@tennhacung, @sdt, @email, @diachi, @ghichu, @id_cungcap)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE nhacungcap SET tennhacung = ?, sdt = ?, email = ?, diachi = ?, ghichu = ? WHERE id_cungcap = ?"
    stm = db.prepare(sql)
    stm.execute(@tennhacung, @sdt, @email, @diachi, @ghichu, @id_cungcap)
    stm.close
  end
  
  def self.delete(db, id_cungcap)
    sql = "DELETE FROM nhacungcap WHERE id_cungcap = ?"
    stm = db.prepare(sql)
    stm.execute(id_cungcap)
    stm.close
  end
end

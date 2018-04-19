# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Khachhang < ModelBase
  Fields = [:id_khachhang, :tenkhachhang, :gioitinh, :didong, :sdt, :email, :diachi, :ghichu]
  
  attr_accessor *Fields
  
  validates :id_khachhang,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :tenkhachhang,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :didong,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  def self.getlist(db)
    sql = " SELECT #{Fields.map{|c| c.to_s}.join(', ')} FROM khachhang
      "
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  
  def self.find_id(db, id_khachhang)
    sql = " SELECT #{Fields.map{|c| c.to_s}.join(', ')} FROM khachhang WHERE id_khachhang = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_khachhang)
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO khachhang(tenkhachhang, gioitinh, didong, sdt, email, diachi, ghichu, id_khachhang) 
            VALUES( ?, ?, ?, ?, ?, ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@tenkhachhang, @gioitinh, @didong, @sdt, @email, @diachi, @ghichu, @id_khachhang)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE khachhang SET tenkhachhang = ?, gioitinh = ?, didong = ?, sdt = ?, email = ?, diachi = ?, ghichu = ? WHERE id_khachhang = ?"
    stm = db.prepare(sql)
    stm.execute(@tenkhachhang, @gioitinh, @didong, @sdt, @email, @diachi, @ghichu, @id_khachhang)
    stm.close
  end
  
  def self.delete(db, id_khachhang)
    sql = "DELETE FROM khachhang WHERE id_khachhang = ?"
    stm = db.prepare(sql)
    stm.execute(id_khachhang)
    stm.close
  end
end

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Nhanvien < ModelBase
  Fields = [:id_nguoidung, :id_quyen, :tennguoidung, :ngaysinh, :gioitinh, :sdt, :email, :ghichu, :matkhau]
  
  attr_accessor *Fields
  def initialize(params={})
    set(params)
    @ngaysinh ||= DateTime.new(1990,01,01)
  end
  
  validates :id_nguoidung,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :id_quyen,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :tennguoidung,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :ngaysinh,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  
  def self.getlist(db)
    sql = " SELECT #{Fields.map{|c| 'n.'<<c.to_s}.join(', ')}, tenquyen FROM nguoidung n
          JOIN phanquyen q ON q.id_quyen = n.id_quyen
      "
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  
  def self.find_id(db, id_nguoidung)
    sql = " SELECT #{Fields.map{|c| 'n.'<<c.to_s}.join(', ')}, tenquyen FROM nguoidung n
          JOIN phanquyen q ON q.id_quyen = n.id_quyen WHERE n.id_nguoidung = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_nguoidung)
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO nguoidung(id_quyen, tennguoidung, ngaysinh, gioitinh, sdt, email, ghichu, id_nguoidung) 
            VALUES( ?, ?, ?, ?, ?, ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@id_quyen, @tennguoidung, @ngaysinh, @gioitinh, @sdt, @email, @ghichu, @id_nguoidung)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE nguoidung SET id_quyen = ?, tennguoidung = ?, ngaysinh = ?, gioitinh = ?, sdt = ?, email = ?, ghichu = ? WHERE id_nguoidung = ?"
    stm = db.prepare(sql)
    stm.execute(@id_quyen, @tennguoidung, @ngaysinh, @gioitinh, @sdt, @email, @ghichu, @id_nguoidung)
    stm.close
  end
  
  def self.delete(db, id_nguoidung)
    sql = "DELETE FROM nguoidung WHERE id_nguoidung = ?"
    stm = db.prepare(sql)
    stm.execute(id_nguoidung)
    stm.close
  end
  
end

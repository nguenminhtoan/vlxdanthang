# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Banhang < ModelBase
  Fields = [:id_ban, :id_khachhang, :id_nguoidung, :id_thanhtoan, :ngayban, :thanhtien, :thanhtoan, :ghichu]
  
  attr_accessor *Fields
  def initialize(params={})
    set(params)
    @ngayban ||= DateTime.now
  end
  
  validates :id_ban,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :id_khachhang,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :id_thanhtoan,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :id_nguoidung,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :thanhtien,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  def self.getlist(db)
    sql = " SELECT bh.id_ban, bh.id_khachhang, bh.id_nguoidung, kh.tenkhachhang, nd.tennguoidung, bh.id_thanhtoan, bh.ngayban, bh.thanhtien, bh.thanhtoan, bh.ghichu 
            FROM banhang bh
            JOIN khachhang kh ON kh.id_khachhang = bh.id_khachhang 
            JOIN nguoidung nd ON nd.id_nguoidung = bh.id_nguoidung
            ORDER BY bh.id_ban DESC"
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  
  def self.find_id(db, id_ban)
    sql = " SELECT id_ban, id_khachhang, id_nguoidung, id_thanhtoan, ngayban, thanhtien, thanhtoan, ghichu FROM banhang WHERE id_ban = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_ban)
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def self.autokey(db)
    sql = " SELECT id_ban FROM banhang ORDER BY id_ban DESC LIMIT 1"
    str = db.query(sql).first
    if str.present?
      str = str['id_ban']
      if str[0..7].to_s == DateTime.now.strftime("%Y%m%d").to_s
        num = str[8...str.length]
        if num.to_i < 10
          num = "0" << (num.to_i + 1).to_s
        end
        str = DateTime.now.strftime("%Y%m%d").to_s  + num
      else
        str = DateTime.now.strftime("%Y%m%d").to_s + "01"
      end
    else
      str = DateTime.now.strftime("%Y%m%d").to_s + "01"
    end
    str
  end
  
  def save(db)
    sql = " INSERT INTO banhang(id_khachhang, id_nguoidung, id_thanhtoan, ngayban, thanhtien, thanhtoan, ghichu, id_ban) 
            VALUES( ?, ?, ?, ?, ?, ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@id_khachhang, @id_nguoidung, @id_thanhtoan, @ngayban, @thanhtien, @thanhtoan, @ghichu, @id_ban)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE banhang SET id_khachhang = ?, id_nguoidung = ?, id_thanhtoan = ?, thanhtien = ?, thanhtoan = ?, ghichu= ? WHERE id_ban = ?"
    stm = db.prepare(sql)
    stm.execute(@id_khachhang, @id_nguoidung, @id_thanhtoan, @thanhtien, @thanhtoan, @ghichu, @id_ban)
    stm.close
  end
  
  def self.delete(db, id_ban)
    sql = " DELETE FROM banhang WHERE id_ban = ? "
    stm = db.prepare(sql)
    stm.execute(id_ban)
    stm.close
  end
end

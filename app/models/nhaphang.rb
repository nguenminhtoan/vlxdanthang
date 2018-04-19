# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Nhaphang < ModelBase
  Fields = [:id_nhap, :id_cungcap, :id_nguoidung, :id_thanhtoan, :ngaynhap, :thanhtien, :thanhtoan, :ghichu]
  
  attr_accessor *Fields
  def initialize(params={})
    set(params)
    @ngayban ||= DateTime.now
  end
  
  validates :id_nhap,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :id_cungcap,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :id_thanhtoan,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :id_nguoidung,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :thanhtien,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  def self.getlist(db)
    sql = " SELECT nh.id_nhap, nh.id_cungcap, nh.id_nguoidung, nd.tennguoidung, nh.id_thanhtoan, nh.ngayban, nh.thanhtien, nh.thanhtoan, nh.ghichu 
            FROM nhaphang nh
            JOIN nhacungcap cc ON cc.id_cungcap = nh.id_cungcap 
            JOIN nguoidung nd ON nd.id_nguoidung = bh.id_nguoidung
            ORDER BY bh.id_nhap DESC"
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  
  def self.find_id(db, id_nhap)
    sql = " SELECT id_nhap, id_cungcap, id_nguoidung, id_thanhtoan, ngayban, thanhtien, thanhtoan, ghichu FROM nhaphang WHERE id_nhap = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_nhap)
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def self.autokey(db)
    sql = " SELECT id_nhap FROM nhaphang ORDER BY id_nhap DESC LIMIT 1"
    str = db.query(sql).first
    if str.present?
      str = str['id_nhap']
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
    sql = " INSERT INTO nhaphang(id_cungcap, id_nguoidung, id_thanhtoan, ngayban, thanhtien, thanhtoan, ghichu, id_ban) 
            VALUES( ?, ?, ?, ?, ?, ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@id_cungcap, @id_nguoidung, @id_thanhtoan, @ngayban, @thanhtien, @thanhtoan, @ghichu, @id_ban)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE nhaphang SET id_cungcap = ?, id_nguoidung = ?, id_thanhtoan = ?, thanhtien = ?, thanhtoan = ?, ghichu= ? WHERE id_ban = ?"
    stm = db.prepare(sql)
    stm.execute(@id_cungcap, @id_nguoidung, @id_thanhtoan, @thanhtien, @thanhtoan, @ghichu, @id_ban)
    stm.close
  end
  
  def self.delete(db, id_nhap)
    sql = " DELETE FROM nhaphang WHERE id_nhap = ? "
    stm = db.prepare(sql)
    stm.execute(id_nhap)
    stm.close
  end
end

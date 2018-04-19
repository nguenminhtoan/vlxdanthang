# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Thanhtoan < ModelBase
  Fields = [:id_thanhtoan, :tenthanhtoan, :ghichu]
  
  attr_accessor *Fields
  def initialize(params={})
    set(params)
    @ngaysinh ||= DateTime.new(1990,01,01)
  end
  
  validates :id_thanhtoan,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  validates :tenthanhtoan,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  def self.getlist(db)
    sql = " SELECT id_thanhtoan, tenthanhtoan, ghichu FROM thanhtoan "
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  
  def self.find_id(db, id_thanhtoan)
    sql = " SELECT id_thanhtoan, tenthanhtoan, ghichu FROM thanhtoan WHERE id_thanhtoan = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_thanhtoan)
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO thanhtoan(id_thanhtoan, tenthanhtoan, ghichu) 
            VALUES( ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@id_thanhtoan, @tenthanhtoan, @ghichu)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE thanhtoan SET tenthanhtoan = ?, ghichu = ? WHERE id_thanhtoan = ?"
    stm = db.prepare(sql)
    stm.execute(@tenthanhtoan, @ghichu, @id_thanhtoan)
    stm.close
  end
  
  def self.delete(db, id_thanhtoan)
    sql = "DELETE FROM thanhtoan WHERE id_thanhtoan = ?"
    stm = db.prepare(sql)
    stm.execute(id_thanhtoan)
    stm.close
  end
  
end

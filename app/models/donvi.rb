# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Donvi < ModelBase
  
  Fields = [:id_donvi, :donvi, :kyhieu]
  
  attr_accessor *Fields
  
  validates :id_donvi,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :donvi,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :kyhieu,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  
  
  def self.getlist(db)
    sql = " SELECT id_donvi, donvi, kyhieu FROM donvi"
    stm = db.prepare(sql)
    res = stm.execute
    list = []
    res.each{|val| list << val} if res.count > 0
    list
  end
  
  def self.find_id(db, id_donvi)
    sql = " SELECT id_donvi, donvi, kyhieu FROM donvi WHERE id_donvi = ?"
    stm = db.prepare(sql)
    res = stm.execute(id_donvi)
    list = res.first if res.count > 0
    stm.close
    list
  end
  
  def save(db)
    sql = " INSERT INTO donvi(donvi, kyhieu, id_donvi) VALUES( ?, ?, ?)"
    stm = db.prepare(sql)
    stm.execute(@donvi, @kyhieu, @id_donvi)
    stm.close
  end
  
  def update(db)
    sql = "UPDATE donvi SET donvi = ?, kyhieu = ? WHERE id_donvi = ?"
    stm = db.prepare(sql)
    stm.execute(@donvi, @kyhieu, @id_donvi)
    stm.close
  end
  
  def self.delete(db, id_donvi)
    sql = "DELETE FROM donvi WHERE id_donvi = ?"
    stm = db.prepare(sql)
    stm.execute(id_donvi)
    stm.close
  end

end

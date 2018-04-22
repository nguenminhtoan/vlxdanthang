# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class DashboardController < ApplicationController
  def index
    sql = " SELECT SUM(thanhtoan) as danhthu, COUNT(*) as donhang FROM banhang WHERE ngayban = '#{DateTime.now.strftime("%Y-%m-%d")}' GROUP BY id_khachhang"
    @total = []
    @db.query(sql).each{ |v| @total << v}
    
    sql=" SELECT nh.slnhap, nh.vonnhap, bh.slban, bh.tongban, hh.giaban
            FROM hanghoa hh
            LEFT JOIN (SELECT * FROM (SELECT id_hanghoa, SUM(soluong) as slnhap , SUM(soluong*dongia) as vonnhap FROM ct_nhap GROUP BY id_hanghoa) as NHAP ) nh ON hh.id_hanghoa = nh.id_hanghoa
            LEFT JOIN (SELECT * FROM (SELECT id_hanghoa, SUM(soluong) as slban , SUM(soluong*dongia) as tongban FROM ct_ban GROUP BY id_hanghoa) as BAN) bh ON hh.id_hanghoa = bh.id_hanghoa
        "
    @search = params[:search].to_i
    if @search == 1
      sql << ""
    end
    row = []
    @db.query(sql).each{ |v| row << v}
    @tonkho = row.map{|v| (v['slnhap'].to_i-v['slban'].to_i)*v['giaban']}.sum
    @danhthu = row.map{|v| v['tongban'].to_i}.sum
    @giavon = row.map{|v| v['vonnhap'].to_i}.sum
    sql=" SELECT SUM(thanhtien-thanhtoan) as cungcap FROM nhaphang "
    row = []
    @db.query(sql).each{ |v| row << v}
    @cungcap = row.map{|v| v['cungcap'].to_i}.sum
    sql=" SELECT SUM(thanhtien-thanhtoan) as thu FROM banhang "
    row = []
    @db.query(sql).each{ |v| row << v}
    @khachhang = row.map{|v| v['thu'].to_i}.sum
    sql=" SELECT SUM(thanhtien-thanhtoan) as chiphi FROM phatsinh "
    row = []
    @db.query(sql).each{ |v| row << v}
    @chiphi = row.map{|v| v['chiphi'].to_i}.sum
    @loinhuan = @tonkho + @danhthu - @giavon
  end
end

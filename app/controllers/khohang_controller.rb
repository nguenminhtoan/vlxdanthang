# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class KhohangController < ApplicationController
  def index
    @search = params[:page].present? ? params[:page] : {'current'=>0,'limit'=>25, 'sort'=>'1', 'up_down'=>'ASC'}
    
    @search['up_down'] = session[:current] if session[:current].present?
    @search['limit'] = session[:limit] if session[:limit].present?
    @search['sort'] = session[:sort] if session[:sort].present?
    @search['up_down'] = session[:up_down] if session[:up_down].present?
    
    sql = " SELECT hh.id_hanghoa, hh.tenhang, nh.slnhap, nh.vonnhap, bh.slban, bh.tongban, hh.giaban
            FROM hanghoa hh
            LEFT JOIN (SELECT * FROM (SELECT id_hanghoa, SUM(soluong) as slnhap , SUM(soluong*dongia) as vonnhap FROM ct_nhap GROUP BY id_hanghoa) as NHAP ) nh ON hh.id_hanghoa = nh.id_hanghoa
            LEFT JOIN (SELECT * FROM (SELECT id_hanghoa, SUM(soluong) as slban , SUM(soluong*dongia) as tongban FROM ct_ban GROUP BY id_hanghoa) as BAN) bh ON hh.id_hanghoa = bh.id_hanghoa
        "   
    stm = @db.prepare(sql)
    res = stm.execute
    @list = []
    res.each{|v| @list << v} if res.count > 0
    stm.close
    @list.each do |item|
      total = 0
      tonkho = item['slnhap'].to_i - item['slban'].to_i
      sql = " SELECT dongia, soluong FROM ct_nhap WHERE id_hanghoa = '#{item['id_hanghoa']}' GROUP BY id_nhap ORDER BY id_nhap DESC"
      @db.query(sql).each do |row|
         if (tonkho > 0)
           if(tonkho >= row['soluong'].to_i)
             total = total + (row['dongia']*row['soluong'])
             tonkho = tonkho - row['soluong']
           else
             total = total + tonkho*row['dongia']
             tonkho = 0
           end
         else
           break
         end
      end
      item['tonkho'] = total
    end
    
  end
end

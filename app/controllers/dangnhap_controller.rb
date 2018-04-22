# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class DangnhapController < ApplicationController
  def index
    @account = Taikhoan.new
    render "index", layout: "layout1"
  end
  
  def auth
    @account = Taikhoan.new(params[:taikhoan])
    unless @account.valid?
      render "index", layout: "layout1"
    else
      if Nhanvien.find_id(@db, @account.id_nguoidung).count > 0
        res = Nhanvien.login(@db, @account.id_nguoidung, @account.matkhau)
        if (res.nil?)
          @account.errors[:matkhau] << "không đúng"
          render "index", :layout=>"layout1"
        else
          session[:id_user] = res['id_nguoidung']
          session[:date_login] = DateTime.now.strftime('%Y/%m/%d %H:%M')
          redirect_to '/dashboard'
        end
      else
        @account.errors[:id_nguoidung] << "không đúng"
        render "index", :layout=>"layout1"
      end
    end
  end
  
  def dangxuat
    session.delete(:id_user)
    session.delete(:date_login)
    redirect_to :controller => 'dangnhap', :action=> 'index'
  end
end

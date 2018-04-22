class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  DB_ADDRESS = QLVLXaydung::Application.config.db_host
  DB_ACCOUNT = QLVLXaydung::Application.config.db_user
  DB_PASS = QLVLXaydung::Application.config.db_pass
  DB_SCHEMA = QLVLXaydung::Application.config.db_schema
  before_action  :getPageInfo
  after_action  :afterDBClose
  def error_404
    render :file => "err/error_404.html", :layout => 'layout_1'
  end
  
  def error_505
    render :file => "err/error_404.html", :layout => 'layout_1'
  end
  
  
  def getPageInfo
    
    begin
      @db = Mysql2::Client.new(:host => DB_ADDRESS, :username => DB_ACCOUNT, :password=>DB_PASS, :database=>DB_SCHEMA)
      #@db.select_db('shop_online_admin')
    rescue
      @db.close
    end
    
    @page_name = controller_name 
    
    
    if !session[:id_user].present? && controller_name != 'dangnhap'
      redirect_to '/dangnhap'
    else
      getIcon(@page_name)
    end
    
    
    if session[:id_user].present?
      @info = Nhanvien.new(Nhanvien.find_id(@db,session[:id_user]))
      @time = session[:date_login] if session[:date_login].present?
    end

    
  end
  
  
  def getIcon(name)
    case name
    when 'hanghoa', 'loaihang', 'donvi','loaithanhtoan'
        @icon = "fa fa-navicon"
        @title = "Danh mục hàng hóa"
    when 'banhang'
        @icon = "glyphicon glyphicon-usd"
        @title = "Bán hàng"
    when 'nhaphang'
        @icon = "fa fa-product-hunt"
        @title = "Nhập hàng"
    when 'khohang'
        @icon = "fa fa-database"
        @title = "Kho hàng"
    when "dashboard"
        @icon = "glyphicon glyphicon-dashboard"
        @title = "Thống kê"
    when "khachhang"
        @icon = "glyphicon glyphicon-user"
        @title = "Khách hàng"
    when "nhacungcap"
        @icon = "fa fa-gears"
        @title = "Nhà cung cấp"
    end
  end
  
  
  
  def afterDBClose
   @db.close
  end
end

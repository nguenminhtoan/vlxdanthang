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
    

    
  end
  
  
  
  
  
  def afterDBClose
   @db.close
  end
end

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class NhaphangController < ApplicationController
  def index
    @list = Hanghoa.getlist(@db)
    @cungcap = Nhacungcap.getlist(@db)
    @thanhtoan = Thanhtoan.getlist(@db)
    @key = Nhaphang.autokey(@db)
    @new = Nhaphang.new
    @hanghoa = []
  end
  
  def phieunhap
    
  end
  
  def tknhaphang
    
  end
end

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Taikhoan < ModelBase
  attr_accessor :id_nguoidung,
      :matkhau
  
  validates :id_nguoidung,
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg}
  
  validates :matkhau, 
    :presence => {:message =>QLVLXaydung::Application.config.blank_msg},
    :length=>{:allow_blank => true, :minimum => 5, :message=>"phải có ít nhất 5 ký tự"}  
end

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class NhacungcapController < ApplicationController
  def index
    @list = Nhacungcap.getlist(@db)
  end
  
  
  def new
    @new = Nhacungcap.new
    render "new"
  end
  
  def edit
    new = Nhacungcap.find_id(@db, params[:id])
    @new = Nhacungcap.new(new)
    render "edit"
  end
  
  def save
    @new = Nhacungcap.new(params[:nhacungcap])
    unless @new.valid?
      render "new"
    else
      @new.save(@db)
      redirect_to "/nhacungcap"
    end
  end
  
  def update
    @new = Nhacungcap.new(params[:nhacungcap])
    unless @new.valid?
      render "new"
    else
      @new.update(@db)
      redirect_to "/nhacungcap"
    end
  end
  
  def delete
    Nhacungcap.delete(@db, params[:id])
    redirect_to "/nhacungcap"
  end
  
  
end

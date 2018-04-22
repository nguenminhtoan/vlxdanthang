# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class HanghoaController < ApplicationController
  def index
    @search = params[:page].present? ? params[:page] : {'current'=>0,'limit'=>25, 'sort'=>'1', 'up_down'=>'DESC'}
    
    @search['up_down'] = session[:current] if session[:current].present?
    @search['limit'] = session[:limit] if session[:limit].present?
    @search['sort'] = session[:sort] if session[:sort].present?
    @search['up_down'] = session[:up_down] if session[:up_down].present?
    @list = Hanghoa.getlist(@db)
  end
  
  
  def back_link
    
    @search = params[:page].present? ? params[:page] : {'current'=>0,'limit'=>25, 'sort'=>'1', 'up_down'=>'DESC'}
    
    session[:current] = @search['current']
    session[:limit] = @search['limit']
    session[:sort] = @search['sort']
    session[:up_down] = @search['up_down']
    render html: ""
  end
  
  
  def new
    @new = Hanghoa.new
    @loai = Loaihang.getlist(@db)
    @donvi = Donvi.getlist(@db)
    
    render "new"
  end
  
  
  def edit
    new = Hanghoa.find_id(@db, params[:id])
    @new = Hanghoa.new(new)
    @loai = Loaihang.getlist(@db)
    @donvi = Donvi.getlist(@db)
    render "edit"
  end
  
  def save
    @new = Hanghoa.new(params[:hanghoa])
    unless @new.valid?
      @loai = Loaihang.getlist(@db)
      @donvi = Donvi.getlist(@db)
      render "new"
    else
      @new.save(@db)
      redirect_to '/hanghoa'
    end
  end
  
  def update
    @new = Hanghoa.new(params[:hanghoa])
    unless @new.valid?
      @loai = Loaihang.getlist(@db)
      @donvi = Donvi.getlist(@db)
      render "edit"
    else
      @new.update(@db)
      redirect_to '/hanghoa'
    end
  end
  
  def delete
    Hanghoa.delete(@db, params[:id])
    redirect_to '/hanghoa'
  end

end

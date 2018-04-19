# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class ModelBase
	include ActiveModel::Model


  def initialize(params={})
    set(params)
    
  end
  
  def set(params={})
    if params.present?
      params.keys.each do |k|
        send("#{k}=",params[k]) if respond_to?("#{k}=", true)
      end
    end
  end
	
	
  def self.change(char)
    char = char.to_s
    char.gsub!(/ insert /,'I S E R T ')
    char.gsub!(/ INSERT /,'I S E R T ')
    char.gsub!(/ or /, 'O R')
    char.gsub!(/ OR /, 'O R')
    char.gsub!(/ update /,'U P D A T E ')
    char.gsub!(/ UPDATE /,'U P D A T E ')
    char
  end
  
end

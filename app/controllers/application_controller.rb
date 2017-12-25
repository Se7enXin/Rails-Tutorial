class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #生成控制器时自动生成Helper辅助模块，辅助模块中的方法自动引入Rails视图
  #如果在控制器基类ApplicationController中引入Helper，还可以在控制器中使用
  include SessionsHelper
  
end

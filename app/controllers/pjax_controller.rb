class PjaxController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!, :only => :token
  def index

  end

  def page1
  end
  def page2
  end
  def page3
  end
end

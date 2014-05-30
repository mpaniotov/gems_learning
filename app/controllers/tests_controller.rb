class TestsController < ApplicationController
  def index

  end

  def getjson
    respond_to do |format|
      format.html { render :text => '', :layout => 'application'}
      format.json { render 'public/albums.json' }
    end
  end


end

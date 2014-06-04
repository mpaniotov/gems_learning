class TestRedisController < ApplicationController
  def index
    Resque.enqueue(SimpleJob)
  end

end

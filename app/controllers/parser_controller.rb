class ParserController < ApplicationController
  require 'open-uri'

# подключаем Nokogiri
  require 'nokogiri'

  def yandex
    source =open('http://www.xe.com/')


    page = Nokogiri::HTML(source)
    tr_tag ='.liveRatesRw'
    td_tag ='.rateCell a'
    table = '.table-xrates'
    time = '.liveRatesRw tr'
    th = 'th'
    page.css(table).each do |tr|
      @table= tr
    end

  end
end

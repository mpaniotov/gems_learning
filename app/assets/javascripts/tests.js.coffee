# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  class TestModel extends Backbone.Model

  testModelInst = new TestModel(title: "titletest")
  class TestView extends Backbone.View

    render: ->
      t = '<h2>'+@model.get('title')+'</h2>'
      $('body').html t


  testViewInst = new TestView(model: testModelInst)
  testViewInst.render()
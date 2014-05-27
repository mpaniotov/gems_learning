# Place all the behaviors and hooks related to the matching controller her0e.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  class TestModel extends Backbone.Model

  testModelInst = new TestModel(title: "titletest")
  class TestView extends Backbone.View
    el:$("body")
    events:
      'click #but_2': 'showAlert'
    showAlert:->
      alert('cliked on but_2')
      return


    render: ->
      t = '<h2>'+@model.get('title')+'</h2>'+
      '<button id="but_2" type="submit">click</button>'

      $('.back').html t

  testViewInst = new TestView(model: testModelInst)
  testViewInst.render()




#  object = {}
#  _.extend object, Backbone.Events
#  object.on "click #button", (msg) ->
#    alert "Сработало " + msg
#    return
#
#  object.trigger "alert", "событие"

#  Sidebar = Backbone.Model.extend(promptColor: ->
#    cssColor = prompt("Пожалуйста, введите CSS-цвет:")
#    @set color: cssColor
#    return
#  )
##  window.sidebar = new Sidebar
#  sidebar.on "change:color", (model, color) ->
#    $("body").css background: color
#    return
#
#  sidebar.set color: "white"
#  sidebar.promptColor()
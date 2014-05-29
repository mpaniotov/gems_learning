# Place all the behaviors and hooks related to the matching controller her0e.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
#  class TestModel extends Backbone.Model
#
#  testModelInst = new TestModel(title: "titletest")
#  class TestView extends Backbone.View
#    el:$("body")
#    events:
#      'click #but_2': 'showAlert'
#    showAlert:->
#      alert('cliked on but_2')
#      return
#
#
#    render: ->
#      t = '<h2>'+@model.get('title')+'</h2>'+
#      '<button id="but_2" type="submit">click</button>'
#
#      $('.back').html t
#
#  testViewInst = new TestView(model: testModelInst)
#  testViewInst.render()




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
  # Create a model for the services
#  class Service extends Backbone.Model
#
#  class ServiceList extends Backbone.Collection
#    model: Service
#
#  testModelInst = new ServiceList([
#    new Service(
#      title: "web development"
#      price: 200
#    )
#    new Service(
#      title: "web design"
#      price: 250
#    )
#    new Service(
#      title: "photography"
#      price: 100
#    )
#    new Service(
#      title: "coffee drinking"
#      price: 10
#    )
#  ])
#  console.log(testModelInst)
#
#  class TestView extends Backbone.View
#    render: ->
#      p = '<h2>'+@model.get('title')+'</h2>'+
#      '<button id="but_2" type="submit">click</button>'
#
#      $('.back').html p
#
#  testViewInst = new TestView(model: testModelInst)
#  testViewInst.render()
#  console.log(testViewInst)
#
#

  Album = Backbone.Model.extend
    isLastTrack: (index) ->
      index >= @get("tracks").length - 1

    isFirstTrack: (index) ->
      index is 0

    trackUrlAtIndex: (index) ->
      return @get("tracks")[index].url  if @get("tracks").length >= index
      null

  Albums = Backbone.Collection.extend
    model: Album
    url: '/albums'


  album = new Album(
    title: "Abby Road"
    artist: "The Beatles"
    tracks:
      title: "Track A"
  )

  console.log album.get('title')




  AlbumView = Backbone.View.extend
    tagName: 'li'
    className: 'album'
    initialize: ->
      _.bindAll this, 'render'
      # when set() is called for any attribute
      @model.bind "change", @render
      @template = _.template($("#album-template").html());

    render: ->
      renderedContent = @template(@model.toJSON())
      $(@el).html renderedContent
      this

  LibraryAlbumView = AlbumView.extend()

  LibraryView = Backbone.View.extend
    tagName: 'section'
    className: 'library'
    initialize: ->
      _.bindAll this, 'render'
      @template = _.template($('#library-template').html())
      @collection.bind('reset', @render)

    render: ->
      $albums = undefined
      collection = @collection
      $(@el).html(@template())
      $albums = @$('.albums')
      collection.each (album) ->
        view = new LibraryAlbumView(model: album,collection: collection)
        $albums.append(view.render().el)
      this



#  albumView = new AlbumView(model: album)
#  $('#container').append albumView.render().el

#  alert 'e'
#  album.set({artist:'title'})


  library = new Albums()
#  albums.fetch().then =>
#    console.log albums.models

  libraryView = new LibraryView(collection: library)
  $('#container').append(libraryView.render().el)
  library.fetch()
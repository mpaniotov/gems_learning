# Place all the behaviors and hooks related to the matching controller her0e.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->

  window.Album = Backbone.Model.extend
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

  AlbumView = Backbone.View.extend
    template: _.template($("#album-template").html())
    tagName: 'li'
    className: 'album'
    initialize: ->
      _.bindAll this, 'render'
      @model.bind "change", @render

    render: ->
      renderedContent = @template(@model.toJSON())
      $(@el).html renderedContent
      this

  LibraryAlbumView = AlbumView.extend
    events: ->
      'click .queue.add':'select'

    select: ->
      @collection.trigger('select', @model)


  PlaylistAlbumView = AlbumView.extend(
    events:
      'click .queue.remove': 'removeFromPlaylist'

    initialize: ->
      _.bindAll this, 'render', 'remove'
      @model.bind 'remove',@remove

    removeFromPlaylist: ->
      @options.playlist.remove(@model)
  )


  PlaylistView = Backbone.View.extend
    tagName: 'section'
    className: 'playlist'

    initialize: ->
      _.bindAll this, 'render','renderAlbum', 'queueAlbum'
      @template = _.template($('#playlist-template').html())
      @collection.bind('reset', @render)
      @collection.bind('add', @renderAlbum)

      @player = @options.player

      @library = @options.library
      @library.bind('select',@queueAlbum)

    render: ->
      $(@el).html(@template(@player.toJSON()))

      @$('button.play').toggle(@player.isStopped())
      @$('button.pause').toggle(@player.isPlaying())
      this

    renderAlbum: (album)->
      view = new PlaylistAlbumView(model: album, player: @player, playlist: @collection)
      console.log view
      @$('ul').append(view.render().el)


    queueAlbum: (album)->
      @collection.add(album)


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


  library = new Albums

  library.fetch()






  Playlist = Albums.extend
    isLastAlbum: (index) ->
      index is (@models.length - 1)

    isFirstAlbum: (index) ->
      index is 0

  Player = Backbone.Model.extend
    defaults:
      'currentAlbumIndex':0
      'currentTrackIndex':0
      'state':'stop'

    initialize: ->
      @playlist = new Playlist

    play: ->
      @set('state','play')

    pause: ->
      @set('state','pause')

    isPlaying: ->
      @get('state') is 'play'

    isStopped: ->
      not @isPlaying()

    currentAlbum: ->
      @playlist.at(@get('currentAlbumIndex'))

    currentTrackUrl: ->
      album = @currentAlbum
      album.trackUrlAtIndex(@get('currentTrackIndex'))

    nextTrack: ->
      currentTrackIndex = @get("currentTrackIndex")
      currentAlbumIndex = @get("currentAlbumIndex")
      lastModelIndex = 0
      if @currentAlbum().isLastTrack(currentTrackIndex)
        if @playList.isLastAlbum(currentAlbumIndex)
          @set currentAlbumIndex: 0
          @set currentTrackIndex: 0
        else
          @set currentAlbumIndex: currentAlbumIndex + 1
          @set currentTrackIndex: 0
      else
        @set currentTrackIndex: currentTrackIndex + 1
      @logCurrentAlbumAndTrack()

    prevTrack: ->
      currentTrackIndex = @get("currentTrackIndex")
      currentAlbumIndex = @get("currentAlbumIndex")
      lastModelIndex = 0
      if @currentAlbum().isFirstTrack(currentTrackIndex)
        if @playlist.isFirstAlbum(currentAlbumIndex)
          lastModelIndex = @playlist.models.length - 1
          @set currentAlbumIndex: lastModelIndex
        else
          @set currentAlbumIndex: currentAlbumIndex - 1
        lastTrackIndex = @currentAlbum().get("tracks").length - 1
        @set currentTrackIndex: lastTrackIndex
      else
        @set currentTrackIndex: currentTrackIndex - 1
      @logCurrentAlbumAndTrack()

    logCurrentAlbumAndTrack: ->
      console.log('Player'+@get('currentAlbumIndex')+':'+@get('currentTrackIndex'))

  player = new Player
#
  BackboneTunes = Backbone.Router.extend
    routes:
      '':'home'
      'blank':'blank'
    initialize: ->
      @playlistView = new PlaylistView(collection: player.playlist, player: player, library: library)
      @libraryView = new LibraryView(collection: library)

    home: ->
      $container = $('#container')
      $container.empty()
      $container.append(@playlistView.render().el)
      $container.append(@libraryView.render().el)

    blank: ->
      $('#container').empty()
      $('#container').text('blank')


  App = new BackboneTunes()
  Backbone.history.start()
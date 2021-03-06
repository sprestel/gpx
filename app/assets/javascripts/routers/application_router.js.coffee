class App.Routers.ApplicationRouter extends Backbone.Router
  routes:
    '': 'index'
    'rides': 'rides'
    'rides/page/:page': 'rides'
    'rides/:id': 'ride'
    'upload': 'upload'
    'summary/weekly': 'weeklySummary'

  initialize: =>
    $('body > nav a').click @followLink

  index: =>
    @loadRides =>
      summaryView = new App.Views.Summary.SummaryView(collection: App.rides)
      @changePage summaryView
      @hideMenuItem 'Home'

  rides: (page = 1) =>
    @loadRidesPage page, =>
      ridesView = new App.Views.Rides.RidesView(collection: App.rides)
      @changePage ridesView, 'All Rides'

  ride: (id) =>
    @loadRide id, (ride) =>
      if ride?
        rideView = new App.Views.Rides.RideView(model: ride)
        @changePage rideView, 'Ride Details'
      else
        App.router.navigate '/', trigger: true

  upload: =>
    fileUploadView = new App.Views.FileUploadView
    @changePage fileUploadView, 'Upload'
    @hideMenuItem 'Upload'

  weeklySummary: =>
    weeklySummaryView = new App.Views.Summary.WeeklySummaryView
    @changePage weeklySummaryView, 'Weekly Summary'

  changePage: (view, title) =>
    document.title = if title? then "Ride Log - #{title}" else 'Ride Log'

    $('#container').empty()
    $('#container').append view.render().el
    $('html, body').scrollTop 0
    $('nav a').show()

  hideMenuItem: (title) =>
    $("nav a:contains('#{title}')").hide()

  followLink: (event) ->
    App.Helpers.followLink event

  loadRidesPage: (page, callback) =>
    @loadRides callback, page

  loadRides: (callback, page = 1) =>
    App.rides = new App.Collections.RideCollection(page: page)
    App.rides.fetch
      success: =>
        callback() if _.isFunction(callback)

  loadRide: (id, callback) =>
    ride = App.rides.get(id) if App.rides?

    if ride?
      callback(ride) if _.isFunction(callback)
    else
      ride = new App.Models.Ride(id: id)
      ride.fetch
        success: =>
          callback(ride) if _.isFunction(callback)
        error: =>
          callback(null) if _.isFunction(callback)

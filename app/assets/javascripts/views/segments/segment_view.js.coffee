class App.Views.Segments.SegmentView extends Backbone.View
  id: 'segment'

  render: =>
    $(@el).html JST['templates/segments/segment_view'](@model.toJSON())
    @prepareExpandingSections()

    @loadPoints (points) =>
      @loadMap points

    @

  prepareExpandingSections: =>
    $(@el).find('section header h1').click (event) =>
      section = $(event.target).closest('section')
      section.toggleClass('active')

    $(@el).find('section').addClass('active')

  loadPoints: (callback) =>
    points = new App.Collections.PointCollection href: @model.get('points_href')
    points.fetch
      success: => callback points

  loadMap: (points) =>
    mapView = new App.Views.Segments.MapView points: points
    mapView.render()
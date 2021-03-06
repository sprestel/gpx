object @report
attributes :id,
  :year_distance,
  :year_duration,
  :year_elevation_gain,
  :year_ride_count,
  :month_distance,
  :month_duration,
  :month_elevation_gain,
  :month_ride_count,
  :week_distance,
  :week_duration,
  :week_elevation_gain,
  :week_ride_count

node(:href) { |report| api_reports_totals_url }
node(:created_at) { |report| report.created_at.to_i }
node(:updated_at) { |report| report.updated_at.to_i }

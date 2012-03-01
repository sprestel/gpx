class SegmentsController < ApplicationController
  def index
    last_modified = Segment.maximum(:updated_at)

    if stale?(:last_modified => last_modified, :etag => last_modified)
      @segments = Segment.all
    end
  end

  def show
    @segment = Segment.find(params[:id])
    fresh_when @segment
  end

  def update
    @segment = Segment.find(params[:id])

    respond_to do |format|
      format.json do
        if @segment.update_attributes(params[:segment])
          render :show, :status => :ok
        else
          render :show, :status => :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @segment = Segment.find(params[:id])

    respond_to do |format|
      format.json do
        @segment.destroy
        Gpx::Reports::ReportGenerator.create_current!
        Gpx::Records::RecordGenerator.create_current!
        render :show, :status => :ok
      end
    end
  end
end

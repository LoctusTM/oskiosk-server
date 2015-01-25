class IdentifiersController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  swagger_controller :identifiers, 'Manage barcodes (identifiers)'

  swagger_api :show do
    summary 'Fetch the object associated with this barcode'
    notes <<-EON
      This will return a user or a product depending on the scanned barcode.
      The 'type' attribute can be used to determine what is returned.
    EON
    param :path, :id, :string, :required, "The Barcode value"
  end

  before_action :doorkeeper_authorize!

  def show
    identifiable = Identifier.find_by_code(params[:id]).identifiable
    render json: identifiable
  end
end
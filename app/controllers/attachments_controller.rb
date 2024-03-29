class AttachmentsController < ApplicationController
  def purge
    attachment = ActiveStorage::Attachment.find(pure_params[:id])
    attachment.purge
    redirect_back fallback_location: root_path, notice: 'success'
  end

  private

  def pure_params
    params.permit(:id)
  end
end

# frozen_string_literal: true

class DocumentsController < ApplicationController
  def show
    @document = Document.find_by!(code: params[:id])
  end
end

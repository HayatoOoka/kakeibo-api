class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show update destroy]
  #before_action :authenticate

  def index
    @organizations = Organization.all
    render json: @organizations
  end

  def show
    render json: @organization
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      render json: @organization, status: :created
    else
      render json: @organization.errors, status: :bad_request
    end
  end

  def update
    if @organization.update(organization_params)
      render json: @organization
    else
      render json: @organization.errors, status: :bad_request
    end
  end

  def destroy
    @organization.destroy
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name)
  end
end


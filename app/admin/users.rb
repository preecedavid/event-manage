# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :password, :password_confirmation, role_ids: []

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles, as: :check_boxes
    end
    f.actions
  end

  before_action :remove_password_params_if_blank, only: [:update]

  controller do
    def remove_password_params_if_blank
      return if params[:user][:password].blank? || params[:user][:password_confirmation].blank?

      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end

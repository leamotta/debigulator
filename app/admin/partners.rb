ActiveAdmin.register Partner do
  permit_params :name, :token

  controller do
    def create
      params[:partner][:token] = SecureRandom.hex(10)
      super
    end
  end

  form do |f|
    f.inputs 'Category details' do
      f.input :name
      f.semantic_errors(*f.object.errors.keys)
    end
    f.actions
  end
end

require 'spec_helper'

describe BoxesController do
  let(:valid_attributes) { FactoryGirl.attributes_for(:box) }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all boxes as @boxes" do
      box = Box.create! valid_attributes
      get :index, {}, valid_session
      assigns(:boxes).should eq([box])
    end
  end

  describe "GET show" do
    it "assigns the requested box as @box" do
      box = Box.create! valid_attributes
      get :show, {:id => box.to_param}, valid_session
      assigns(:box).should eq(box)
    end
  end

  describe "GET new" do
    it "assigns a new box as @box" do
      get :new, {}, valid_session
      assigns(:box).should be_a_new(Box)
    end
  end

  describe "GET edit" do
    it "assigns the requested box as @box" do
      box = Box.create! valid_attributes
      get :edit, {:id => box.to_param}, valid_session
      assigns(:box).should eq(box)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Box" do
        expect {
          post :create, {:box => valid_attributes}, valid_session
        }.to change(Box, :count).by(1)
      end

      it "assigns a newly created box as @box" do
        post :create, {:box => valid_attributes}, valid_session
        assigns(:box).should be_a(Box)
        assigns(:box).should be_persisted
      end

      it "redirects to the created box" do
        post :create, {:box => valid_attributes}, valid_session
        response.should redirect_to(Box.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved box as @box" do
        Box.any_instance.stub(:save).and_return(false)
        post :create, {:box => { "name" => "invalid value" }}, valid_session
        assigns(:box).should be_a_new(Box)
      end

      it "re-renders the 'new' template" do
        Box.any_instance.stub(:save).and_return(false)
        post :create, {:box => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested box" do
        box = Box.create! valid_attributes
        Box.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => box.to_param, :box => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested box as @box" do
        box = Box.create! valid_attributes
        put :update, {:id => box.to_param, :box => valid_attributes}, valid_session
        assigns(:box).should eq(box)
      end

      it "redirects to the box" do
        box = Box.create! valid_attributes
        put :update, {:id => box.to_param, :box => valid_attributes}, valid_session
        response.should redirect_to(box)
      end
    end

    describe "with invalid params" do
      it "assigns the box as @box" do
        box = Box.create! valid_attributes
        Box.any_instance.stub(:save).and_return(false)
        put :update, {:id => box.to_param, :box => { "name" => "invalid value" }}, valid_session
        assigns(:box).should eq(box)
      end

      it "re-renders the 'edit' template" do
        box = Box.create! valid_attributes
        Box.any_instance.stub(:save).and_return(false)
        put :update, {:id => box.to_param, :box => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested box" do
      box = Box.create! valid_attributes
      expect {
        delete :destroy, {:id => box.to_param}, valid_session
      }.to change(Box, :count).by(-1)
    end

    it "redirects to the boxes list" do
      box = Box.create! valid_attributes
      delete :destroy, {:id => box.to_param}, valid_session
      response.should redirect_to(boxes_url)
    end
  end

end

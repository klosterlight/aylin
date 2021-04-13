require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /categories" do
    before(:all) do
      FactoryBot.create_list :category, 20
      get categories_path
      @response_data = JSON.parse(response.body)
    end

    it "should get all the categories" do
      scoped_data = Category.all.limit(10)
      expect(@response_data["data"].map{ |d| d["id"] }).to match_array(scoped_data.map(&:id))
    end
    it "should have :ok status" do
      expect(response.status).to eq(200)
    end

    include_examples "paginated list"
  end

  describe "GET /categories/:id" do
    before(:all) do
      @category = FactoryBot.create :category

      get category_path(@category)
      @response_data = JSON.parse(response.body)
    end

    it "should get a category with all its attributes" do
      expect(@response_data["id"]).to eq @category.id
      expect(@response_data["name"]).to eq @category.name
      expect(@response_data["active_status"]).to eq true
      expect(@response_data["description"]).to eq @category.description
      expect(Time.zone.parse(@response_data["created_at"]).to_i).to eq(@category.created_at.to_i)
      expect(Time.zone.parse(@response_data["updated_at"]).to_i).to eq(@category.updated_at.to_i)
    end

    it "should respond with :ok" do
      expect(response.status).to eq 200
    end
  end

  describe "POST /categories"

  describe "PUT /categories/:id"
end

require "rspec"
require "csv"

# Set the application root directory
APP_ROOT = File.expand_path("..", __dir__)

# Download a copy from Bike Index to compare against the updates in the repo
system("bin/download_from_bike_index tmp/", exception: true)

BIKE_INDEX_MANUFACTURERS_CSV = CSV.read("tmp/manufacturers.csv", headers: true, header_converters: :symbol)
BIKE_INDEX_ACTIVITIES_CSV = CSV.read("tmp/primary_activities.csv", headers: true, header_converters: :symbol)

RSpec.describe "CSVs" do
  describe "manufacturers.csv" do
    let(:repo_csv) { CSV.read("data/manufacturers.csv", headers: true, header_converters: :symbol) }

    it "has at least as many manufacturers as are on bikeindex, and the same headers" do
      expect(repo_csv.count).to eq BIKE_INDEX_MANUFACTURERS_CSV.count
      expect(repo_csv.headers).to eq BIKE_INDEX_MANUFACTURERS_CSV.headers
    end
  end

  describe "primary_activities.csv" do
    let(:repo_csv) { CSV.read("data/primary_activities.csv", headers: true, header_converters: :symbol) }

    it "has at least as many activities as are on bikeindex, and the same headers" do
      expect(repo_csv.count).to eq BIKE_INDEX_ACTIVITIES_CSV.count
      expect(repo_csv.headers).to eq BIKE_INDEX_ACTIVITIES_CSV.headers
    end
  end

  describe "wheel_sizes.csv" do
    let(:repo_csv) { CSV.read("data/wheel_sizes.csv", headers: true, header_converters: :symbol) }

    it "can be read" do
      expect(repo_csv.headers).not_to be_empty
      expect(repo_csv.count).to be > 0
    end
  end

  describe "components.csv" do
    let(:repo_csv) { CSV.read("data/components.csv", headers: true, header_converters: :symbol) }

    it "can be read" do
      expect(repo_csv.headers).not_to be_empty
      expect(repo_csv.count).to be > 0
    end
  end

  describe "vehicle_attributes.csv" do
    let(:repo_csv) { CSV.read("data/vehicle_attributes.csv", headers: true, header_converters: :symbol) }

    it "can be read" do
      expect(repo_csv.headers).not_to be_empty
      expect(repo_csv.count).to be > 0
    end
  end

  describe "colors.csv" do
    let(:repo_csv) { CSV.read("data/colors.csv", headers: true, header_converters: :symbol) }

    it "can be read" do
      expect(repo_csv.headers).not_to be_empty
      expect(repo_csv.count).to be > 0
    end
  end

  describe "gear_types.csv" do
    let(:repo_csv) { CSV.read("data/gear_types.csv", headers: true, header_converters: :symbol) }

    it "can be read" do
      expect(repo_csv.headers).not_to be_empty
      expect(repo_csv.count).to be > 0
    end
  end

  describe "handlebar_types.csv" do
    let(:repo_csv) { CSV.read("data/handlebar_types.csv", headers: true, header_converters: :symbol) }

    it "can be read" do
      expect(repo_csv.headers).not_to be_empty
      expect(repo_csv.count).to be > 0
    end
  end
end

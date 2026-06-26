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
    let(:repo_csv) { CSV.read("manufacturers.csv", headers: true, header_converters: :symbol) }

    it "has at least as many manufacturers as are on bikeindex, and the same headers" do
      expect(repo_csv.count).to eq BIKE_INDEX_MANUFACTURERS_CSV.count
      expect(repo_csv.headers).to eq BIKE_INDEX_MANUFACTURERS_CSV.headers
    end
  end

  describe "primary_activities.csv" do
    let(:repo_csv) { CSV.read("primary_activities.csv", headers: true, header_converters: :symbol) }

    it "has at least as many activities as are on bikeindex, and the same headers" do
      expect(repo_csv.count).to eq BIKE_INDEX_ACTIVITIES_CSV.count
      expect(repo_csv.headers).to eq BIKE_INDEX_ACTIVITIES_CSV.headers
    end
  end

  describe "wheel_sizes.csv" do
    let(:repo_csv) { CSV.read("wheel_sizes.csv", headers: true, header_converters: :symbol) }

    it "parses" do
      expect(repo_csv.count).to be > 0
    end
  end

  describe "components.csv" do
    let(:repo_csv) { CSV.read("components.csv", headers: true, header_converters: :symbol) }

    it "parses" do
      expect(repo_csv.count).to be > 0
    end
  end

  describe "vehicle_attributes.csv" do
    let(:repo_csv) { CSV.read("vehicle_attributes.csv", headers: true, header_converters: :symbol) }

    it "parses" do
      expect(repo_csv.count).to be > 0
    end
  end
end

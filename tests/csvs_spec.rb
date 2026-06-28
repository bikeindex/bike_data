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

  # Every CSV in data/ should be readable, have headers, and have at least one row
  Dir[File.join(APP_ROOT, "data", "*.csv")].sort.each do |path|
    describe File.basename(path) do
      it "can be read" do
        rows = CSV.read(path, headers: true, header_converters: :symbol)
        expect(rows.headers).not_to be_empty
        expect(rows.count).to be > 0
      end
    end
  end
end

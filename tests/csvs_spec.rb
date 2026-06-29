require "rspec"
require "csv"

# Set the application root directory
APP_ROOT = File.expand_path("..", __dir__)

# Download a copy from Bike Index to compare against the updates in the repo
system("bin/download_from_bike_index tmp/", exception: true)

BIKE_INDEX_MANUFACTURERS_CSV = CSV.read("tmp/manufacturers.csv", headers: true, header_converters: :symbol)
BIKE_INDEX_ACTIVITIES_CSV = CSV.read("tmp/primary_activities.csv", headers: true, header_converters: :symbol)
BIKE_INDEX_COMPONENTS_CSV = CSV.read("tmp/components.csv", headers: true, header_converters: :symbol)

RSpec.describe "CSVs" do
  shared_examples "a data CSV" do |path|
    let(:repo_csv) { CSV.read(path, headers: true, header_converters: :symbol) }
    let(:rows) { CSV.read(path) }

    it "can be read and has no rows with a different column count than the header" do
      expect(repo_csv.headers).not_to be_empty
      expect(repo_csv.count).to be > 0

      header_count = rows.first.length
      ragged_line_numbers = rows.each_with_index
        .select { |row, _i| row.length != header_count }
        .map { |_row, i| i + 1 }

      expect(ragged_line_numbers).to(
        be_empty,
        "expected every row to have #{header_count} columns, " \
        "but these line numbers differ: #{ragged_line_numbers.join(", ")}"
      )
    end
  end

  describe "manufacturers.csv" do
    it_behaves_like "a data CSV", "data/manufacturers.csv"

    let(:repo_csv) { CSV.read("data/manufacturers.csv", headers: true, header_converters: :symbol) }

    it "has at least as many manufacturers as are on bikeindex, and the same headers" do
      expect(repo_csv.count).to eq BIKE_INDEX_MANUFACTURERS_CSV.count
      expect(repo_csv.headers).to eq BIKE_INDEX_MANUFACTURERS_CSV.headers
    end
  end

  describe "primary_activities.csv" do
    it_behaves_like "a data CSV", "data/primary_activities.csv"

    let(:repo_csv) { CSV.read("data/primary_activities.csv", headers: true, header_converters: :symbol) }

    it "has at least as many activities as are on bikeindex, and the same headers" do
      expect(repo_csv.count).to eq BIKE_INDEX_ACTIVITIES_CSV.count
      expect(repo_csv.headers).to eq BIKE_INDEX_ACTIVITIES_CSV.headers
    end
  end

  describe "wheel_sizes.csv" do
    it_behaves_like "a data CSV", "data/wheel_sizes.csv"
  end

  describe "component_type.csv" do
    it_behaves_like "a data CSV", "data/component_type.csv"

    let(:repo_csv) { CSV.read("data/component_type.csv", headers: true, header_converters: :symbol) }

    it "has at least as many components as are on bikeindex, and the same headers" do
      expect(repo_csv.count).to eq BIKE_INDEX_COMPONENTS_CSV.count
      expect(repo_csv.headers).to eq BIKE_INDEX_COMPONENTS_CSV.headers
    end
  end

  describe "vehicle_attributes.csv" do
    it_behaves_like "a data CSV", "data/vehicle_attributes.csv"
  end

  describe "colors.csv" do
    it_behaves_like "a data CSV", "data/colors.csv"
  end

  describe "drivetrain_attributes.csv" do
    it_behaves_like "a data CSV", "data/drivetrain_attributes.csv"
  end

  describe "handlebar_types.csv" do
    it_behaves_like "a data CSV", "data/handlebar_types.csv"
  end

  describe "brake_type.csv" do
    it_behaves_like "a data CSV", "data/brake_type.csv"
  end
end

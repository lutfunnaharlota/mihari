# frozen_string_literal: true

RSpec.describe Mihari::Analyzers::Feed, :vcr do
  describe "#artifacts" do
    context "with JSON" do
      subject do
        described_class.new(
          "https://threatfox-api.abuse.ch/api/v1/",
          method: "POST",
          json: { query: "get_iocs", days: 1 },
          headers: {
            "api-key": ENV["THREATFOX_API_KEY"]
          },
          selector: "map(&:data).unwrap.map(&:ioc)"
        )
      end
      it do
        expect(subject.artifacts).to be_an(Array)
      end
    end

    context "with CSV" do
      subject do
        described_class.new(
          "https://urlhaus.abuse.ch/feeds/country/JP/",
          selector: "map { |v| v[1] }"
        )
      end
      it do
        expect(subject.artifacts).to be_an(Array)
      end
    end
  end
end

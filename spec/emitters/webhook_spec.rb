# frozen_string_literal: true

require "json"

RSpec.describe Mihari::Emitters::Webhook, :vcr do
  include_context "with database fixtures"

  describe "#valid?" do
    context "without url" do
      it do
        emitter = described_class.new
        expect(emitter.valid?).to be false
      end
    end

    context "with uri" do
      it do
        emitter = described_class.new(url: "http://example.com")
        expect(emitter.valid?).to be true
      end
    end
  end

  describe "#emit" do
    let(:artifacts) do
      [
        Mihari::Artifact.new(data: "1.1.1.1"),
        Mihari::Artifact.new(data: "github.com")
      ]
    end
    let(:rule) { Mihari::Structs::Rule.from_model(Mihari::Rule.first) }
    let(:url) { "https://httpbin.org/post" }

    it do
      emitter = described_class.new(url: url, headers: { "Content-Type": "application/json" })
      res = emitter.emit(artifacts: artifacts, rule: rule)

      json_data = JSON.parse(res.body.to_s)["json"]
      expect(json_data).to be_a(Hash)
    end
  end
end

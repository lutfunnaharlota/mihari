# frozen_string_literal: true

RSpec.describe Mihari::Analyzers::VirusTotal, :vcr do
  subject { described_class.new(query) }

  context "ipv4" do
    let(:query) { "45.83.140.140" }

    describe "#artifacts" do
      it do
        expect(subject.artifacts).to be_an(Array)
      end
    end
  end

  context "domain" do
    let(:query) { "jppost-ge.top" }

    describe "#artifacts" do
      it do
        expect(subject.artifacts).to be_an(Array)
      end
    end
  end

  context "when given an invalid input" do
    let(:query) { "foo bar" }

    describe "#artifacts" do
      it do
        expect { subject.artifacts }.to raise_error(Mihari::InvalidInputError)
      end
    end
  end

  context "when api config is not given" do
    let(:query) { "1.1.1.1" }

    before do
      allow(Mihari.config).to receive(:virustotal_api_key).and_return(nil)
    end

    it do
      expect { subject.artifacts }.to raise_error(ArgumentError)
    end
  end
end

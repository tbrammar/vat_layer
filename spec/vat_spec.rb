require "spec_helper"

describe Apilayer::Vat do
  before do
    Apilayer::Vat.configure do |configs|
      configs.access_key = "vat_layer_key123"
    end
  end

  describe :connection do
    subject { Apilayer::Vat.connection }

    context "vat_layer access_key has been set" do
      it "returns a connection with correct attributes" do
        expect(subject).to be_a Faraday::Connection
        expect(subject.url_prefix.host).to match "apilayer.net"
        expect(subject.params["access_key"]).to eq "vat_layer_key123"
      end
    end

    context "configured as non-secure connection" do
      specify{ expect(subject.url_prefix).to be_a URI::HTTP }
    end

    context "configured as secure connection" do
      before do
        Apilayer::Vat.configure do |configs|
          configs.https = true
        end
      end
      after do
        Apilayer::Vat.configure do |configs|
          configs.https = false
        end
      end

      specify{ expect(subject.url_prefix).to be_a URI::HTTPS }
    end
  end

  describe :validate do
    subject { Apilayer::Vat.validate(vat_number) }
    let(:vat_number) { "LU26375245" }

    it "returns a Hash with VAT data" do
      VCR.use_cassette("vat/validation") do

        expect(subject).to include(
          "query" =>  "LU26375245",
          "company_name" => "AMAZON EUROPE CORE S.A R.L."
        )
      end
    end

    it "passes vat_number to get_and_parse" do
      VCR.use_cassette("vat/validation") do
        expect(Apilayer::Vat).to receive(:get_and_parse).with(
          "validate", {:vat_number => "LU26375245"}
        )
        subject
      end
    end
  end

  describe :rate do
    subject { Apilayer::Vat.rate(criteria, value) }

    context "country_code provided as criteria" do
      let(:criteria) { :country_code }
      let(:value) { "NL" }

      it "returns a Hash with VAT rate for the specified country" do
        VCR.use_cassette("vat/rate_by_country_code") do
          expect(subject).to include(
            'standard_rate' => kind_of(Numeric),
            'reduced_rates' => kind_of(Hash)
          )
        end
      end

      it "passes country_code to get_and_parse" do
        VCR.use_cassette("vat/validation") do
          expect(Apilayer::Vat).to receive(:get_and_parse).with(
            "rate", {:country_code => "NL"}
          )
          subject
        end
      end
    end

    context "ip_address provided as criteria" do
      let(:criteria) { :ip_address }
      let(:value) { "176.249.153.36" }

      it "returns a Hash with VAT rate for the specified country" do
        VCR.use_cassette("vat/rate_by_ip_address") do
          expect(subject).to include(
            'standard_rate' => kind_of(Numeric),
            'reduced_rates' => kind_of(Hash)
          )
        end
      end

      it "passes ip_address to get_and_parse" do
        VCR.use_cassette("vat/rate_by_ip_address") do
          expect(Apilayer::Vat).to receive(:get_and_parse).with(
            "rate", {:ip_address => "176.249.153.36"}
          )
          subject
        end
      end
    end
  end

  describe :rate_list do
    subject { Apilayer::Vat.rate_list }
    it "returns VAT rates for all 28 EU countries" do
      VCR.use_cassette("vat/rate_list") do
        expect(subject["rates"].count).to eq 28
      end
    end

    it "invokes get_and_parse" do
      VCR.use_cassette("vat/rate_list") do
        expect(Apilayer::Vat).to receive(:get_and_parse).with("rate_list")
        subject
      end
    end
  end

  describe :price do
    subject { Apilayer::Vat.price(price, criteria, criteria_value) }
    let(:price) { 100 }

    context "invalid criteria provided" do
      let(:criteria) { :foobar }
      let(:criteria_value) { "Some Value" }

      it 'raises an error' do
        expect{ subject }.to raise_error(
          Apilayer::Error,
          "You must provide either :country_code or :ip_address"
        )
      end
    end

    context "calculation based on country_code" do
      let(:criteria) { :country_code }
      let(:criteria_value) { "NL" }
      it 'returns price incl/excl VAT and country_code' do
        VCR.use_cassette("vat/price_by_country_code") do
          expect(subject).to include(
            "country_name" => "Netherlands",
            "price_excl_vat" => 100,
            "price_incl_vat" => 121,
            "vat_rate" => 21
          )
        end
      end

      it "invokes get_and_parse with country_code" do
        VCR.use_cassette("vat/price_by_country_code") do
          expect(Apilayer::Vat).to receive(:get_and_parse).with(
            "price",
            hash_including(:amount => 100, :country_code => "NL")
          )
          subject
        end
      end
    end

    context "calculation based on ip_address" do
      let(:criteria) { :ip_address }
      let(:criteria_value) { "176.249.153.36" }
      it "returns price incl/excl VAT and ip_address" do
        VCR.use_cassette("vat/price_by_ip_address") do
          expect(subject).to include(
            "country_name" => "United Kingdom",
            "price_excl_vat" => 100,
            "price_incl_vat" => 120,
            "vat_rate" => 20
          )
        end
      end

      it "invokes get_and_parse with ip_address" do
        VCR.use_cassette("vat/price_by_ip_address") do
          expect(Apilayer::Vat).to receive(:get_and_parse).with(
            "price",
            hash_including(:amount => 100, :ip_address => "176.249.153.36")
          )
          subject
        end
      end

    end
  end

end


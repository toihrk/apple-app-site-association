# frozen_string_literal: true

require 'spec_helper'

describe Apple::App::Site::Association do
  describe Apple::App::Site::Association::Config do
    let(:config) { Apple::App::Site::Association::Config.new }
    describe '#apps' do
      let(:apps) { [] }
      subject do
        config.apps(*apps)
        config.instance_variable_get :@apps
      end

      it 'should return empty' do
        expect(subject.empty?).to be true
      end

      context 'has apps' do
        let(:apps) { %w[a b c] }
        it 'should not return empty' do
          expect(subject.empty?).to be false
          expect(subject.size).to eq(apps.size)
        end
      end
    end

    describe '#details' do
      let(:details) { [] }
      subject do
        config.details(*details)
        config.instance_variable_get :@details
      end

      it 'should return empty' do
        expect(subject.empty?).to be true
      end

      context 'has details' do
        let(:details) { [{ appID: 'invalid-app-id', paths: ['*'] }] }
        it 'should not return empty' do
          expect(subject.empty?).to be false
          expect(subject.size).to eq(details.size)
        end
      end
    end

    describe '#to_json' do
      subject { config.to_json }

      it 'should return String' do
        expect(subject).to be_a String
      end

      it 'has keys' do
        config = JSON.parse(subject)
        expect(config.key?('apps')).to be true
        expect(config.key?('details')).to be true
      end
    end

    describe 'GET /apple-app-site-association' do
      subject do
        get '/apple-app-site-association'
        last_response
      end

      it 'should allow accessing' do
        expect(subject).to be_ok
      end

      it 'should return application/json' do
        headers = subject.header
        expect(headers.key?('Content-Type')).to be true
        content_type = headers['Content-Type']
        expect(content_type).to eq('application/json')
      end

      it 'should have keys' do
        json = subject.body
        body = JSON.parse(json)
        expect(body.key?('apps')).to be true
        expect(body.key?('details')).to be true
      end

      it 'should have default values' do
        json = subject.body
        body = JSON.parse(json)
        body.values.each do |v|
          expect(v).to be_a Array
          expect(v.empty?).to be true
        end
      end

      context 'configurable' do
        let(:apps) { [] }
        let(:details) { [{ appID: 'ABCD1234.com.apple.wwdc', paths: '*' }] }

        before :each do
          app.configure do |c|
            c.apps(*apps)
            c.details(*details)
          end
        end

        after :each do
          app.instance_variable_set :@config, Apple::App::Site::Association::Config.new
        end

        it 'should allow accessing' do
          expect(subject).to be_ok
        end

        it 'should return application/json' do
          headers = subject.header
          expect(headers.key?('Content-Type')).to be true
          content_type = headers['Content-Type']
          expect(content_type).to eq('application/json')
        end

        it 'should have keys' do
          json = subject.body
          body = JSON.parse(json)
          expect(body.key?('apps')).to be true
          expect(body.key?('details')).to be true
        end

        it 'should have configured value' do
          json = subject.body
          body = JSON.parse(json)
          body_apps = body['apps']
          body_details = body['details']
          expect(body_apps).to eq(apps)
          expect(body_details).to eq(details.map { |d| d.map { |k, v| [k.to_s, v] }.to_h })
        end
      end
    end
  end
end

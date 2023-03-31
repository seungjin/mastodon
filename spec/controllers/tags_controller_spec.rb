# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  render_views

  describe 'GET #show' do
    let(:tag) { Fabricate(:tag, name: 'test') }

    before do
      get :show, params: { id: tag&.name, format: format }
    end

    context 'when tag exists' do
      context 'when requested as HTML' do
        let(:format) { 'html' }

        it 'returns http success' do
          expect(response).to have_http_status(200)
        end

        it 'returns Vary header' do
          expect(response.headers['Vary']).to eq 'Accept'
        end

        it 'returns no Cache-Control header' do
          expect(response.headers).to_not include 'Cache-Control'
        end
      end

      context 'when requested as JSON' do
        let(:format) { 'json' }

        it 'returns http success' do
          expect(response).to have_http_status(200)
        end

        it 'returns Vary header' do
          expect(response.headers['Vary']).to eq 'Accept'
        end

        it 'returns public Cache-Control header' do
          expect(response.headers['Cache-Control']).to include 'public'
        end
      end
    end

    context 'when tag does not exist' do
      let(:tag) { nil }

      it 'returns http not found' do
        expect(response).to have_http_status(404)
      end
    end
  end
end

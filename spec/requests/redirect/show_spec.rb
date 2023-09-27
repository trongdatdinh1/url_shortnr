# frozen_string_literal: true

describe 'GET /*short' do
  context 'when url exists' do
    let(:url) { create(:url) }

    subject { get "/#{url.short}" }

    it 'redirects to another page' do
      expect(subject).to redirect_to(url.original)
    end
  end

  context 'when url does not exist' do
    subject { get '/A1b2C' }

    it 'redirects to root page' do
      expect(subject).to redirect_to(root_path)
    end
  end
end

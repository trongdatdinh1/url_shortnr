# frozen_string_literal: true

describe 'POST api/v1/shorten' do
  subject { post api_v1_shorten_path, params:, as: :json }

  let(:params) do
    { original: }
  end

  let(:original) { Faker::Internet.url }

  it_behaves_like 'does not check authenticity token'
  it_behaves_like 'there must not be a Set-Cookie in Header'

  context 'with a user account' do
    let(:user) { create(:user) }

    before { sign_in user }

    it 'returns a successful response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'creates the url' do
      expect { subject }.to change(Url, :count).by(1)
    end

    it 'returns the url data', :aggregate_failures do
      subject
      expect(json[:data][:original]).to eq(original)
      expect(json[:data][:short].size).to eq(5)
    end

    context 'when original field is empty' do
      let(:original) { '' }

      it 'does not create a url' do
        expect { subject }.not_to change(Url, :count)
      end

      it 'does not return a successful response' do
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when original field is not url' do
      let(:original) { 'abcdefg' }

      it 'does not create a url' do
        expect { subject }.not_to change(Url, :count)
      end

      it 'does not return a successful response' do
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end

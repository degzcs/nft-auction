describe 'ManageJWT' do
  subject { ManageJWT.instance }

  context 'encode' do
    it 'should encode a number and return a token' do
      token = subject.encode(user_id: 1)
      expect(token).to be_present
    end
  end

  context 'decode' do
    it 'should decode a token and return payload and haeders' do
      token = File.read("spec/fixtures/test_token")
      payload, header= subject.decode(new_token: token)
      expect(payload).to eq({ "user_id"=>1 })
      expect(header).to eq({ "alg"=>"RS256", "exp"=>1645142889 })
    end
  end
end

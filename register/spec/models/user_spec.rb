describe User do
  context 'validation' do
    let(:user) { User.new(username: username, address: address, password: password) }
    let(:password) { address }

    context 'valid user' do
      let(:username) { 'AlanBritho' }
      let(:address) { '0xde709f2102306220921060314715629080e2fb77' }

      it 'validates a user' do
        expect(user.valid?).to be true
      end
    end

    context 'invalid username' do
      let(:username) { nil  }
      let(:address) { '0xde709f2102306220921060314715629080e2fb77' }

      it 'validates a user' do
        expect(user.valid?).to be false
      end
    end

    context 'invalid address' do
      let(:username) { 'AlanBritho' }
      let(:address) { nil }

      it 'validates a user' do
        expect(user.valid?).to be false
      end
    end
  end
end

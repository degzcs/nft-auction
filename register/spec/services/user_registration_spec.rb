describe UserRegistration do

  subject do
    UserRegistration.new(
      username: username,
      address: address)
  end
  let(:username) { 'AlanBritho' }
  let(:address) { '0xde709f2102306220921060314715629080e2fb77' }

  context 'new user' do
    it 'should create a user successfully' do
      expect do
        subject.call
      end.to change{ User.count }.by(1)
      expect(subject.user.id).to be_present
    end
  end

  context 'user already exists' do
    let!(:created_user) do
      User.create!(
        username: username,
        address: address2,
      )
    end

    before :each do
      created_user
    end

    context 'with the registered address' do
      let(:address2) { address }

      it 'should return the user' do
        expect do
          subject.call
        end.to change{ User.count }.by(0)

        expect(subject.success?).to be true
        expect(subject.user.id).to eq created_user.id
      end
    end

    context 'with a new address' do
      let(:address2) { 'worng-address' }

      it 'returns an error message' do
        expect do
          subject.call
        end.to change{ User.count }.by(0)
        expect(subject.success?).to be false
        expect(subject.errors[0]).to eq 'wrong address'
      end
    end
  end
end

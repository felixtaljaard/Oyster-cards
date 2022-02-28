require 'oyster_card'

describe Oystercard do
  
  describe "balance" do
    it "respond to balance" do
      expect(subject).to respond_to(:balance)
    end 
  end

  describe "top_up" do
    it 'should top up balance' do
      expect(subject).to respond_to(:top_up).with(1).argument
      expect{subject.top_up(5)}.to change {subject.balance}.by(5)
    end
    it "raises error if top up exceeds limit" do
      subject.top_up(90)
      expect{ subject.top_up(1) }.to raise_error "Your balance is now £90. Maximum limit of £90 reached" if subject.balance >= Oystercard::LIMIT
    end 
  end

  describe "deduct" do
    it 'should reduce balance by an amount' do
    expect(subject).to respond_to(:deduct).with(1).argument
    subject.top_up(5)
    expect{subject.deduct(5)}.to change {subject.balance}.by(-5)
    end
  end

  describe "in_journey" do
    it 'should return true if touched in' do
      subject.touch_in
      expect(subject.in_journey).to eq true
    end
    it 'should return false if touched out' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq false
    end
  end
end
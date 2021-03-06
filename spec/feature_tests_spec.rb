describe "Feature Tests" do
  let(:card) {Oystercard.new}
  let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
  let(:minimum_fare) {Journey::MINIMUM_FARE}
  let(:station) {Station.new(:name, 1)}
  let(:journeylog) {JourneyLog.new}
  let(:penalty_fare) {Oystercard::PENALTY_FARE}


  describe 'Oystercard' do

    describe 'behaviour of balance on the card' do
      it 'creates a card with a balance' do
        expect(card.balance).to eq 0
      end

      it 'tops up the card by a value and returns the balance' do
        expect{card.top_up(1)}.to change{card.balance}.by(1)
      end

      it 'will not allow balance to exceed maximum balance' do
        card.top_up(maximum_balance)
        expect{card.top_up(1)}.to raise_error("Maximum balance of £#{maximum_balance} exceeded")
      end
    end

    describe '#touch_in' do
      context 'card tops up first'do
        it 'allows a card to touch in and begin journey if balance greater than minimum fare' do
          card.top_up(minimum_fare)
          card.touch_in(station)
          expect(card.journeylog.journey.current_journey[:entry_station]).to eq(station)
        end
      end

      context 'balance is zero' do
        it 'raises error' do
          expect{card.touch_in(station)}.to raise_error "Insufficent funds: top up"
        end
      end


    end

    describe '#touch_out' do

      before do
        card.top_up(minimum_fare)
        card.touch_in(station)
      end

      it 'allows a card to touch out and end a journey' do
          card.touch_out(station)
          expect(card.journeylog.journey.current_journey[:entry_station]).to eq(nil)
      end

      it 'charges customer when they tap out' do
        expect{card.touch_out((station))}.to change{card.balance}.by(-minimum_fare)
      end

      it 'clears the entry station upon touch out' do
        card.touch_out((station))
        expect(card.journeylog.journey.current_journey[:entry_station]).to eq nil
      end

    end

    describe 'previous journeys' do
      it 'can recall all previous journeys' do
        entry_station = Station.new(:station1,1)
        exit_station = Station.new(:station2,1)
        card.top_up(minimum_fare)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journeylog.journey_history).to eq [{entry_station: entry_station, exit_station: exit_station}]
      end
    end
  end

  describe 'Station' do
    it 'allows you to see what zone a station is in' do
      station = Station.new('Aldgate', 3)
      expect(station.zone).to eq 3
    end

    it 'allows you to see what zone a station is in' do
      station = Station.new('Euston', 2)
      expect(station.zone).to eq 2
    end

    it 'allows you to see the stations name' do
      station = Station.new('Aldgate', 3)
      expect(station.name).to eq 'Aldgate'
    end

    it 'allows a stations name to be seen' do
      station = Station.new('Euston', 2)
      expect(station.name).to eq 'Euston'
    end
  end

  describe 'Journey' do
  describe 'Journey defaults' do
    it 'is initially not in a journey' do
      expect(journeylog.journey.current_journey[:entry_station]).to eq(nil)
    end
  end

  it 'deducts a penalty charge if I no touch in' do
    card.top_up(minimum_fare)
    expect { card.touch_out(station) }.to change { card.balance }.by -penalty_fare
  end

  it 'deducts a penalty charge if no touch out' do
    card.top_up(minimum_fare+10)
    card.touch_in(station)
    expect {card.touch_in(station)}.to change { card.balance }.by -penalty_fare
  end
  end

#Customer touches in at one and touches out at another.

it 'deducts balance by MINIMUM_FARE + 2 if two zones difference' do
  card.top_up(Oystercard::MAXIMUM_BALANCE)
  card.touch_in(Station.new('Aldgate', 1))
  card.touch_out(Station.new('Moorgate', 3))
  expect(card.balance).to eq Oystercard::MAXIMUM_BALANCE - Journey::MINIMUM_FARE - 2
end

it 'deducts balance by MINIMUM_FARE if same zone' do
  entry_station = Station.new('Aldgate', 1)
  exit_station = Station.new('Moorgate', 1)
  card.top_up(Oystercard::MAXIMUM_BALANCE)
  card.touch_in(entry_station)
  card.touch_out(exit_station)
  expect(card.balance).to eq Oystercard::MAXIMUM_BALANCE - Journey::MINIMUM_FARE
end

end

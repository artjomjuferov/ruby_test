require_relative 'basket'

describe Basket do

  it { is_expected.to respond_to(:scan).with(1).argument }
  it { is_expected.to respond_to(:total) }

  context '#scan' do
    context 'when wrong item provided' do
      ['01', '004',1].each do |wrong_item|
        it 'raises error' do
          expect { subject.scan wrong_item }.to raise_error ItemNotFoundError
        end
      end
    end

    context 'when nothing was scanned' do
      it 'does not change total' do
        expect(subject.total).to eq 0
      end
    end

    context 'when 001 is scanned' do
      it 'does not add any VAT' do
        subject.scan '001'
        expect(subject.total).to eq 20.0
      end
    end

    context 'when 001 is scanned twice' do
      it 'does add any VAT' do
        2.times {subject.scan '001' }
        expect(subject.total).to eq 20.0*2
      end
    end

    context 'when 002 is scanned' do
      it 'adds reduced VAT' do
        subject.scan '002'
        expect(subject.total).to eq 35.6
      end
    end

    context 'when 003 card is scanned' do
      it 'adds standard VAT' do
        subject.scan '003'
        expect(subject.total).to eq 10.8
      end
    end


    context 'when default test 1' do
      it 'sets total eq to 66.40' do
        scan_all subject, %w(001 002 003)
        expect(subject.total).to eq 66.40
      end
    end

    context 'when default test 2' do
      it 'sets total eq to 91.19' do
        scan_all subject, %w(002 001 002)
        expect(subject.total).to eq 91.19
      end
    end

    context 'when default test 3' do
      it 'sets total eq to 77.20' do
        scan_all subject, %w(003 001 002 003)
        expect(subject.total).to eq 77.20
      end
    end

  end

  private

  def scan_all co, items
    items.each{ |item| co.scan item }
  end
end
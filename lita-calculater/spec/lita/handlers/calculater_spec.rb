require "spec_helper"

describe Lita::Handlers::Calculater, lita_handler: true do
    let(:robot) { Lita::Robot.new(registry) }

    subject { described_class.new(robot) }

    describe 'routing' do
        it { is_expected.to route('Lita calculate 2+2') }
        it { is_expected.to route('Lita calculate 2-2') }
        it { is_expected.to route('Lita calculate 2*2') }
        it { is_expected.to route('Lita calculate 2/2') }

        it { is_expected.to_not route('Lita calculate 2 -2') }
        it { is_expected.to_not route('Lita calculate    22*2') }

        it { is_expected.to_not route('Lita calculate 2.5-2') }
        it { is_expected.to_not route('Lita calculate 2+2.5') }

        it { is_expected.to_not route('Lita CalCulate 4+4') }

        it { is_expected.to_not route('Lita calculate two+two') }
        it { is_expected.to_not route('Lita calculate 1e4=1e4') }
    end

    describe 'functionality' do
        describe ':calculate_expr' do
        let(:a) { rand(1..100) }
        let(:b) { rand{1..100} }

        it 'returns result of the expression' do
            actual = subject.calculate_expr a b
            expected = a + b

            expect(actual).to eq(expected)
        end
        end

        it 'calculate expression when asked to' do
            send_message 'Lita calculate 2+2'
            expect(replies.last).to eq('2 + 2 = 4')
        end
    end
end

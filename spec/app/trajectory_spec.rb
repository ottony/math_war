require 'spec_helper'
include Math

describe Trajectory do
  let(:trajectory) { Trajectory.new }
  let(:time) { rand(0..100) }

  it 'sets default values' do
    expect( trajectory.x ).to eq 0
    expect( trajectory.y ).to eq 0
  end

  context 'creates new function based on string' do
    it 'sets default values' do
      trajectory.x = ''
      trajectory.y = ''

      expect(trajectory.x time ).to eq time
      expect(trajectory.y time ).to eq trajectory.last_y
    end

    it 'calc single function' do
      trajectory.x = 'sin t'
      trajectory.y = 'cos t'

      expect(trajectory.x time).to eq sin( time )
      expect(trajectory.y time).to eq cos( time )
    end

    it 'calc compost function' do
      trajectory.x = 'sin( t ) + cos( 2*t )'
      trajectory.y = 'cos( t ) + log( t, 2 )'

      expect(trajectory.x time).to eq sin( time ) + cos( 2*time )
      expect(trajectory.y time).to eq cos( time ) + log( time, 2 )
    end
  end

  context 'calculates' do
    it 'continue from the last_value' do
      trajectory.x = 'sin( t ) + cos( 2*t )'
      last_x = trajectory.x time

      trajectory.x = 'E*t'

      expect(trajectory.x 0).to eq last_x
      expect(trajectory.x time).to eq last_x + E*time
    end

    it 'constant from any time' do
      trajectory.x = '100'

      expect(trajectory.x time).to      eq 100
      expect(trajectory.x time + 10).to eq 100
    end
  end
end

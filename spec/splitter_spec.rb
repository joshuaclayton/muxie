require 'spec_helper'

describe Muxie::Splitter do
  def split(*percentages)
    Muxie::Splitter.new(percentages).split
  end

  it { split(34, 33, 33).should == [34, 50] }
  it { split(50, 25, 25).should == [50, 50] }
  it { split(20, 60, 20).should == [20, 75] }
  it { split(25, 50, 25).should == [25, 67] }
  it { split(25, 25, 25, 25).should == [25, 34, 50] }
  it { split(20, 20, 20, 20, 20).should == [20, 25, 34, 50] }
end

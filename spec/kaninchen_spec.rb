# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  it 'can fetch the version number' do
    expect(described_class.version).to eq described_class::VERSION
  end
end

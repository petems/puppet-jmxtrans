require 'spec_helper'
require 'json'

describe 'jmxtrans::to_json' do
  context 'with no pretty setting' do
    it { is_expected.to run.with_params({ 'a' => [1, 2] }).and_return({ 'a' => [1, 2] }.to_json) }
  end
  context 'with pretty=true' do
    it { is_expected.to run.with_params({ 'a' => [1, 2] }, true).and_return(JSON.pretty_generate({ 'a' => [1, 2] })) }
  end
  context 'with pretty=false' do
    it { is_expected.to run.with_params({ 'a' => [1, 2] }, false).and_return({ 'a' => [1, 2] }.to_json) }
  end
end

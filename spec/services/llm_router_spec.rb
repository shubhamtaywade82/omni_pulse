require 'rails_helper'

RSpec.describe LlmRouter do
  let(:headers) { {} }

  it 'routes short simple prompt to nano' do
    ctx = RequestContext.new(prompt: 'Hello!', headers:, params: {})
    expect(described_class.new(ctx).model).to eq 'gpt-4.1-nano'
  end

  it 'routes code prompt to mini' do
    ctx = RequestContext.new(prompt: "```ruby\nclass Test; end\n```", headers:, params: {})
    expect(described_class.new(ctx).model).to eq 'gpt-4.1-mini'
  end

  it 'forces full when deep_reason flag present' do
    ctx = RequestContext.new(prompt: 'Explain step-by-step …', headers:, params: { deep_reason: '1' })
    expect(described_class.new(ctx).model).to eq 'gpt-4.1'
  end
end

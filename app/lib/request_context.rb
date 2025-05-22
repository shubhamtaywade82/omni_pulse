class RequestContext
  attr_reader :prompt, :headers, :params

  def initialize(prompt:, headers:, params:)
    @prompt  = prompt
    @headers = headers
    @params  = params
  end

  # def token_count
  #   # ~4 chars per token rough-and-ready
  #   prompt.size / 4
  # end

  def token_count
    TokenCounter.count(prompt)
  end

  def code_heavy?
    prompt.match?(/```|def |class |SELECT |INSERT |RSpec|strategy\(/i)
  end

  def forced_model
    case headers['X-Llm-Model']
    when 'forced-mini' then :mini
    when 'forced-full' then :full
    end
  end

  def deep_reason?
    params[:deep_reason].present?
  end

  def to_h
    { prompt: prompt, headers: headers.to_h.slice('X-Llm-Model'),
      params: params.slice(:deep_reason) }
  end
end

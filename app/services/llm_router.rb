class LlmRouter
  MODEL_MAP = {
    nano: 'gpt-4.1-nano',
    mini: 'gpt-4.1-mini',
    full: 'gpt-4.1'
  }

  def initialize(context)
    @ctx = context
  end

  def model
    return MODEL_MAP[@ctx.forced_model] if @ctx.forced_model

    if @ctx.deep_reason? || @ctx.token_count > 2_500
      MODEL_MAP[:full]
    elsif @ctx.code_heavy?
      MODEL_MAP[:mini]
    else
      MODEL_MAP[:nano]
    end
  end
end

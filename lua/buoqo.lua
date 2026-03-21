function Buoqo_filter(input, env)
  local is_funqo = env.engine.context:get_option("buoqo") -- 0なら算字、1なら雰字

  local map = {
    ["〡"] = "一",
    ["〢"] = "二",
    ["〣"] = "三",
    ["〤"] = "四",
    ["〥"] = "五",
    ["〦"] = "六",
    ["〧"] = "七",
    ["〨"] = "八",
    ["〩"] = "九",
    ["〹"] = "甲",
    ["〺"] = "乙",
    ["〇"] = "零"
  }

  for cand in input:iter() do
    -- 雰字指定、かつmapに候補が存在する時
    if is_funqo and map[cand.text] then
      -- 雰字に差し替え
      yield(Candidate(cand.type, cand.start, cand._end, map[cand.text], cand.comment))
    else
      -- それ以外はそのまま
      yield(cand)
    end
  end
end

return Buoqo_filter
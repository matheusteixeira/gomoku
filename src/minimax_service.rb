class MinimaxService
  def self.evaluate(state, alpha, beta, max_depth)
    puts "Thinkings... Depth: #{max_depth}"
    score = 0
    best_play = [-1, -1]

    return [state.state_value, best_play] if max_depth == 0 || state.end_game?

    if state.current_player.name == 'human'
      state.children_states.each do |child|
        score = evaluate(child, alpha, beta, max_depth-1)[0]
        if score > alpha
          alpha = score
          best_play = child.move
        end

        if alpha >= beta
         break
        end
        return [alpha, best_play]
      end
    else
      state.children_states.each do |child|
        score = evaluate(child, alpha, beta, max_depth-1)[0]
        if score < beta
          beta = score
          best_play = child.move
        end

        if alpha >= beta
          break
        end
        return [beta, best_play]
      end
    end
  end
end

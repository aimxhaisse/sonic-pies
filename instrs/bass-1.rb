use_bpm 124

live_loop :kick do
  sample :bd_haus
  sleep 1
end

notes = [
  [:Db3, 8]
]

live_loop :bass do
  notes.each do |n|
    note, time = n
    
    with_fx :wobble, phase: 1, res: 0, smooth_down: 0.2, smooth_down: 0.2 do
      time.times do
        use_synth :fm
        use_synth_defaults env_curve: 7
        
        with_fx :reverb do
          with_fx :krush, mix: 0.5, cutoff: 129 do
            sleep 0.5
            play note, release: 0.60
            sleep 0.5
          end
        end
      end
      
    end
  end
end


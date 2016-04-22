use_bpm 142

bittersweet = [[:E4, :G4], [:D4, :A4], [:F4, :A4], [:E4, :A4]]

live_loop :bass do
  use_synth_defaults attack: 0.125, decay: 1.5, sustain: 2.5, release: 1, vibrato_depth: 0

  bittersweet.each do |notes|
    with_fx :reverb, mix: 0.25 do
      # right
      with_synth :hollow do
        with_transpose -12 do
          play_chord notes
        end
      end

      # left
      with_synth :beep do
        play_chord notes
      end
      sleep 4
    end
  end

end

symphony = [[[:E4], 4, 1],      [[:G4], 1, 1], [[:B4], 1, 1], [[:G4], 1, 1],        [[:D4, :A4], 1, 1], [[:F4], 1, 1], [[:A4], 2, 2],
            [[:E4, :D5], 4, 1], [[:A4], 1, 1], [[:D5], 2, 2], [[:E4, :C5], 4, 1],   [[:A4], 1, 1],      [[:C5], 2, 2]]

live_loop :mel, sync: :bass do
  use_synth_defaults attack: 0, sustain: 1, release: 1.5, vibrato_depth: 0
  use_synth :fm
  sync :bass

  with_fx :wobble, phase: 256, phase_offset: 0, invert_wave: 1, mix: 1 do
    8.times do
      with_transpose 12 do
        with_fx :reverb do
          symphony.each do |note|
            play_chord note[0], release: note[1], amp: 0.2

            with_synth :blade do
              play_chord note[0], release: note[1], amp: 0.2
            end

            sleep note[2]
          end
        end
      end
    end
  end
end

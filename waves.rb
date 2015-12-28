use_bpm 123

# beats

live_loop :beats do

  use_cue_logging false
  tick

  sample :bd_tek if spread(1, 8).ring.look
  sample :elec_blip2, beat_stretch: 2, amp: 0.5 if spread(3, 16).ring.look

  synth :cnoise, release: 0.6, cutoff: 130, env_curve: 7, amp: 0.5 if spread(1, 16).rotate(8).look
  synth :cnoise, release: 0.1, cutoff: 130, env_curve: 7, amp: 0.25 if spread(1, 2).look

  sleep 0.125
end

live_loop :waves_solo do
  tick
  with_fx :ixi_techno, mix: 0.9, phase: [17, 19, 26, 24].ring.look, cutoff_max: 129 do
    with_fx :krush, cutoff: slide(line(0, 120, steps: 32), tick(:waves_krush)) do
      with_fx :reverb, room: 0.3 do

        4.times do
          uncomment do
            use_synth :mod_fm
            use_synth_defaults release: 0, sustain: 0.5, mod_range: 12
            play chord([:B4, :E4].ring.look).ring.look - 12, amp: 2
          end

          use_synth :fm
          use_synth_defaults release: 0, sustain: 0.5
          play chord([:B4, :E4].ring.look).ring.look, amp: 0.0

          uncomment do
            with_fx :panslicer do
              use_synth :blade
              use_synth_defaults release: 2, sustain: 1
              play chord([:B4, :E4].ring.look).ring.look + 12, amp: 4
            end
          end

          uncomment do
            use_synth :piano
            use_synth_defaults release: 0, sustain: 0.5
            play chord([:B4, :E4].ring.look).ring.look + 12, amp: 4
          end

          sleep 0.5
        end
      end
    end
  end
end

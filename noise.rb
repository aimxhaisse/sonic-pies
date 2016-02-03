use_bpm 66

live_loop :pulse do
  use_synth :blade
  use_synth_defaults release: 0.8

  with_fx :reverb do
    with_fx :gverb do
      with_fx :krush, mix: 0.5 do
        notes = [:C3, :C4, :Eb4, :C4]
        4.times do |i|
          notes.each do |n|
            play n + (i / 2) * 5
            sleep 0.5
          end
        end
      end
    end
  end
end

live_loop :beats do
  tick

  with_fx :hpf, cutoff: 130 do
    sample :elec_cymbal if spread(1, 2).rotate(1).look
  end
  sample :drum_heavy_kick if spread(1, 2).look
  sleep 0.5
end

live_loop :crackles do
  32.times do
    tick
    synth :cnoise, release: 0.1, cutoff: 130, env_curve: 7, amp: 0.5 if spread(3, 12).look
    sleep 0.125
  end
end

live_loop :waha do
  use_synth :beep
  use_synth_defaults sustain: 3, amp: 0.75, attack: 0.5, release: 0.5

  with_fx :bitcrusher, mix: 0.25 do
    with_fx :gverb do
      play :C5
      sleep 4
      play :Es5
      sleep 4
    end
  end
end

live_loop :bass do
  notes = [:C3, :Es3]
  notes.each do |n|
    4.times do
      with_fx :wobble, phase: 0.5, cutoff_min: n - 2, cutoff_max: n + 2, mix: 0.5 do
        play n, sustain: 1, release: 0, amp: 1
      end
      sleep 1
    end
  end
end

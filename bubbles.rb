use_bpm 120

note_base = :A2
note_offset = (ring 0, 0, 5, 7)

live_loop :beat do
  tick

  with_fx :hpf, mix: 0 do
    synth :cnoise, release: 1, cutoff: 110, res: 0.5, env_curve: 7, amp: 0.25 if spread(1, 2).look
    synth :cnoise, release: 0.6, cutoff: 130, env_curve: 7, amp: 1 if spread(1, 2).rotate(8).look
    synth :cnoise, release: 0.1, cutoff: 130, env_curve: 7, amp: 0.25 if spread(1, 2).look

    with_fx :level, amp: 2 do
      sample :bd_tek
      sample :bd_sone
    end

    sleep 1
  end
end

live_loop :crackles do
  sync :beat

  32.times do
    tick
    synth :cnoise, release: 0.1, cutoff: 130, env_curve: 7, amp: 1 if spread(3, 12).look
    sleep 0.125
  end
end

live_loop :synth do
  sync :beat

  use_synth :tb303
  use_synth_defaults release: 0.125, sustain: 0.125, amp: 0.90

  tick(:basstick)

  with_transpose 12 do
    with_fx :ixi_techno, phase: 0.25 do
      with_fx :gverb do
        4.times do
          4.times do
            play chord(note_base + note_offset.look(:basstick), :major, num_octaves: 1).ring.tick
            sleep 0.25
          end
        end
      end
    end
  end
end

live_loop :motive do
  use_synth :fm
  use_synth_defaults release: 0.125, sustain: 0

  with_fx :krush, res: 0.9, cutoff: 120 do
    play chord(note_base + 36).choose if spread(3, 5).ring.tick
  end

  sleep 0.25
end

live_loop :bass do
  sync :beat

  use_synth :dsaw
  use_synth_defaults env_curve: 7, cutoff: 60
  tick(:basstick)

  4.times do
    with_fx :wobble, phase: 0.5, cutoff_min: 60, cutoff_max: 80 do
      play note_base, sustain: 1, release: 0, amp: 0.5
      play note_base + note_offset.look(:basstick), sustain: 1, release: 0
    end
    sleep 1
  end

end

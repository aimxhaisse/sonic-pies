use_bpm 120

live_loop :beat do
  tick

  with_fx :hpf do
    sample :drum_bass_hard
    synth :cnoise, release: 1, cutoff: 110, res: 0.5, env_curve: 7, amp: 0.25 if spread(1, 2).look
    synth :cnoise, release: 0.6, cutoff: 130, env_curve: 7, amp: 1 if spread(1, 2).rotate(8).look
    synth :cnoise, release: 0.1, cutoff: 130, env_curve: 7, amp: 0.25 if spread(1, 2).look
  end

  with_fx :level, amp: 0 do
    sample :bd_tek
  end

  sleep 1
end

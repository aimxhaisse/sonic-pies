use_bpm 120

define :pattern do |p, i, what|
  sample what if p.ring[i] != '.'
end

live_loop :baleze do
  32.times do |n|

    if spread(1, 32).ring[n]
      tick(:bass)
    end

    pattern(".x.x.x.x.x.x.x.x", n, :drum_cymbal_closed)
    pattern("..x...x...x...x.", n, :sn_dolf)
    pattern("x.x.x.x.x.x.x.x.", n, :bd_ada)

    sleep 0.5
  end
end

live_loop :bass do
  sync :baleze

  with_fx :lpf, cutoff: 95 do
    32.times do |n|
      pattern(".x.x.xx..x.x..x.", n, :bass_hit_c)
      sleep 0.5
    end
  end
end

live_loop :fm do
  sync :baleze

  with_fx :lpf, cutoff: 100 do
    use_synth :mod_fm
    use_synth_defaults mod_phase: 1, mod_range: 7, mod_wave: 1, depth: 10, mod_pulse_width: 0.75, mod_wave: 1

    play :A5, sustain: 16, release: 0, amp: 0.25
    play :A4 + [5, 7].ring.tick, sustain: 16, release: 0, amp: 0.25
    sleep 16
  end
end

live_loop :geiger do
  use_synth :tb303

  use_cue_logging false
  use_debug false

  64.times do
    play :A3, sustain: 0.125, release: 0.125, amp: 0.2 if spread(3, 16).tick
    sleep 0.125
  end
end

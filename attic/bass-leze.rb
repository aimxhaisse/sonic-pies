use_bpm 120

define :pattern do |p, i, what|
  sample what if p.ring[i] != '.'
end

live_loop :ostinato do
  n = tick(:tick)

  if spread(1, 32).ring[n]
    tick(:bass)
  end

  pattern(".x.x.x.x.x.x.x.x", n, :drum_cymbal_closed)
  pattern("..x...x...x...x.", n, :sn_dolf)
  pattern("x.x.x.x.x.x.x.x.", n, :bd_ada)

  with_fx :reverb do
    with_fx :ixi_techno, cutoff_min: [60, 65, 70, 75, 80, 85].ring.look(:bass) do
      pattern(".x.x.xx..x.x..x.", n, :bass_hit_c)
    end
  end

  sleep 0.5
end

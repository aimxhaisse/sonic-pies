# Sebastien Rannou <mxs@sbrk.org> @aimxhaisse

use_bpm 60

live_loop :beats_clicks do
  sleep [0.25, 0.125, 0.125, 0.25, 0.25].ring.tick
  sample :drum_cymbal_closed, amp: 0.5
end

live_loop :beats_fat do
  sample :bd_fat, amp: 1
  sleep 0.5
end

live_loop :beats_clap do
  with_fx :reverb do
    sample :bd_ada, rate: 14, amp: line(0.25, 2, steps: 64).tick
  end
  sleep 1
end

live_loop :phex do
  with_fx :reverb, room: 0.9 do
    with_fx :bitcrusher, sample_rate: 6400, bits: 32 do
      with_fx :krush do
        with_fx :slicer do
          cutoff = line(40, 130, steps: 64).tick
          sample :guit_em9, start: 0.5, finish: 0, beat_stretch: 4, cutoff: cutoff
          sleep 1
          sample :guit_e_slide, start: 0.5, finish: 0, beat_stretch: 4, cutoff: cutoff
          sleep 1
        end
      end
    end
  end
end

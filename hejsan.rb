# Sebastien Rannou <mxs@sbrk.org> @aimxhaisse

use_bpm 60

live_loop :beats_tiny do
  sleep [0.25, 0.125, 0.125, 0.25, 0.25].ring.tick
  sample :drum_cymbal_closed, amp: 0.5
end

live_loop :beats_cym do
  with_fx :krush do
    sleep [1, 0.25, 0.75].ring.tick
    sample :elec_beep, rate: 0.5, amp: 1.5
  end
end

live_loop :beats_soft do
  sleep 0.125
  sample :drum_snare_soft
  sleep 0.625
  sample :drum_snare_soft
  sleep 0.25
  sample :drum_snare_soft
end

live_loop :beats_bd do
  sample :bd_fat, amp: 4
  sleep 0.5
end

live_loop :beats_clear do
  sample :elec_twang, amp: 1
  sleep 1
end

live_loop :bass do
  with_fx :krush do
    with_fx :echo, phase: 0.5 do
      4.times do
        sample :bass_dnb_f, cutoff: line(40, 130, steps: 16).ring.tick
        sleep 1
      end
    end
  end
end

# myEUSA - Lok Gweltaz - by s. rannou - mxs.sbrk.org
#
# Live coded w/ Sonic Pi.

use_bpm 120

define :p do |w|
  return '~/s/' + w + '.wav'
end

melody = 9
verse = (melody - 1) % 2 + 1
drums_low = (melody - 1) % 2 + 1
drums_mid = 2 + (melody - 1) % 2 + 1
drums_high = 4 + (melody - 1) % 2 + 1

live_loop :chords, sync: :main do
  stop
  #with_fx :wobble, phase: 32, invert_wave: 1 do
  sample p('chords_' + verse.to_s), release: 8
  #end
  sleep 32
end

live_loop :melody, sync: :main do
  stop
  #with_fx :wobble, phase: 32, invert_wave: 1 do
  with_fx :reverb do
    sample p('melody_' + melody.to_s), amp: 0.5, release: 16
  end
  #end
  sleep 32
end

live_loop :motive, sync: :main do
  stop
  # with_fx :wobble, phase: 32, invert_wave: 1 do
  sample p('motive_' + verse.to_s), release: 16
  # end
  sleep 32
end

live_loop :drums, sync: :main do
  stop
  #  with_fx :wobble, phase: 32, invert_wave: 1, cutoff_min: 129, cutoff_max: 129 do
  sample p('drums_' + drums_low.to_s), attack: 16
  #  end
  sleep 32
end

live_loop :ambient, sync: :main do
  stop
  with_fx :wobble, phase: 64, invert_wave: 1 do
    sample p('flow_1'), beat_stretch: 64, amp: 0.1, attack: 10
    sample p('space_1'), beat_stretch: 64, amp: 0.1, attack: 10
  end
  sleep 64
end

live_loop :main do
  sleep 32
end

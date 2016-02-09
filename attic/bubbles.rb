# s. rannou - mxs.sbrk.org - @aimxhaisse
#
# Bubbles with Sonic Pi.

# That's it for today!

use_bpm 120

note_base = :A2
note_offset = (ring 0, 0, 5, 7)

# This is a loop called beat
live_loop :beat do
  4.times do
    tick

    uncomment do
      synth :cnoise, release: 1, cutoff: 110, res: 0.5, env_curve: 7, amp: 0.25 if spread(1, 2).look
      synth :cnoise, release: 0.6, cutoff: 130, env_curve: 7, amp: 0.25 if spread(1, 2).rotate(8).look
      synth :cnoise, release: 0.1, cutoff: 130, env_curve: 7, amp: 0.25 if spread(1, 2).look
    end
    uncomment do
      sample :bd_tek, amp: 1
      # sample :bd_sone
    end

    sleep 1
  end
end

live_loop :motive do
  sync :beat

  with_fx :ixi_techno, mix: 0.5 do
    with_fx :bitcrusher, sample_rate: 4000 do
      16.times do
        sample :elec_blip2 if spread(4, 13).tick
        sleep 0.25
      end
    end
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
  use_cue_logging false

  sync :beat
  use_synth :fm
  use_synth_defaults release: 0.125, sustain: 0.125, amp: 0.75
  tick(:basstick)

  with_transpose 24 do
    with_fx :ixi_techno, phase: 0.25, mix: 0.5 do
      4.times do
        4.times do
          play chord(note_base + note_offset.look(:basstick), :major, num_octaves: 1).ring.tick
          sleep 0.25
        end
      end
    end
  end
end

live_loop :lead do
  notes = scale(note_base, :major)

  sync :beat

  sequences = [
    # rank in notes, time, sleep
    [[4, 0.25, 0.75],
     [4, 0.25, 0.50],
     [7, 0.25, 0.75]],

    [[4, 0.25, 0.75],
     [4, 0.25, 0.50],
     [7, 0.25, 0.75]],

    [[5, 0.25, 0.25],
     [5, 0.25, 0.50],
     [5, 0.25, 0.50],
     [7, 0.25, 0.75]],

    [[5, 0.25, 0.25],
     [5, 0.25, 0.50],
     [5, 0.25, 0.50],
     [7, 0.25, 0.75]],

    [[4, 0.25, 0.75],
     [4, 0.25, 0.50],
     [7, 0.25, 0.75]],

    [[4, 0.25, 0.75],
     [4, 0.25, 0.50],
     [7, 0.25, 0.75]],

    [[7, 0.25, 0.50],
     [7, 0.25, 0.50],
     [6, 0.25, 0.25],
     [7, 0.25, 0.75]],

    [[7, 0.25, 0.50],
     [7, 0.25, 0.50],
     [6, 0.25, 0.25],
     [7, 0.25, 0.75]],
  ]

  with_fx :panslicer, phase: 0.5, mix: 0.5 do
    with_fx :ixi_techno, mix: 0.25, phase: 0.5 do
      with_fx :gverb, room: 70 do
        with_fx :tanh, krunch: 5, mix: 0.99 do
          sequences.each do |seq|
            seq.each do |rank, duration, pause|
              use_synth :tri
              play notes[rank] + 12, release: duration * 5.0, sustain: duration, cutoff: 120, amp: 1.5
              sleep pause * 2
            end
            sample :elec_bong
            sample :elec_triangle, amp: 0.125
          end
        end
      end
    end
  end

end

live_loop :bass do
  sync :beat
  use_synth :dsaw
  use_synth_defaults env_curve: 7, cutoff: 90

  tick(:basstick)

  4.times do
    with_fx :wobble, phase: 0.5, cutoff_min: 50, cutoff_max: 120 do
      play note_base, sustain: 1, release: 0, amp: 0.5
      play note_base + note_offset.look(:basstick), sustain: 1, release: 0, amp: 0.5
    end
    sleep 1
  end

end

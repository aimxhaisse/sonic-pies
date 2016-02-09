# Blips - by s. rannou <mxs@sbrk.org> @aimxhaisse

use_bpm 124

notes = [45, 47, 49, 50, 52, 54, 56, 57]

live_loop :blips do
  sync :beats

  128.times do
    if spread(5, 16).tick
      use_synth :fm
      use_synth_defaults release: 0.25
      with_fx :lpf, cutoff: 70 do
        play 45 + 24
      end
    end
    sleep 0.25
  end
end

live_loop :bass do
  sync :beats
  use_synth :blade
  use_synth_defaults attack: 0.25, release: 0.5, sustain: 0.125

  4.times do
    notes = [
      [45, 1.5, 2],
      [49, 0.75, 1.5],
      [49, 0.75, 0.5],
      [[52, 50, 50, 54].ring.tick(:last), 1, 0.25],
    ]

    with_transpose 24 do
      with_fx :rlpf, cutoff: 80 do
        with_fx :tanh, krunch: 100 do
          with_transpose 0 do
            for note in notes do
              play note[0], release: note[2] / 4
              sleep note[1]
            end
          end
        end
      end
    end
  end
end

live_loop :clicks do
  sync :beats

  with_fx :level, amp: 1 do
    64.times do
      tick
      synth :cnoise, release: 0.1, cutoff: 130, env_curve: 7, amp: 0.125 if spread(11, 16).look
      sleep 0.25
    end
  end
end

live_loop :beats do
  16.times do
    tick
    with_fx :level, amp: 1 do
      with_fx :hpf, cutoff: 100 do
        sample :drum_bass_hard
        synth :cnoise, release: 1, cutoff: 110, res: 0.5, env_curve: 7, amp: 0.25 if spread(1, 2).look
        synth :cnoise, release: 0.6, cutoff: 130, env_curve: 7, amp: 1 if spread(1, 2).rotate(8).look
        synth :cnoise, release: 0.1, cutoff: 130, env_curve: 7, amp: 0.25 if spread(1, 2).look
      end
    end

    with_fx :level, amp: 1 do
      sample :bd_tek
    end

    sleep 1
  end
end

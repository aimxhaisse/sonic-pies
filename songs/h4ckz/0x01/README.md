# h4ckz - 0x01

Intro.

```
# hackz - 0x01
# mxs @ camembert au lait crew
# https://mxs.sbrk.org/

use_bpm 130 # @32
_0x01 = "/users/mxs/work/sonic-pies/songs/h4ckz/0x01/"

# voice_space, flow_motion, flow_motion_2, ricochet, sweep

note_base = :C3
note_offset = (ring 0, 0, 5, 7)

live_loop :synth do
  use_cue_logging false
  
  use_synth :blade
  use_synth_defaults release: 0.125, sustain: 0.125, amp: 0.75
  tick(:basstick)
  
  with_transpose 12 do
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
```

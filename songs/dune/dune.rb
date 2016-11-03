# Dune.
#
# by mxs @ camembert au lait crew
# https://mxs.sbrk.org/

use_bpm 124

base_dir = "~/work/sonic-pies/songs/dune"

define :mplay do |c|
  if c == 'k'
    sample base_dir, /^kick/
  end
  if c == 'b'
    sample base_dir, /^big-kick/, amp: 0.75
  end
  if c == 's'
    sample base_dir, /^snare/, amp: 0.75, rate: 1
  end
  if c == 'h'
    sample base_dir, /^hat/, amp: 1, beat_stretch: 8, rate: 1
  end
  if c == 'x'
    sample base_dir, /^perc/, amp: 0.8, rate: 0.77
  end
  if c == 'f'
    sample base_dir, /fx/, amp: 1
  end
  if c == 't'
    sample base_dir, /^long-perc/, amp: 1, rate: rrand(0.75, 0.9)
  end
end

define :pclear do |s|
  s.gsub(/\s+/, "")
end

live_loop :main do
  empty = ".... .... .... .... .... .... .... .... .... .... .... .... .... .... .... ...."
  patterns = [
    #  pclear("k... ...."),
    #  pclear(".... .... s... ...."),
    #  pclear("h... .... .... .... .... .... .... ...."),
    #  pclear(".... .... x... ...."),
    #  pclear("y... .... .... ...."),
    #  pclear("f... .... .... .... .... .... .... .... .... .... .... .... .... .... .... ...." + empty),
    #  pclear("t... .... .... .... .... .... .... .... .... .... .... .... .... .... .... ...." + empty),
    #  pclear("b... ...."),
  ].ring
  
  128.times do |i|
    patterns.each do |s|
      mplay s.ring[i]
    end
    
    sleep 0.125
  end
end

notes = [:E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :F2,  :G2].ring
live_loop :dark_lead, sync: :main do
  stop
  
  c = 0
  with_fx :wobble, phase: 1, wave: 1, cutoff_min: :E2 + c, cutoff_max: :E6 do
    with_fx :bitcrusher do
      s1 = synth :fm, sustain: notes.length, release: 0
      s2 = synth :tech_saws, sustain: notes.length, release: 0
      notes.each do |n|
        n = n + 12
        control s1, note: n, cutoff: n + c, amp: 0.5
        control s2, note: n + 12, cutoff: n + c, amp: 0
        sleep 1
      end
    end
  end
end

live_loop :rise, sync: :main do
  stop
  
  with_fx :lpf, cutoff: 40, cutoff_slide: 16 do |s|
    control s, cutoff: 40
    with_fx :vowel, voice: 0, mix: 0.75 do
      with_fx :wobble, phase: 1, wave: 1, mix: 0.125 do
        with_fx :reverb do
          with_fx :bitcrusher do
            s = synth :tech_saws, note: :E3, sustain: 16, amp: 0.25
            notes.each do |n|
              control s, note: n
              sleep 1
            end
          end
        end
      end
    end
  end
end

live_loop :melody, sync: :main do
  stop
  
  with_fx :panslicer, phase: 0.5, mix: 0.125 do
    with_fx :wobble, invert_wave: 1, phase: 1, cutoff_min: 60, cutoff_max: 80 do
      with_fx :lpf, cutoff: 40, cutoff_slide: 16 do |s|
        control s, cutoff: 40
        with_fx :flanger do
          [
            [[:E3, 0.5], [:E3, 0.25], [:E3, 0.75], [:E3, 1], [:E3, 0.5], [:G3, 0.25], [:E3, 1]],
            [[:E3, 0.5], [:E3, 0.25], [:E3, 0.75], [:E3, 1], [:E3, 0.5], [:G3, 0.25], [:E3, 1]],
            [[:E3, 0.5], [:E3, 0.25], [:E3, 0.75], [:E3, 1], [:E3, 0.5], [:G3, 0.25], [:E3, 1]],
            [[:E3, 0.5], [:E3, 0.25], [:G3, 0.75], [:E3, 1], [:Gs3, 0.5], [:G3, 0.25], [:G3, 1]],
          ].each do |mel|
            total = 0
            mel.each do |n, r|
              synth :tech_saws, note: n + 12, res: 0, release: r, amp: 0.5
              #  synth :dpulse, note: n + 12, res: 0, release: r, amp: 0.20
              #  synth :pluck, note: n + 12, res: 0, release: r, amp: 0.50
              
              sleep r
              total = total + r
            end
            sleep 4 - total
          end
        end
      end
    end
  end
end

live_loop :dark_bass, sync: :main do
  stop
  
  c = 0
  with_fx :wobble, phase: 1, res: 0, smooth_down: 0.2, smooth_down: 0.2 do
    notes.each do |n|
      use_synth :fm
      use_synth_defaults env_curve: 7
      with_fx :krush, mix: 0.5, cutoff: n + 36 + c do
        sleep 0.5
        play n + 12, release: 0.60, amp: 0.4
        sleep 0.5
      end
    end
  end
end

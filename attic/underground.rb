# Still still WIP

use_bpm 124

define :mplay do |c|
  if c == 'k'
    sample :bd_haus, lpf: :E4
  end
  if c == 'b'
    sample :bd_klub
  end
  if c == 's'
    with_fx :reverb, mix: 0.5 do
      with_fx :krush do
        sample :bd_fat, start: 0.15, finish: 0.2, rate: 0.4, amp: 0.25
      end
    end
  end
  if c == 'c'
    synth :noise, release: 0.125, amp: 0.25, res: 0.999, cutoff: :E3
  end
end

define :clear do |s|
  s.gsub(/\s+/, "")
end

live_loop :main do
  patterns = [
    clear("k... .... k... ...."),
    clear(".... .... s... ...."),
    clear(".... .... .... ...."),
    clear(".c.. ..c. ..c. c..."),
  ].ring
  
  16.times do |i|
    patterns.each do |s|
      mplay s[i]
    end
    
    sleep 0.125
  end
end

notes = [:E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :E2,  :F2,  :G2].ring
cutoff = [-5, 0, 5, 12]
variations = "_-__-`____-``_``".ring

live_loop :dark_lead, sync: :main do
  c = 0
  with_fx :wobble, phase: 1, wave: 1, cutoff_min: :E2 + c, cutoff_max: :E6 do
    with_fx :bitcrusher do
      s = synth :fm, pulse_width: 0.9, sustain: notes.length, release: 0, amp: 0.25
      notes.each do |n|
        n = n + 12
        control s, note: n, cutoff: n + c
        sleep 1
      end
    end
  end
end

live_loop :melody, sync: :main do
  total = 0
  with_fx :vowel, voice: 3 do
    with_fx :flanger do
      [[:E3, 0.25], [:C4, 0.25], [:E3, 0.75], [:Gs3, 0.5], [:G3, 0.75], [:G3, 0.25], [:E3, 1]].each do |n, r|
        synth :fm, note: n, release: r, amp: 2
        sleep r
        total = total + r
      end
    end
  end
  sleep 4 - total
end

live_loop :dark_bass, sync: :main do
  c = 0
  with_fx :wobble, phase: 16, invert_wave: 1, phase: 32, cutoff_min: 100, cutoff_max: 110 do
    with_fx :wobble, phase: 1, res: 0, smooth_down: 0.2, smooth_down: 0.2 do
      notes.each do |n|
        use_synth :fm
        use_synth_defaults env_curve: 7
        with_fx :reverb do
          with_fx :krush, mix: 0.5, cutoff: n + 36 + c do
            sleep 0.5
            play n + 12, release: 0.60, amp: 0.25
            sleep 0.5
          end
        end
      end
    end
  end
end

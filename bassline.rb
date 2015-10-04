# coding: utf-8
# Sébastien Rannou <mxs@sbrk.org> @aimxhaisse

base_note = :Cb2
base_chord = chord(base_note, :minor)

define :slide do |line, ticker|
  n = ticker
  if n >= line.to_a.length
    return line.last
  end
  return line[n]
end

live_loop :bassline do
  use_synth :blade
  use_synth_defaults cutoff: slide(line(80, 100, steps: 16), tick(:bassline_cutoff)), release: 0.25

  # tick_reset(:bassline_cutoff)
  # tick_reset(:bassline_reverb)

  base_bass = base_chord.ring.tick(:bassline_note)
  notes = [base_bass, base_bass, base_bass + 12].ring

  with_fx :reverb, room: slide(line(0.05, 0.2, steps: 16), tick(:bassline_reverb)), mix: 0.99 do
    15.times do
      play notes.tick
      sleep 0.25
    end
  end

  sleep 0.25
end

live_loop :ambient do
  base_ambient = base_chord.ring.tick(:bassline_note)
  use_synth :fm
  use_synth_defaults release: 0, sustain: 4, noise: 3, ring: 0.5, amp: slide(line(0, 0.2, steps: 16), tick(:amp_ambient))
  play base_ambient
  sleep 4
end

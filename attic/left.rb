# Sebastien Rannou <mxs@sbrk.org> @aimxhaisse

# Helpers for the left-hand.

define :chordify do |n, what|
  notes = []
  notes[0], notes[1], notes[2] = chord(n, what)
  notes.append(notes[1])
  return notes.ring
end

define :loopify do |n|
  notes = []
  for note in chordify(n, :major)
    notes.append(note)
  end
  for note in chordify(n, :major)
    notes.append(note)
  end
  for note in chordify(n, :minor)
    notes.append(note)
  end
  for note in chordify(n, :minor)
    notes.append(note)
  end
  return notes.ring
end

live_loop :loop do
  use_synth :dark_ambience
  play loopify(:Bs4).tick
  sleep 0.5
end

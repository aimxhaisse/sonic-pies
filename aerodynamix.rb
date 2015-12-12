# Aerodynamix - by s. rannou <mxs@sbrk.org> @aimxhaisse
#
# An attempt to recreate 'Daft Punk - Aerodynamic'

use_bpm 123

# Base sample extracted from Il Maqcuillage Lady - Sister Sledge

aero_base = "~/il-maquillage-lady-sample.aiff"
load_sample aero_base

# Introduction

define :daft_bell do |n|
  use_synth :pretty_bell

  synth :pretty_bell, note: n - 12, amp: 0.1, attack: 0, decay: 8, release: 2
  synth :pretty_bell, note: n - 9, amp: 0.1, attack: 0, decay: 8, release: 2
  synth :pretty_bell, note: n, amp: 2, attack: 0, decay: 3, sustain_level: 0.5, release: 3
  synth :pretty_bell, note: n + 4, amp: 0.25, attack: 0, decay: 0.5, release: 2
  synth :pretty_bell, note: n + 7, amp: 0.05, attack: 1, release: 4
  synth :pretty_bell, note: n + 9, amp: 0.05, attack: 0, release: 3
  synth :pretty_bell, note: n + 12, amp: 1, attack: 0, decay: 4, sustain_level: 0.5, release: 2
  synth :pretty_bell, note: n + 14, amp: 0.25, attack: 0, release: 4
  synth :pretty_bell, note: n + 17, amp: 0.20, attack: 0, release: 3
  synth :pretty_bell, note: n + 21, amp: 0.125, attack: 0, decay: 1, sustain_level: 0.125, release: 4
end

live_loop :intro do
  sync :do_intro

  with_fx :reverb, root: 0.75 do
    daft_bell :A3
    sleep 8
  end
end

# Verse

define :aero_sample do |samples, alt|
  # 1 beat = 0.0625, 0.5 beat = 0.03125
  use_sample_defaults beat_stretch: 16, amp: 3

  samples.each do |what|
    sample aero_base, start: 0.934, finish: 0.96525 if what == :bass_1
    sample aero_base, start: 0.653, finish: 0.68425 if what == :bass_2
    sample aero_base, start: 0.090, finish: 0.1525 if what == :guit_1
    sample aero_base, start: 0.465, finish: 0.49625 if what == :guit_2
    sample aero_base, start: 0.465, finish: 0.480625 if what == :guit_3 and alt
  end
end

live_loop :verse do
  sync :do_verse

  alt = [false, false, false, true].ring.tick(:flavor)
  do_invert_flanger = [0, 1].ring.tick(:invert_flanger)

  samples = [[[:bass_1], 0.5],
             [[:guit_1, :guit_3], 0.25],
             [[:bass_1], 0.5],
             [[:guit_3], 0.25],
             [[:bass_1], 0.5],
             [[:guit_2], 0.5],
             [[:guit_1], 1],
             [[:bass_2], 0.5]]

  samples.each do |s, delay|
    aero_sample(s, alt)
    sleep delay
  end
end

# Guitare Solo

solo_chords = [
  [:D3, :Fs2, :B2],
  [:D3, :Gs2, :B2],
  [:G3, :B2, :E3],
  [:E3, :A2, :Cs3],

  [:D3, :Fs3, :B2],
  [:D3, :Gs3, :B2],
  [:G3, :B2, :E3],
  [:E3, :A2, :Cs3],
]

live_loop :solo do
  sync :do_solo

  use_synth :zawa
  use_synth_defaults attack: 0.03, sustain: 0.17, release: 0.1, res: 0.9, phase: 2, wave: 2, amp: 0.5

  with_transpose 12 do
    c = solo_chords.ring.tick(:patterns)
    with_fx :bitcrusher, sample_rate: 8000, mix: 0.5 do
      4.times do
        melody = c.dup
        melody.push(c[1])
        tick_reset :note
        4.times do
          n = melody.ring.tick(:note)
          play note: n
          sleep 0.25
        end
      end
    end
  end
end

live_loop :advanced do
  sync :do_advanced
  32.times do
    tick
    sample :bd_tek, amp: 1.5 if spread(1, 16).look
    sample :bd_tek, amp: 1.5 if spread(1, 32).rotate(4).look
    synth :cnoise, release: 0.5, cutoff: 130, env_curve: 7, amp: 2 if spread(1, 16).rotate(8).look
    synth :cnoise, release: 0.1, cutoff: 130, env_curve: 7, amp: 0.5 if spread(1, 2).look
    sleep 0.125
  end
end

live_loop :aerodynamix do
  4.times do
    cue :do_intro
    sleep 8
  end
  16.times do
    cue :do_verse
    sleep 4
  end
  16.times do
    cue :do_verse
    cue :do_advanced
    sleep 4
  end
  16.times do
    cue :do_solo
    sleep 4
  end
  16.times do
    cue :do_solo
    cue :do_advanced
    sleep 4
  end
  16.times do
    cue :do_solo
    cue :do_verse
    cue :do_advanced
    sleep 4
  end
  cue :do_intro
  stop
end

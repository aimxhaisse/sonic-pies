port_beats = "midisport_4x4_anniv_b"
chan_beats = 10

use_bpm 130

live_audio :mixer, stereo: true

# Volca beats.
define :volcabeats do |p, i|
  trig = p.tr(' ', '').ring[i]
  
  midi 36, port: port_beats, channel: chan_beats if trig == 'k' # kick
  midi 38, port: port_beats, channel: chan_beats if trig == 's' # snare
  midi 39, port: port_beats, channel: chan_beats if trig == 'c' # clap
  midi 42, port: port_beats, channel: chan_beats if trig == 'h' # low hat
  midi 46, port: port_beats, channel: chan_beats if trig == 'H' # high hat
  midi 43, port: port_beats, channel: chan_beats if trig == 't' # low tom
  midi 50, port: port_beats, channel: chan_beats if trig == 'T' # high tom
  midi 49, port: port_beats, channel: chan_beats if trig == 'r' # crash
  midi 75, port: port_beats, channel: chan_beats if trig == 'a' # clav
  midi 67, port: port_beats, channel: chan_beats if trig == 'b' # agogo
end

live_loop :beats do
  16.times do
    n = tick(:tick)
    volcabeats ".... .... .... .b.. .... .... ...b. ....", n
    midi_cc 52, range(30, 40, 0.2).ring[n]
    sleep 1.0 / 16.0
  end
end

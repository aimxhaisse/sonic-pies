# Intro

use_bpm 120

# loops
s_dir = "/Volumes/mxs-samsung/samples/samplephonics/reality_distortion/loops/"

s_aer = s_dir + "atmospherics/123_Gm_BreakIt_SP_01.wav"
s_bea = s_dir + "beats/beat mid loops/123_MotorikMadnes_SP_01.wav"
s_mel = s_dir + "melodic/melodic arps/123_Gm_SoAnalog_SP_01.wav"

load_sample s_aer
load_sample s_bea
load_sample s_mel

# houellebecq
h_dir = "/Volumes/mxs-samsung/samples/nde/"

s_hou = [
  h_dir + "beaudelaire_1.wav",
  h_dir + "beaudelaire_2.wav",
  h_dir + "beaudelaire_3.wav",
  h_dir + "beaudelaire_4.wav",
  h_dir + "beaudelaire_5.wav",
  h_dir + "beaudelaire_6.wav",
  h_dir + "beaudelaire_7.wav"
]

s_hou.each do |s|
  load_sample s
end

live_loop :sync do
  sleep 4
end

live_loop :houellebecq do
  sync :sync

  with_fx :level, amp: 10 do
    # sample s_hou[0]
    sleep 16
  end

end

live_loop :chords do
  sync :sync

  with_fx :reverb do
    with_fx :krush, cutoff: 80, res: 0.5 do
      sample s_aer, beat_stretch: 32, amp: 0, attack: 8
    end
  end

  sample s_aer, beat_stretch: 32, amp: 1, release: 8
  sleep 32
end

live_loop :mel do
  sync :sync

  sample s_mel, beat_stretch: 16, cutoff: 60, amp: 0, attack: 8

  with_fx :ixi_techno, phase: 32, cutoff_min: 60, res: 0.25 do
    with_fx :tanh, krunch: 20, mix: 0.25 do
      sample s_mel, beat_stretch: 16, amp: 0, attack: 8
    end
  end

  sleep 16
end

live_loop :beat do
  sync :sync

  sample s_bea, beat_stretch: 16, amp: 1
  sleep 16
end

live_loop :bd do
  sync :sync

  16.times do
    sample :bd_fat, amp: 0
    sleep 1
  end
end

# Sebastien Rannou <mxs@sbrk.org> @aimxhaisse

live_loop :beats do
  with_fx :echo, phase: 0.1, mix: 0.05 do
    with_fx :rhpf, cutoff: 90, res: 0.8 do
      with_fx :reverb, mix: 0.6, room: 0 do
        sample :bd_zome, rate: 1, amp: 5
      end
    end
  end
  sleep 1
end

live_loop :beats do
  with_fx :echo, phase: 0.5, mix: 0.1 do
    3.times do
      sample :bd_haus
      sleep 0.5
      sample :sn_dub
      sleep 0.5
    end
    sample :bd_haus
    sleep 0.5
    sample :sn_dub
    sleep 0.25
    sample :sn_dub
    sleep 0.25
  end
end

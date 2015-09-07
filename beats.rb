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

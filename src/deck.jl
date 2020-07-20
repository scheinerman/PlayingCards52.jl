export deck

"""
`deck()` returns a 52-long list of all cards in random order.
Use `deck(false)` to get a list in new-box order (from Ace of Clubs
to King of Spades).
"""
function deck(shuffle::Bool=true)::Vector{Card}
    idx = collect(1:52)
    if shuffle
        idx = randperm(52)
    end

    result = Card.(idx)
end

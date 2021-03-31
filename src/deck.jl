export deck, print_deck

"""
`deck()` returns a 52-long list of all cards in random order.
Use `deck(false)` to get a list in new-box order (from Ace of Clubs
to King of Spades).
"""
function deck(shuffle::Bool = true)::Vector{Card}
    idx = collect(1:52)
    if shuffle
        idx = randperm(52)
    end

    result = Card.(idx)
end


"""
`print_deck(d)` assumes that `d` is a 52-long list of `Card`s
(that is, a full deck) and then prints `d` in four lines
with 13 cards per line.
"""
function print_deck(d::Vector{Card})
    @assert length(d) == 52 "You're not playing with a full deck"
    for j = 1:4
        a = 13 * (j - 1) + 1
        for k = a:a+12
            print(d[k])
            if k < a + 12
                print(" ")
            else
                println()
            end
        end
    end
end

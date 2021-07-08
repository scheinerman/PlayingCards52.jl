module PlayingCards52
using LinearAlgebra, Random


import LinearAlgebra: rank
import Base: string, show


export Card, Suit, suit, rank, index, color

suit_list = [:clubs, :diamonds, :hearts, :spades]
suit_set = Set(suit_list)
suit_strings = ["♣", "♢", "♡", "♠"]
suit_number = Dict{Symbol,Int}(:clubs => 1, :diamonds => 2, :hearts => 3, :spades => 4)

rank_list = "A23456789TJQK"

struct Suit
    s::Int8
    function Suit(s::Integer)
        @assert 1 <= s <= 4 "Suit index must be 1, 2, 3, or 4"
        new(s)
    end

    function Suit(s::Symbol)
        chk = [s == c for c in suit_list]
        if !any(chk)
            error("No such suit $s.\nUse one of these: $suit_list.")
        end
        s = findfirst(chk)
        new(s)
    end
end

"""
`Card(suit,rank)` creates a new playing card.
* `suit` is one of `:clubs`, `:diamonds`, `:hearts`, `:spades`
* `rank` is an integer from `1` (for Ace) to `13` (for King)
"""
struct Card
    suit::Suit
    rnk::Int8
    function Card(s::Symbol, r::Int)
        @assert 1 <= r <= 13 "Card rank must be between 1 (ace) and 13 (king)"
        new(Suit(s), r)
    end
    function Card(s::Suit, r::Int)
        @assert 1 <= r <= 13 "Card rank must be between 1 (ace) and 13 (king)"
        new(s, r)
    end
end

"""
`Card(idx)` where `idx` is from 1 to 52 returns a `Card` from the
Ace of Clubs to the King of Spades.
"""
function Card(idx::Int)::Card
    @assert 1 <= idx <= 52 "Card index must be from 1 to 52"
    si = Int.(ceil(idx / 13))  # suit index
    ri = idx - 13 * (si - 1)
    Card(suit_list[si], ri)
end

"""
`Card()` returns a random card.
"""
Card()::Card = Card(mod(rand(Int), 52) + 1)

"""
`index(C::Card)` returns an index `k` (with `1 <= k <= 52`)
such that `C == Card(k)`.
"""
function index(C::Card)::Int
    s = suit(C).s
    return 13 * (s - 1) + rank(C)
end


"""
`rank(C)` returns a number from `1` (for Ace) to `13` (for King)
"""
rank(c::Card)::Int = c.rnk


"""
`suit(C)` returns the suit of the card `C`. It is one of the following:
`♣`, `♢`, `♡`, or `♠`.
"""
suit(c::Card)::Suit = c.suit

string(s::Suit)::String = suit_strings[s.s]


"""
`color(C::Card)` returns the color of the card as either
the `Symbol` `:black` or `:red`.
"""
function color(C::Card)::Symbol
    s = suit(C).s
    if s == 1 || s == 4
        return :black
    end
    return :red
end


function string(C::Card)::String
    return rank_list[rank(C)] * string(suit(C))
end

function show(io::IO, C::Card)
    print(io, string(C))
end

function show(io::IO, S::Suit)
    print(io, string(S))
end

include("ordering.jl")
include("deck.jl")
include("shuffle.jl")
include("input.jl")
include("unicode.jl")
include("card_names.jl")

end # module

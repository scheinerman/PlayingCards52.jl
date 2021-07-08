export name

rank_names = [
    "ace"
    "two"
    "three"
    "four"
    "five"
    "six"
    "seven"
    "eight"
    "nine"
    "ten"
    "jack"
    "queen"
    "king"
]

suit_names = [
    "clubs"
    "diamonds"
    "hearts"
    "spades"
]

"""
    name(C::Card)::String

Return the long-form name of the card.
```julia
julia> c = Card(:diamonds, 10)
T♢

julia> name(c)
"ten of diamonds"
```
"""
function name(c::Card)::String
    rank_names[rank(c)] * " of " * suit_names[suit(c).s]
end

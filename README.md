# PlayingCards

Cards from a standard deck of fifty two.


[![Build Status](https://travis-ci.org/scheinerman/PlayingCards.jl.svg?branch=master)](https://travis-ci.org/scheinerman/PlayingCards.jl)


[![codecov.io](http://codecov.io/github/scheinerman/PlayingCards.jl/coverage.svg?branch=master)](http://codecov.io/github/scheinerman/PlayingCards.jl?branch=master)

## Pick a card

A `Card` is a standard playing card from a fifty-two card deck. The
following functions return a `Card`:
* `Card(suit,rank)` where `suit` is one of the symbols `clubs`, `diamonds`,
`hearts`, or `spades` and `rank` is an integer from `1` (for Ace) to
`13` (for King).
* `Card(index)` where `index` is an integer from `1` (for the Ace of Clubs)
to `52` (for the King of Spades).
* `Card()` returns a random card.

```
julia> using PlayingCards

julia> Card(:diamonds,12)
Q♢

julia> Card(49)
T♠

julia> Card()
Q♠
```

The function `string` returns a two-character representation of the
`Card`:
```
julia> string(Card(22))
"9♢"
```


## Determine suit and rank

The functions `suit` and `rank` return the suit (as a `Symbol`) and the
rank (as an `Int`) of the card.
```
julia> c = Card()
J♣

julia> suit(c)
:clubs

julia> rank(c)
11
```

The function `index` returns a distinct integer value (from `1` to `52`)
for the card.
```
julia> c = Card(17)
4♢

julia> index(c)
17
```

## Ordering

Two `Card`s can be compared with the usual ordering operators (such as `<`).
The ordering of cards is determined first by rank and, if of the same rank,
by suit (alphabetically, as in bridge).
```
julia> Card(:diamonds,10) < Card(:hearts,10)
true

julia> Card(:diamonds,10) < Card(:clubs,10)
false
```

The `ace_high` function is used to determine if an Ace is higher
or lower than the other ranks. Use `ace_high(true)` or `ace_high(false)`
to set your preference. A call to `ace_high()` returns the current setting.
```
julia> ace_high()
true

julia> Card(:spades,1) < Card(:diamonds,5)
false

julia> ace_high(false)
false

julia> Card(:spades,1) < Card(:diamonds,5)
true
```

## Dealing

The function `deck()` returns a 52-long array containing all possible
cards in random order. Use `deck(false)` for them to be returned in a
"new box" order.
```
julia> deck()
52-element Array{Card,1}:
 J♣
 2♣
 T♢
 8♣
 K♡
 8♢
 3♢
 T♡
 2♠
 Q♣
 ⋮
 Q♠
 4♠
 5♠
 7♢
 A♠
 3♡
 K♣
 3♠
 4♢

julia> deck(false)
52-element Array{Card,1}:
 A♣
 2♣
 3♣
 4♣
 5♣
 6♣
 7♣
 8♣
 9♣
 T♣
 ⋮
 5♠
 6♠
 7♠
 8♠
 9♠
 T♠
 J♠
 Q♠
 K♠
```

Deal a random poker hand like this:
```
julia> using ShowSet

julia> Set(deck()[1:5])
{2♠,6♢,6♡,T♠,K♣}
```

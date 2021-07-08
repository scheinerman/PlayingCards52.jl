# PlayingCards52

Cards from a standard deck of fifty two.





## Pick a Card

A `Card` is a standard playing card from a fifty-two card deck. The
following functions return a `Card`:
* `Card(suit,rank)` where `suit` is one of the symbols `:clubs`, `:diamonds`,
`:hearts`, or `:spades` and `rank` is an integer from `1` (for Ace) to
`13` (for King).
* `Card(index)` where `index` is an integer from `1` (for the Ace of Clubs)
to `52` (for the King of Spades).
* `Card()` returns a random card.

```julia
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
```julia
julia> string(Card(22))
"9♢"
```

### Alternative input

Cards can be entered via their two-character representation. For example, the nine of diamonds can be entered as `9♢`. That is, type `9` then `\diamondsuit` and then TAB. One may also use `\:diamonds:`+TAB. Likewise for the other suits.

Face cards, tens, and aces can also be entered in this way (using the capital letters T, J, Q, K, and A followed by the suit symbol):
```julia
julia> c = K♠;

julia> println(c)
K♠

julia> T♡ == Card(:hearts,10)
true
```
These cards can also be entered with a leading 1, 10, 11, 12, or 13:
```julia
julia> 10♢
T♢

julia> 13♠
K♠

julia> 1♣
A♣
```

Note that the four suit symbols are defined as objects of type `Suit`.
```julia
julia> typeof(♠)
Suit
```
A `Suit` be created either by typing (say) `\heartsuit`+TAB (giving ♡) or `Suit(:hearts)`
```julia
julia> Suit(:hearts) == ♡
true
```

Cards can be created either using either a symbol `:spades` or suit `♠`:
```julia
julia> a = Card(:spades,5)
5♠

julia> b = Card(♠,5)
5♠

julia> a==b
true
```

## Determine Properties

The functions `suit` and `rank` return the suit (as a `Suit`) and the
rank (as an `Int`) of the card.
```julia
julia> c = Card()
J♣

julia> suit(c)
♣

julia> rank(c)
11
```

The function `index` returns a distinct integer value (from `1` to `52`)
for the card.
```julia
julia> c = Card(17)
4♢

julia> index(c)
17
```

Use `color` to determine if the `Card` is red or black:
```julia
julia> C = Card(:clubs,9)
9♣

julia> color(C)
:black

julia> color(Card(27))  # this is the Ace of Hearts
:red
```

## Ordering

Two `Card`s can be compared with the usual ordering operators (such as `<`).
The ordering of cards is determined first by rank and, if of the same rank,
by suit (alphabetically, as in bridge).
```julia
julia> Card(:diamonds,10) < Card(:hearts,10)
true

julia> Card(:diamonds,10) < Card(:clubs,10)
false
```

The `ace_high` function is used to determine if an Ace is higher
or lower than the other ranks. Use `ace_high(true)` or `ace_high(false)`
to set your preference. A call to `ace_high()` returns the current setting.
```julia
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

Use the function `print_deck()` to see all 52 cards in four lines of
thirteen cards each.
```julia
julia> d = deck(); print_deck(d)
2♠ J♢ K♠ 3♣ Q♢ 6♢ K♡ 9♣ A♠ 8♢ 7♡ J♣ 4♠
8♣ T♢ T♣ 2♢ 4♣ 3♡ T♡ 6♡ Q♣ A♣ 4♢ 8♡ 8♠
3♠ 3♢ 5♣ J♠ 5♢ 6♣ A♢ T♠ Q♡ 7♣ 9♠ 7♠ 6♠
Q♠ J♡ 7♢ 2♡ A♡ 9♢ 2♣ 4♡ 5♡ K♣ 9♡ 5♠ K♢

julia> d = deck(false); print_deck(d)
A♣ 2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ T♣ J♣ Q♣ K♣
A♢ 2♢ 3♢ 4♢ 5♢ 6♢ 7♢ 8♢ 9♢ T♢ J♢ Q♢ K♢
A♡ 2♡ 3♡ 4♡ 5♡ 6♡ 7♡ 8♡ 9♡ T♡ J♡ Q♡ K♡
A♠ 2♠ 3♠ 4♠ 5♠ 6♠ 7♠ 8♠ 9♠ T♠ J♠ Q♠ K♠
```

Deal a random poker hand like this:
```julia
julia> using ShowSet

julia> Set(deck()[1:5])
{2♠,6♢,6♡,T♠,K♣}
```

## Long-Form Names

The `name` function returns a long-form name of a card. 
```julia
julia> c = Card(:hearts,1)
A♡

julia> name(c)
"ace of hearts"
```


## Shuffling

The `deck()` function returns a randomly shuffled deck of cards with all 52! 
possible orderings equally likely. 
However, if one wishes to manually randomize the deck, or to randomize an ordered deck
as returned by `deck(false)`, we provide the functions `shuffle`, `riffle`, and `cut`.
These functions are typically applied to a full deck of 52 cards, but may be used
on any list.

### Shuffle

The functions `shuffle` and `shuffle!` from the `Random` module are 
imported and so may be applied to card decks. These functions apply a random
permutation to the cards (all orders equally likely). The function `shuffle` 
returns a new deck, leaving the original deck unchanged. The function `shuffle!`
overwrites the deck in the new order.

### Riffle 

The functions `riffle` and `riffle!` apply a random riffle shuffle to the deck
using the [Gilbert–Shannon–Reeds model](https://en.wikipedia.org/wiki/Gilbert%E2%80%93Shannon%E2%80%93Reeds_model). The former leaves the original 
deck unchanged and the latter overwrites the deck.
```julia
julia> d = deck(false); print_deck(d)
A♣ 2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ T♣ J♣ Q♣ K♣
A♢ 2♢ 3♢ 4♢ 5♢ 6♢ 7♢ 8♢ 9♢ T♢ J♢ Q♢ K♢
A♡ 2♡ 3♡ 4♡ 5♡ 6♡ 7♡ 8♡ 9♡ T♡ J♡ Q♡ K♡
A♠ 2♠ 3♠ 4♠ 5♠ 6♠ 7♠ 8♠ 9♠ T♠ J♠ Q♠ K♠

julia> riffle!(d); print_deck(d)
A♣ 4♡ 5♡ 6♡ 2♣ 3♣ 4♣ 7♡ 8♡ 9♡ T♡ J♡ Q♡
K♡ A♠ 2♠ 5♣ 6♣ 7♣ 8♣ 9♣ T♣ J♣ Q♣ K♣ A♢
3♠ 4♠ 5♠ 6♠ 7♠ 2♢ 3♢ 8♠ 4♢ 5♢ 6♢ 7♢ 9♠
8♢ 9♢ T♠ T♢ J♢ Q♢ J♠ K♢ Q♠ A♡ 2♡ K♠ 3♡
```
Note that a single riffle shuffle does a poor job at randomizing
the deck.


### Cut

The functions `cut` and `cut!` are used to cut the deck. 
* `cut!(d,idx)` moves cards `1` through `idx` to the back of the deck; the
new first card is the one formerly at position `idx+1`.
* `cut!(d)` cuts the deck a random index.  If the deck has `n` cards,
then the cut location is given by the binomial random variable `B(n,1/2)`.


```julia
julia> d = deck(false);

julia> cut!(d)

julia> print_deck(d)
Q♢ K♢ A♡ 2♡ 3♡ 4♡ 5♡ 6♡ 7♡ 8♡ 9♡ T♡ J♡
Q♡ K♡ A♠ 2♠ 3♠ 4♠ 5♠ 6♠ 7♠ 8♠ 9♠ T♠ J♠
Q♠ K♠ A♣ 2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ T♣ J♣
Q♣ K♣ A♢ 2♢ 3♢ 4♢ 5♢ 6♢ 7♢ 8♢ 9♢ T♢ J♢
```

## Unicode Characters

The standard playing cards have unicode character representations. Use `Char(c)` to return that character.

```julia
julia> c = Card(:diamonds, 4);

julia> Char(c)
'🃄': Unicode U+1F0C4 (category So: Symbol, other)
```

The characters are unreadable at small font sizes (e.g., 12 point); they need to be enlarged to be visible.

![](./4D.png)

## Acknowledgement

Developed  with input from [@charleskawczynski](https://github.com/charleskawczynski)
and in parallel with his
[PlayingCards.jl](https://github.com/charleskawczynski/PlayingCards.jl).


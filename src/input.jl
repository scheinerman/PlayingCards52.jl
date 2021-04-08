# handy ways to specify cards
export ♣, ♢, ♡, ♠
import Base: (*)

const ♣ = Suit(:clubs)
const ♢ = Suit(:diamonds)
const ♡ = Suit(:hearts)
const ♠ = Suit(:spades)

(*)(r::Int, s::Suit) = Card(s, r)

export A♣, T♣, J♣, Q♣, K♣

const A♣ = Card(♣, 1)
const T♣ = Card(♣, 10)
const J♣ = Card(♣, 11)
const Q♣ = Card(♣, 12)
const K♣ = Card(♣, 13)

export A♢, T♢, J♢, Q♢, K♢

const A♢ = Card(♢, 1)
const T♢ = Card(♢, 10)
const J♢ = Card(♢, 11)
const Q♢ = Card(♢, 12)
const K♢ = Card(♢, 13)

export A♡, T♡, J♡, Q♡, K♡

const A♡ = Card(♡, 1)
const T♡ = Card(♡, 10)
const J♡ = Card(♡, 11)
const Q♡ = Card(♡, 12)
const K♡ = Card(♡, 13)

export A♠, T♠, J♠, Q♠, K♠

const A♠ = Card(♠, 1)
const T♠ = Card(♠, 10)
const J♠ = Card(♠, 11)
const Q♠ = Card(♠, 12)
const K♠ = Card(♠, 13)

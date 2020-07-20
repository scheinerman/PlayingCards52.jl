module PlayingCards


suit_list = [ :clubs, :diamonds, :hearts, :spades ]
suit_set = Set(suit_list)

suit_char = Dict{Symbol,Char}(:clubs => '♣', :diamonds => '♢',
    :hearts => '♡', :spades => '♠')


export Suit

struct Suit
    s::Symbol
    function Suit(s::Symbol)
        if !in(s,suit_list)
            error("No such suit $s.\nUse one of these: $suit_list.")
        end
        new(s)
    end
end

struct Card
    suit::Suit
    rnk::Int
    function Card(s::Symbol, r::Int)
        if r<1 || r>13
            error("Card rank must be between 1 (ace) and 13 (king)")
        end
        new(Suit(s),r)
    end
end

export Card




end # module

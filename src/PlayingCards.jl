module PlayingCards

greet() = print("Hello World!")

suit_list = [ :clubs, :diamonds, :hearts, :spades ]
suit_set = Set(suit_list)

export Suit

struct Suit
    suit::Symbol
    function Suit(s::Symbol)
        if !in(s,suit_list)
            error("No such suit $s.\nUse one of these: $suit_list.")
        end
        new(s)
    end
end

end # module

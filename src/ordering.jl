export ace_high

_ace_high = true

function ace_high(bit::Bool)::Bool
    global _ace_high
    _ace_high = bit
end

"""
    ace_high(bit::Bool)::Bool

Determine if aces are highest value cards in a deck. After `ace_high(true)` aces are greater than kings.
After `ace_high(false)`, aces are lower than twos. This affects the result of `<` comparisons and sorting.

    ace_high()::Bool

Return the current status of aces (`true` means aces are high, `false` means aces are low).
"""
function ace_high()::Bool
    global _ace_high
    return _ace_high
end

import Base: (<), isless

function (<)(C::Card, D::Card)::Bool

    rC = rank(C)
    rD = rank(D)

    if ace_high()
        if rC == 1
            rC += 13
        end
        if rD == 1
            rD += 13
        end
    end

    if rC < rD
        return true
    end

    if rC > rD
        return false
    end

    # compare by suits

    sC = suit(C).s
    sD = suit(D).s

    return sC < sD
end

isless(C::Card, D::Card)::Bool = C < D

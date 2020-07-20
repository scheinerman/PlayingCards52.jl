export ace_high

_ace_high = true

function ace_high(bit::Bool)::Bool
    global _ace_high
    _ace_high = bit
end

function ace_high()::Bool
    global _ace_high
    return _ace_high
end

import Base: (<), isless

function (<)(C::Card, D::Card)::Bool
    global suit_number

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

    sC = suit_number[suit(C)]
    sD = suit_number[suit(D)]

    return sC < sD
end

isless(C::Card,D::Card)::Bool= C<D

#using PlayingCards52

_club_base = 0x1F0D1
_diamond_base = 0x1F0C1
_heart_base = 0x1F0B1
_spade_base = 0x1F0A1

# _bases = [_club_base, _diamond_base, _heart_base, _spade_base]

function _make_chars(base::Integer)
    vals = collect(base:base+10)
    append!(vals, base + 12)
    append!(vals, base + 13)
    return Char.(vals)

end

_cards = _make_chars(_club_base)
append!(_cards, _make_chars(_diamond_base))
append!(_cards, _make_chars(_heart_base))
append!(_cards, _make_chars(_spade_base))

import Base.Char

"""
`Char(c::Card)` returns the unicode character for that playing card.
"""
function Char(c::Card)
    return _cards[index(c)]
end

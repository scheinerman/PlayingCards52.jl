const _club_base = 0x1F0D1
const _diamond_base = 0x1F0C1
const _heart_base = 0x1F0B1
const _spade_base = 0x1F0A1

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
    Char(c::Card)

Return the unicode character for that playing card.

```
julia> Char(4♣)
'🃔': Unicode U+1F0D4 (category So: Symbol, other)
```
"""
function Char(c::Card)
    return @inbounds _cards[index(c)]
end

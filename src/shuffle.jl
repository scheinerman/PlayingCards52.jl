export riffle, riffle!, cut, cut!

"""
`riffle!(list)` does an in-place riffle shuffle permutation on
`list` using the Gilbert–Shannon–Reeds model.
"""
function riffle!(list::Vector)
    n = length(list)
    if n < 2
        return
    end
    t = _simple_binomial(n)
    A = list[1:t]
    B = list[t+1:end]

    na = length(A)
    nb = length(B)

    # pointers into A and B lists
    a = 1
    b = 1

    for j = 1:n
        top = na - a + 1
        bot = (na - a + 1) + (nb - b + 1)
        p = top / bot   # prob we choose from A

        if rand() <= p
            list[j] = A[a]
            a += 1
        else
            list[j] = B[b]
            b += 1
        end
    end
    list
end

"""
`riffle(list)` performs a riffle shuffle permutation on a copy of `list` using the 
Gilbert–Shannon–Reeds model. The original `list` is unchanged.
"""
function riffle(list::Vector)
    tmp = deepcopy(list)
    riffle!(tmp)
end


"""
    _simple_binomial(n::Int)

Return a random B(n,0.5) random value.
"""
function _simple_binomial(n::Int)
    return sum(rand() > 0.5 for _=1:n)
end

"""
`cut!(list,idx)` cuts the deck `list` by moving cards `1` through `idx`
(inclusive) to the back of the deck so the first card now was formerly
the one at position `idx+1`.

`cut!(list)` cuts the deck at a random location. If the deck has `n`
cards, then the cut location is given by the binomial random
variable `B(n,1/2)`.
"""
function cut!(list::Vector, idx::Int)
    n = length(list)
    @assert 0 <= idx <= n "Cut index must be between 0 and $n [got $idx]"

    if idx == 0 || idx == n
        return
    end

    A = list[1:idx]
    B = list[idx+1:end]

    na = length(A)
    nb = length(B)

    for j = 1:nb
        list[j] = B[j]
    end

    for j = 1:na
        list[nb+j] = A[j]
    end
    return list
end


function cut!(list::Vector)
    idx = _simple_binomial(length(list))
    cut!(list, idx)
end

"""
`cut(list,idx)` and `cut(list)` uses `cut!` to cut a copy of the deck `list`
leaving the original `list` unchanged.
"""
function cut(list::Vector, idx::Int)
    tmp = deepcopy(list)
    cut!(tmp, idx)
end
function cut(list::Vector)
    tmp = deepcopy(list)
    cut!(tmp)
end




import Random: shuffle!, shuffle
export shuffle!, shuffle

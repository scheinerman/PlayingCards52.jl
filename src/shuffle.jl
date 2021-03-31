export riffle!, cut!

"""
`riffle!(list)` does an in-place riffle shuffle permutation on
`list` using the Gilbert–Shannon–Reeds model.
"""
function riffle!(list::Vector)
    n = length(list)
    if n < 2
        return
    end
    t = binom_rv(n, 0.5)
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
    nothing
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
    return
end

function cut!(list::Vector)
    idx = binom_rv(length(list), 0.5)
    cut!(list, idx)
end

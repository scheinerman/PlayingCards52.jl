export riffle!

"""
`riffle!(list)` does an in-place riffle shuffle permutation on
`list` using the Gilbert–Shannon–Reeds model.
"""
function riffle!(list::Vector{T}) where T
    n = length(list)
    if n < 2
        return
    end
    t = binom_rv(n,0.5)
    A = list[1:t]
    B = list[t+1:end]

    na = length(A)
    nb = length(B)

    # pointers into A and B lists
    a = 1
    b = 1

    for j=1:n
        top = na - a + 1
        bot = (na-a+1) + (nb-b+1)
        p = top/bot   # prob we choose from A

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

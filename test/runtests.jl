using Test
using PlayingCards

@test true

for k=1:52
    C = Card(k)
    kk = index(C)
    @test k==kk
end

x = deck()
sort!(x)
@test index(x[1]) == 1

AC = Card(:clubs,1)
twoD = Card(:diamonds,2)

ace_high(true)
@test twoD < AC
ace_high(false)
@test twoD > AC

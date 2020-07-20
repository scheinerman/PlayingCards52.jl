using Test
using PlayingCards

@test true

for k=1:52
    C = Card(k)
    kk = index(C)
    @test k==kk
end

using Exfiltrator
using Test

@testset "Exfiltrator.jl" begin
    function f(x)
        @exfiltrate
        @exfiltrate A x
        @exfiltrate B
        @exfiltrate_push! C x 
        @exfiltrate_push! D
    end
    f(2)
    f(3)
    @test x == 3
    @test A == 3
    @test B.x == 3
    @test C == [2, 3]
    @test D[1].x == 2
    @test D[2].x == 3
    f(:a)
    @test x == :a
end

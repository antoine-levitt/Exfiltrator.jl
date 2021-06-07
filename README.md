# THIS PACKAGE IS NOT MAINTAINED

Similar functionality has been implemented in [Infiltrator.jl](https://github.com/JuliaDebug/Infiltrator.jl). Please use that package instead of Exfiltrator.jl.

# Exfiltrator

[![Build Status](https://travis-ci.com/antoine-levitt/Exfiltrator.jl.svg?branch=master)](https://travis-ci.com/antoine-levitt/Exfiltrator.jl)

Exfiltrator is the reverse of [Infiltrator.jl](https://github.com/JuliaDebug/Infiltrator.jl). It allows you to "exfiltrate" local variables from a function into the global scope.

```julia
using Exfiltrator

julia> function f(x)
           @exfiltrate
       end
f (generic function with 1 method)

julia> f(2)

julia> x
2
```
Also supported are `@exfiltrate VAR`, which exfiltrates the local variables to the global variable `VAR` as a named tuple, `@exfiltrate VAR x`, which exfiltrates only `x`, and the `@exfiltrate_push! ARR` and `@exfiltrate_push! ARR x` which push the exfiltrated variables to a global array.

You can avoid typing `using Exfiltrator` by `using` it at the REPL and then using `Main.@exfiltrate` in your code.

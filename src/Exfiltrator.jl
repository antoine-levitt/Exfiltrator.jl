module Exfiltrator

export @exfiltrate, @exfiltrate_push!

function exfiltrate(bindings)
    for (var, val) in bindings
        setfield!!(Main, var, val)
    end
end

setfield!!(m::Module, var::Symbol, val::Any) = m.eval(:($var = $(Expr(:quote, val))))
macro exfiltrate()
    quote
        exfiltrate(Base.@locals)
    end
end
macro exfiltrate(s::Symbol)
    esc(quote
        global $s
        $s = (; (Base.@locals())...)
    end)
end
macro exfiltrate(s::Symbol, x)
    esc(quote
        global $s
        $s = $x
    end)
end

macro exfiltrate_push!(s::Symbol)
    !isdefined(Main, s) && setfield!!(Main, s, [])
    esc(quote
        global $s
        push!($s, (; (Base.@locals())...))
    end)
end
macro exfiltrate_push!(s::Symbol, x)
    !isdefined(Main, s) && setfield!!(Main, s, [])
    esc(quote
        global $s
        push!($s, $x)
    end)
end

end

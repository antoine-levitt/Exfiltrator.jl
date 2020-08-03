module Exfiltrator

export @exfiltrate, @exfiltrate_push!

setfield!!(m::Module, var::Symbol, val::Any) = m.eval(:($var = $val))
macro exfiltrate()
    quote
        for (var, val) in Base.@locals
            setfield!!(Main, var, val)
        end
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

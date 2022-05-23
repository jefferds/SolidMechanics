# This file was generated, do not modify it. # hide
# Funções Momento e Esforço

function M(x)
    if x <= a
        return MI(x);
    elseif x <= a+b
        return MII(x);
    elseif x <= a+b+c
        return MIII(x);
    else
        return MIV(x);
    end
end;
    
function V(x)
    if x <= a
        return VI(x);
    elseif x <= a+b
        return VII(x);
    elseif x <= a+b+c
        return VIII(x);
    else
        return VIV(x);
    end
end;
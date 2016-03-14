function d = dht(f)
    [M N] = size(f);
    d = zeros(size(f));
    for i = 1:M
        for j = 1:N
            d(i,j) = H(f,i,j,M,N);
        end
    end
end

function c = cas (x)
    c = cos(x) + sin(x);
end

function h = H(f, v1, v2, M, N)
    entire_sum = 0;
    for t1 = 1:M
        inner_sum = 0.0;
        for t2 = 1:N
            inner_sum = f(t1, t2) * cas(2*pi*v1*t1/M) * cas(2*pi*v2*t2/N) + inner_sum;
        end
        entire_sum = entire_sum + inner_sum;
    end
    h = entire_sum/(M*N);
end




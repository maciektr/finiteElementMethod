% Projekt MES % 
% Dane: % 
global N;
N = 25;
RANGE = 2;

% Skrypt %
h=0.000001;
diff = @(f,x) (f(x+h)-f(x-h))/(2*h);

global s;
s = RANGE / N;
y = @(x,k)  (( s*(k-2) < x & x < s*(k-1)) .* ( x/s-k+2 ) + ( s*(k-1) <= x & x < s*k ) .* ( -x/s+k ));
e = @(k) (@(x) y(x,k));

b = @(u,v) (diff(u,1)*v(1)-u(0)*v(0)+int(@(x)(diff(u,x) * diff(v,x)),0,1) +2*int(@(x)(diff(u,x) * diff(v,x)),1,2));
B = sparse(N,N);
for k = 1:N
    B(k,k) = b(e(k),e(k));
    if k+1<=N
        B(k,k+1) = b(e(k),e(k+1));
        B(k+1,k) = b(e(k+1),e(k));
    end
end
B

l = @(v) (-20*v(0));
L = l(e((1:N)));
L

W = L/B;
W
r = @(x) y(x,(1:N)) .* W((1:N));
res = @(x) sum(r(x)); 
fplot(res,[0 2]);

function i = int(f,a,b)
        global s;
        global N;
        qua = @(k) (1/N)*(f((1/(N*sqrt(3)))+((2*k+1)/N))+f(((-1)/(N*sqrt(3)))+((2*k+1)/N)));
        am = a/s;
        bm = b/s;
        res = 0;
        for k = am:bm
            res = res+ qua(k);
        end
        i = res;
end

% Projekt MES % 
% Dane: % 
N = 4;
RANGE = 2;
% Skrypt %
h=0.000001;
diff = @(f,x) (f(x+h)-f(x-h))/2/h;

s = RANGE / N;
y = @(x,k)  (( s*(k-2) < x & x < s*(k-1)) .* ( x/s-k+2 ) + ( s*(k-1) <= x & x < s*k ) .* ( -x/s+k ));
e1 = @(x) y(x,1);
e2 = @(x) y(x,2);
e3 = @(x) y(x,3);
e4 = @(x) y(x,4);
% fplot(e1);
e = @(k) (@(x) y(x,k));

int = @(f,k) (1/2)*(f(1/(2*sqrt(3))+(k)/2)+f(-1/(2*sqrt(3))+(k)/2));

b = @(u,v) (diff(u,1)*v(1)-u(0)*v(0)+int(@(x)diff(u,x)*diff(v,x),1) +2*int(@(x)diff(u,x)*diff(v,x),3));
% b(e1,e1);

B = sparse(N,N);
for k = 1:N
    for m = 1:N
        if max(k,m) - min(k,m) <= 1
            B(k,m) = b(e(k),e(m));
        end
    end
end
% B

l = @(v) (20-v(0));
L = l(e((1:N)));
% L

W = L/B;

r = @(x) y(x,(1:N)) .* W((1:N));
res = @(x) sum(r(x));
fplot(res);


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


% int = @(f,n,k) (1/n)*(f(1/(n*sqrt(3))+(2*k-1)/n)+f(-1/(n*sqrt(3))+(2*k-1)/n));
int = @(f,k) (1/2)*(f(1/(2*sqrt(3))+(k)/2)+f(-1/(2*sqrt(3))+(k)/2));

% b = @(u,v,n,k) (diff(u,1)*v(1)-u(0)*v(0)+int(@(x)diff(u,x)*diff(v,x),n,k) +2*int(@(x)diff(u,x)*diff(v,x),n,k+1));
b = @(u,v) (diff(u,1)*v(1)-u(0)*v(0)+int(@(x)diff(u,x)*diff(v,x),1) +2*int(@(x)diff(u,x)*diff(v,x),3));
% b(e1,e1);

%b = @(u,v,upvp,up, int,n,k) (up(1)*v(1)-up(0)*v(0)+((2*k/n <= 1) .* int(upvp,n,k))+2*(((2*k-2)/n >= 1) .* int(upvp,n,k+1)))
%bn = @(n,k1,k2) b(@(x) y(x,n,k1), @(x) y(x,n,k2), (@(x) yp(x,n,k1) * yp(x,n,k2)), @(x) yp(x,n,k1),int, n,min(k1,k2))
% b(e1,e2,(@(x)ep1(x)*ep2(x)),ep1,int,4,1)
% bn(4,4,3)
% bn(4,1,2)
% bn(4,2,2)
% bn(4,2,1)

% dp = @(fun,x) ((fun(x + 0.000001) - fun(x - 0.000001)) / (2 * 0.000001))

% dp(e2,1)
% bn = @(n,k1,k2) b(@(x) y(x,n,k1), @(x) y(x,n,k2), (@(x) dp(@(x) y(x,n,k1),x) * dp(@(x) y(x,n,k2),x)),@(x) dp(@(x) y(x,n,k1),x) ,int, n,min(k1,k2))
% bn(4,2,2)

B = sparse(N,N);
for k = 1:N
    for m = 1:N
        if max(k,m) - min(k,m) <= 1
            B(k,m) = b(e(k),e(m));
        end
    end
end
B
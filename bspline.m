syms y(x);
y = @(x,n,k) ((2/n)*(k-2)<x & x<(2/n)*(k-1)) .* ((n/2)*x-k+2) + ((2/n)*(k-1)<x & x<(2/n)*k) .* (-(n/2)*x+k);
m = @(x) y(x,4,2);
%fplot(m)
yp = @(x,n,k) ((2/n)*(k-2)<x & x<(2/n)*(k-1) & x>0) .* ((n/2)) + ((2/n)*(k-1)<x & x<(2/n)*k & x < 2) .* (-(n/2));
% mp = @(x) yp(x,4,2);
% fplot(mp)
p = @(x) yp(x,4,2)*yp(x,4,3)
% fplot(p)
int = @(f,n,k) (1/n)*(f(1/(n*sqrt(3))+(2*k-1)/n)+f(-1/(n*sqrt(3))+(2*k-1)/n))
% int(p,4,2)

b = @(u,v,upvp,up, int,n,k) (up(1)*v(1)-up(0)*v(0)+((2*k/n <= 1) .* int(upvp,n,k))+2*(((2*k-2)/n >= 1) .* int(upvp,n,k+1)))
e1 = @(x) y(x,4,1)
ep1 = @(x) yp(x,4,1)
e2 = @(x) y(x,4,2)
ep2 = @(x) yp(x,4,2)
e3 = @(x) y(x,4,3)
ep3 = @(x) yp(x,4,3)
e4 = @(x) y(x,4,4)
ep4 = @(x) yp(x,4,4)

%bn = @(n,k1,k2) b(@(x) y(x,n,k1), @(x) y(x,n,k2), (@(x) yp(x,n,k1) * yp(x,n,k2)), @(x) yp(x,n,k1),int, n,min(k1,k2))

% b(e1,e2,(@(x)ep1(x)*ep2(x)),ep1,int,4,1)
% bn(4,4,3)
% bn(4,1,2)
% %bn(4,2,2)
% bn(4,2,1)

dp = @(fun,x) ((fun(x + 0.000001) - fun(x - 0.000001)) / (2 * 0.000001))

% dp(e2,1)
bn = @(n,k1,k2) b(@(x) y(x,n,k1), @(x) y(x,n,k2), (@(x) dp(@(x) y(x,n,k1),x) * dp(@(x) y(x,n,k2),x)),@(x) dp(@(x) y(x,n,k1),x) ,int, n,min(k1,k2))
bn(4,2,2)

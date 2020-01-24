#####
# Mateusz Surjak
#####

from pylab import *
from scipy.integrate import quad
from functools import partial

N = 5
H = []
L = []
B = []
START = 0
END = 2

step = (END - START) / (N - 1)


def function_derivative(fun):
    precision = 0.000001
    return lambda x: (fun(x + precision) - fun(x - precision)) / (2 * precision)


for i in range(0, N - 1, 1):
    H.append(partial(lambda i, x: (
        ((1 / (step * i - step * (i - 1))) * x - step * (i - 1) / (step * i - step * (i - 1))) if (
                step * i > x > step * (i - 1)) else (
            ((step * (i + 1) / (step * (i + 1) - step * i)) - x * (1 / (step * (i + 1) - step * i))) if (
                    step * i <= x < step * (i + 1)) else 0.0)), i))

for i in H:
    L.append(-20 * i(0))

for v in H:
    row = []
    for u in H:
        row.append(
            (v(1) * (function_derivative(u))(1)) - v(0) * (function_derivative(u))(0) +
            quad(lambda x: (function_derivative(v)(x) * function_derivative(u)(x)), 0, 1)[0] +
            quad((lambda x: 2 * function_derivative(v)(x) * function_derivative(u)(x)), 1, 2)[0]
        )
    B.append(row)
print((function_derivative(H[1]))(3/4))
print((function_derivative(H[0]))(0))

#print((function_derivative(H[1]))(0.5))
#print(H[0](1))
print(B)

#u = np.linalg.solve(B, L)

#linearCombination = []
#for i in range(0, N, 1):
    #linearCombination.append(
        #lambda x: H[i](x) * u[i])

#X = []
#Y = []
#for j in np.arange(START, END + 0.001, 0.001):
    #X.append(round(j, 4))
    #value = 0
    #for i in range(0, N - 1, 1):
        #value += linearCombination[i](j)
    #Y.append(round(value, 4))
#plt.plot(X, Y)

#plt.xlabel('x')

#plt.ylabel('y')

#plt.title('Function')

#plt.show()

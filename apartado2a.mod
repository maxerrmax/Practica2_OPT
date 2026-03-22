# Conjuntos
set I;                # Todas las intersecciones
set C;                # Todos los caminos
set P within I;       # Intersecciones prohibidas
set F within I;       # Intersecciones fijas
set Ic {C} within I;  # Intersecciones que forman cada camino c

# Parametros
param fc {C};         # Flujo de cada camino

# Variables
var yi {I} binary;    # 1 si la interseccion i tiene sensor
var xc {C} binary;    # 1 si el camino c esta sensorizado

# Funcion objetivo
maximize Flujo_Total: 
    sum {c in C} fc[c] * xc[c];

# Restricciones
subject to Limite_Sensores:
    sum {i in I} yi[i] <= 15;

subject to Prohibidas {i in P}:
    yi[i] = 0;

subject to Fijas {i in F}:
    yi[i] = 1;

subject to Activacion_Camino {c in C}:
    2 * xc[c] <= sum {i in Ic[c]} yi[i];
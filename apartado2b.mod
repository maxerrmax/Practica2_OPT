# Conjunts
set I;                # Totes les interseccions
set C;                # Tots els camins
set P within I;       # Interseccions prohibides
set F within I;       # Interseccions fixes
set Ic {C} within I;  # Interseccions que formen cada camí c
set Cerca within {I, I};

# Paràmetres
param fc {C};         # Flux de cada camí

# Variables
var yi {I} binary;    # 1 si la intersecció i té sensor
var xc {C} binary;    # 1 si el camí c està sensoritzat

# Funció Objectiu
maximize Flux_Total: 
    sum {c in C} fc[c] * xc[c];

# Restriccions
subject to Limit_Sensors:
    sum {i in I} yi[i] <= 15;

subject to Prohibides {i in P}:
    yi[i] = 0;

subject to Fixes {i in F}:
    yi[i] = 1;

subject to Activacio_Cami {c in C}:
    2 * xc[c] <= sum {i in Ic[c]} yi[i];

subject to Distancia_Minima {(i, j) in Cerca}:
    yi[i] + yi[j] <= 1;
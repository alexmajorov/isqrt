import shutil

opts = ("O2", "O0")
funcs = ("rsqrt", "fast_rsqrt")
size=2000000000
step=1000000

import numpy as np

def outlier_indices(data):
    mean = np.mean(data)
    std_dev = np.std(data)
    z_scores = [(x - mean) / std_dev for x in data]
    indices = [i for i, z in enumerate(z_scores) if abs(z) > 1]
    return indices

for f in funcs: 
    for opt in opts:
        with open("./predata" + "/data_" + f + "/" + opt + "_" + str(size) + ".txt") as file_in:
            data = [float(line.strip()) for line in file_in.readlines()]
            indices = outlier_indices(data)
            print(opt, "and", f, "outlier_indices :", indices)
        with open("./postdata" + "/data_" + f + "/" + opt + ".txt", "a") as file_out:
            for i in range(len(data)):
                if i not in indices:
                    file_out.write(str(i * step) + " " + str(data[i]) + "\n")

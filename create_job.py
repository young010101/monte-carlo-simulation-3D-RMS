import os

root_path = os.path.dirname(os.path.abspath(__file__))
hpc_code_path = os.path.join(root_path, 'hpc_code')
cuda_path = os.path.join(hpc_code_path, 'lib/main.cu')

# Set the target path to the second item in the list
target_paths = [
    os.path.join(root_path, 'hpc_code', 'input', 'I_realistic_axon_mitochondria'),
    os.path.join(root_path, 'hpc_code', 'input', 'II_realistic_axon'),
    os.path.join(root_path, 'hpc_code', 'input', 'III_caliber_variation'),
    os.path.join(root_path, 'hpc_code', 'input', 'IV_undulation')
]

for target_path in target_paths:
    with open(os.path.join(hpc_code_path, 'input', 'per_axon_hop.sh'), 'w') as f:
        # Change directory to the target path and set up the GPU code
        f.write(f'cd {target_path}/setup001\n')
        f.write(f'cp -a {cuda_path} .\n')
        f.write('nvcc -arch=sm_70 main.cu -o main_cuda -std=c++14\n')
        # Run the GPU code and remove the compiled file
        f.write('./main_cuda\n')
        f.write('rm -f main.cu main_cuda\n')
        f.write('pwd\n')

hop_sh_path = os.path.join(hpc_code_path, 'input', 'per_axon_hop.sh')
os.system(f'sh {hop_sh_path}')

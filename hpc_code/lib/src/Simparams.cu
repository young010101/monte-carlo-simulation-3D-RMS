#include "Simparams.h"
#include <fstream>

SimulationParameters LoadSimulationParameters(const std::string &filename)
{
    SimulationParameters params{};
    std::ifstream file(filename);
    file >> params.dt >> params.TN >> params.NPar >> params.Nbvec >>
        params.Nc >> params.res >> params.NPix1 >> params.NPix2 >> params.NPix3;
    return params;
}

thrust::host_vector<double> LoadVectorFromFile(const std::string &filename)
{
    // cy, I wish add the num of vector
    thrust::host_vector<double> vector;
    std::ifstream file(filename);
    double value;
    while (file >> value)
    {
        vector.push_back(value);
    }
    return vector;
}

Compute_params load_compute_params(const thrust::host_vector<double>& T2_real, const SimulationParameters &sim_params, const thrust::host_vector<double> &D)
{

    auto T2{T2_real};
    for (auto &a : T2)
    {
        // cy, change the real T2 to unreal but unit(?can fit to unit box) T2
        a /= sim_params.dt;
        // std::cout << a << std::endl;
    }

    thrust::host_vector<double> step(sim_params.Nc);
    for (int i = 0; i < sim_params.Nc; ++i)
    // for(auto &a: step)
    {
        // cy, no the real step size, the unit (or normalization) step size in voxel box
        // cy, dt, D, and res is realistic.
        step[i] = sqrt(6.0 * sim_params.dt * D[i]) / sim_params.res;
        std::cout << "step size=" << step[i] << std::endl;
    }

    thrust::host_vector<double> Pij(sim_params.Nc * sim_params.Nc);
    int k = 0;
    for (int i = 0; i < sim_params.Nc; ++i)
    {
        for (int j = 0; j < sim_params.Nc; ++j)
        {
            if ((i == 0) || (j == 0))
            {
                Pij[k] = 0.0;
            }
            else if (i == j)
            {
                Pij[k] = 1.0;
            }
            else
            {
                Pij[k] = std::min(1.0, sqrt(D[j] / D[i]));
            }
            std::cout << k << " permeation probability=" << Pij[k] << std::endl;
            ++k;
        }
    }

    Compute_params compute_params(T2, step, Pij);
    return compute_params;
}
// int load_pgse_params(){

// }

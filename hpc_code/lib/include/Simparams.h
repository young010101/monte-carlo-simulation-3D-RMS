#pragma once
#include <string>
#include <thrust/host_vector.h>
#include <math.h>

struct SimulationParameters
{
    double dt;               // Time step in ms
    int TN;                  // # time steps
    int NPar;                // # particles
    int Nbvec;               // # gradient directions
    int Nc;                  // # compartments
    double res;              // voxel size
    int NPix1, NPix2, NPix3; // medium matrix dimension
};

struct Compute_params
{
    thrust::host_vector<double> T2;
    thrust::host_vector<double> step;
    thrust::host_vector<double> Pij;
    Compute_params(thrust::host_vector<double> t2, thrust::host_vector<double> step_unreal, thrust::host_vector<double> pij)
        : T2(t2), step(step_unreal), Pij(pij){};
};

SimulationParameters LoadSimulationParameters(const std::string &filename);
thrust::host_vector<double> LoadVectorFromFile(const std::string &filename);
Compute_params load_compute_params(const thrust::host_vector<double> &T2_real, const SimulationParameters &sim_params, const thrust::host_vector<double> &D);
// void compute_params();
// thrust::host_vector load_T2();
// int load_pgse_params();

#pragma once
#include <string>
#include <thrust/host_vector.h>

struct SimulationParameters
{
    double dt;         // Time step in ms
    int TN;            // # time steps
    int NPar;          // # particles
    int Nbvec;         // # gradient directions
    int Nc;            // # compartments
    double res;        // voxel size
    int NPix1, NPix2, NPix3; // medium matrix dimension
};

SimulationParameters LoadSimulationParameters(const std::string& filename);
thrust::host_vector<double> LoadVectorFromFile(const std::string &filename);
// void compute_params();
// thrust::host_vector load_T2();
// int load_pgse_params();

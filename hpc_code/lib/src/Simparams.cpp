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


// int load_pgse_params(){


// }

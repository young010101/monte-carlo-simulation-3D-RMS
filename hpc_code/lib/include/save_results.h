#pragma once
#include <thrust/host_vector.h>
#include "Simparams.h"

void save_results(const int timepoints,
                  const thrust::host_vector<double> &sig0,
                  const thrust::host_vector<double> &dx2,
                  const thrust::host_vector<double> &dx4,
                  const thrust::host_vector<double> &sig,
                  const thrust::host_vector<double> &NPar_count,
                  const int &Ngrad,
                  const SimulationParameters &sim_params);

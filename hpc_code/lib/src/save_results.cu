#include "save_results.h"
#include <thrust/host_vector.h>
#include <fstream>

void save_results(const int timepoints,
                  const thrust::host_vector<double> &sig0,
                  const thrust::host_vector<double> &dx2,
                  const thrust::host_vector<double> &dx4,
                  const thrust::host_vector<double> &sig,
                  const thrust::host_vector<double> &NPar_count,
                  const int &Ngrad,
                  const SimulationParameters &sim_params)
{
    // Save results
    std::ofstream fs0out("sig0.txt");
    std::ofstream fdx2out("dx2.txt");
    std::ofstream fdx4out("dx4.txt");
    std::ofstream fsigout("sig.txt");
    //        std::ofstream fsRout("sigRe.txt");
    //        std::ofstream fsIout("sigIm.txt");
    std::ofstream fNpout("NPar_count.txt");
    fs0out.precision(15);
    fdx2out.precision(15);
    fdx4out.precision(15);
    fsigout.precision(15);
    //        fsRout.precision(15);
    //        fsIout.precision(15);

    for (int i = 0; i < timepoints; i++)
    {
        fs0out << sig0[i] << std::endl;
        for (int j = 0; j < 6; j++)
        {
            if (j == 5)
            {
                fdx2out << dx2[i * 6 + j] << std::endl;
            }
            else
            {
                fdx2out << dx2[i * 6 + j] << "\t";
            }
        }
        for (int j = 0; j < 15; j++)
        {
            if (j == 14)
            {
                fdx4out << dx4[i * 15 + j] << std::endl;
            }
            else
            {
                fdx4out << dx4[i * 15 + j] << "\t";
            }
        }

        //            for (j=0; j<Nbvec; j++) {
        //                if (j==Nbvec-1) {
        //                    fsRout<<sigRe[i*Nbvec+j]<<endl;
        ////                    fsIout<<sigIm[i*Nbvec+j]<<endl;
        //                }
        //                else {
        //                    fsRout<<sigRe[i*Nbvec+j]<<"\t";
        ////                    fsIout<<sigIm[i*Nbvec+j]<<"\t";
        //                }
        //            }

        for (int j = 0; j < sim_params.Nc; j++)
        {
            if (j == sim_params.Nc - 1)
            {
                fNpout << NPar_count[i * sim_params.Nc + j] << std::endl;
            }
            else
            {
                fNpout << NPar_count[i * sim_params.Nc + j] << "\t";
            }
        }
    }

    for (int i = 0; i < Ngrad; i++)
    {
        fsigout << sig[i] << std::endl;
    }

    fdx2out.close();
    fdx4out.close();
    fsigout.close();
    //        fsRout.close();
    //        fsIout.close();
    fNpout.close();

    std::ofstream paraout("sim_para.txt");
    paraout << sim_params.dt << std::endl
            << sim_params.TN << std::endl
            << sim_params.NPar << std::endl;
    paraout << sim_params.res << std::endl;
    paraout.close();

    std::ofstream TDout("diff_time.txt");
    for (int i = 0; i < timepoints; i++)
    {
        TDout << (i * (sim_params.TN / timepoints) + 1) * sim_params.dt << std::endl;
    }
    TDout.close();

    //        std::ofstream NParout("NPar_count.txt");
    //        NParout<<NPar_count[0];
    //        NParout.close();
}

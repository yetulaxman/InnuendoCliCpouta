
# Launch and test workflows on InnuendoCLI platform for different species


## Launch workflows for Ecoli species

Things to remember before launching workflows:

- You have downloaded samples to dedicated directory (/mnt/innuendo2_testing/rawdata/your-user-name/incoming) before lauching workflows
- You have edited input template file for workflow launching script with correct username/pipeline name/samples etc (For now you can give any random *runid* but in production it will be created automatically) 


**Usage:**

Clone Innuendo pipeline scripts in this GitHub to any folder on Innuendo2 machine on cPouta  

```bash
# Let's run all these tests by all users in some dedicated folder structure
cd  /mnt/innuendo2_testing/demo_environment 

# Use your actual name to create a directory (this needs to be done only once) and use this folder for launching your jobs
mkdir your-user-name  && cd your-user-name 

# clone workflows launching scripts from GitHub if you don't have them already
git clone https://github.com/yetulaxman/InnuendoCliCpouta.git  && cp InnuendoCliCpouta/* .

# edit input file (input_samples_ecoli.txt) and launch pipeline
nohup bash launch_pipeline_selectedsample.sh input_samples_ecoli.txt > test_ecoli &

# view the progress of jobs

contrl + c # to get back to the terminal
vi/vim/nano test_ecoli  # use your favourite editor to see if job has started

# You can also check the real progress of batch jobs by going into directory where job is running
# you need to know runid  specific to your run.
# runid : you can find it in your input template file


cd /mnt/innuendo2_testing/jobs/your-user-name/runid 
vi/vim/nano nextflow_log.txt

# view reports file 
cd reports

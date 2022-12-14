
# Launch and test workflows on InnuendoCLI platform for different species


## Launch workflows for Ecoli species

Please make sure that you have done the following preparation before launching workflows:

- You have downloaded samples to a dedicated directory (/mnt/innuendo2_testing/rawdata/your-user-name/incoming) on Innuendo machine
- You have edited input template file for worklfows launching script with correct username/pipeline name/samples etc (For now you can give any random *runid* but in production it will be created automatically; possible pipeline name options at the moment are: cjejuni, ecoli, lmonocytogenes, senterica  and yenterocolitica ) 


**Usage:**

```bash

# Clone Innuendo pipeline scripts in this GitHub to a folder (e.g, /mnt/innuendo2_testing/demo_environment/your-user-name) on Innuendo2 machine. 

cd  /mnt/innuendo2_testing/demo_environment 

# create a directory with your user-name (this needs to be done only once)
mkdir your-user-name  && cd your-user-name 

# clone workflows launching scripts from GitHub if you don't have them already
git clone https://github.com/yetulaxman/InnuendoCliCpouta.git  && cp InnuendoCliCpouta/* .

# edit input file (input_samples_ecoli.txt) and then launch workflows
nohup bash launch_pipeline_selectedsample.sh input_samples_ecoli.txt > test_ecoli &

# view the progress of jobs

contrl + c  # to get back to the linux terminal
vi/vim/nano test_ecoli  # use your favourite editor to see if job has started

# You can also check the real progress of batch jobs by going into directory where job is running
# you need to know runid (you can find it in your input template file)  specific to your run.

cd /mnt/innuendo2_testing/jobs/your-user-name/runid 
vi/vim/nano nextflow_log.txt

# view reports file 
cd reports
```

## Things to test in this workflows
- are you able to run workflows successfully?  if workflows are failed for some reason, document all those cases or raise some issue in this GitHub repository
- are you able to generate reports? if reports are failed, please specify the error you have witnessed.

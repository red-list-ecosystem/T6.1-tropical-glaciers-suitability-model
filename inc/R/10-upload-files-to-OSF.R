#! R --no-save --no-restore

source(sprintf("%s/proyectos/Tropical-Glaciers/T6.1-tropical-glaciers-suitability-model/env/project-env.R", Sys.getenv("HOME")))
output.dir <- sprintf("%s/%s/",gis.out,projectname)

library(dplyr)
library(osfr)
library(stringr)

here::i_am("inc/R/10-upload-files-to-OSF.R")

## read value for conflicts argument
args = commandArgs(trailingOnly=TRUE)
if (args[1] %in% c("skip","overwrite")) {
  conflict_answer <- args[1]
} else {
  conflict_answer <- "skip"
}

osfcode <- Sys.getenv("OSF_PROJECT")
osf_project <- osf_retrieve_node(sprintf("https://osf.io/%s", osfcode))
my_project_components <- osf_ls_nodes(osf_project)

## navigate to each subcomponent...
idx <- my_project_components %>% filter(name %in% "Data for the global RLE assessment of Tropical Glacier Ecosystems") %>%
  pull(id) 
global_data_comp <- osf_retrieve_node(sprintf("https://osf.io/%s", idx))

idx <- my_project_components %>% filter(name %in% "Environmental suitability model for Tropical Glacier Ecosystems") %>%
  pull(id) 
env_suitability_comp <- osf_retrieve_node(sprintf("https://osf.io/%s", idx))
idx <- my_project_components %>% filter(grepl("Mérida",name)) %>%
  pull(id) 
cord_merida_comp <- osf_retrieve_node(sprintf("https://osf.io/%s", idx))
cord_merida_subcomponents <- osf_ls_nodes(cord_merida_comp)

## First upload to data component

file_to_upload <- sprintf("%s/GBMmodel/current-bioclim-data-all-groups.rda", output.dir)

data_file  <- osf_upload(global_data_comp, 
                         path = file_to_upload,
                         conflicts = conflict_answer
)


## Now upload the result table in env model component

file_names <- c("massbalance-model-data-all-groups.rds",
                "massbalance-totalmass-all-groups.rds",
                "massbalance-year-collapse-all-groups.rds",
                "relative-severity-degradation-suitability-all-tropical-glaciers.rds",
                "relative-severity-degradation-suitability-all-tropical-glaciers.csv",
                "relative-severity-degradation-suitability-all-tropical-glaciers-training-thresholds.rds",
                "totalmass-suitability-cED-data.rds",
                "totalmass-suitability-glmm-data.rds")

files_to_upload <- sprintf("%s/%s", output.dir,file_names)


data_file  <- osf_upload(env_suitability_comp, 
                         path = files_to_upload,
                         conflicts = conflict_answer
)

gbm.dir <- sprintf("%s/%s/GBMmodel",gis.out,projectname)
target_dir <- sprintf("%s/fitted-GBM-models",tempdir())
if (!dir.exists(target_dir))
  dir.create(target_dir)

all_rda_models <- list.files(gbm.dir, recursive = TRUE, pattern="gbm-model-current.rda") %>%
 str_split( "/", n=2, simplify=TRUE)

exclude  <- c("Norte-de-Argentina","Zona-Volcanica-Central")

for (j in all_rda_models[,1]) {
  if (!(j %in% exclude)) {
   system(sprintf("cp %1$s/%2$s/gbm-model-current.rda %3$s/%2$s.rda", gbm.dir, j, target_dir)) 
  }
}

dir(target_dir)

data_file  <- osf_upload(
  env_suitability_comp, 
  path = target_dir,
  conflicts = conflict_answer
  )



## Now upload data for Cordillera de Merida assessment
file.rename(sprintf("%s/Cordillera-de-Merida.rda",target_dir),
            sprintf("%s/gbm-model-Cordillera-de-Merida.rda",target_dir) )

data_file  <- osf_upload(
  cord_merida_subcomponents, 
  path = sprintf("%s/gbm-model-Cordillera-de-Merida.rda",target_dir) ,
  conflicts = conflict_answer
)

mbdata <- readRDS(sprintf("%s/massbalance-year-collapse-all-groups.rds", output.dir)) %>%
  filter(unit_name %in% "Cordillera de Merida")

saveRDS(mbdata, file=sprintf("%s/mb-year-collapse-Cordillera-de-Merida.rda",target_dir))

data_file  <- osf_upload(
  cord_merida_subcomponents, 
  path = sprintf("%s/mb-year-collapse-Cordillera-de-Merida.rda",target_dir) ,
  conflicts = conflict_answer
)


rsdata <- readRDS(sprintf("%s/relative-severity-degradation-suitability-all-tropical-glaciers.rds", output.dir)) %>%
  filter(unit %in% "Cordillera-de-Merida")

saveRDS(rsdata, file=sprintf("%s/gbm-RS-Cordillera-de-Merida.rda",target_dir))

data_file  <- osf_upload(
  cord_merida_subcomponents, 
  path = sprintf("%s/gbm-RS-Cordillera-de-Merida.rda",target_dir) ,
  conflicts = conflict_answer
)

## remove temp dir
# system(sprintf("rm -r %s",target_dir))
unlink(target_dir)

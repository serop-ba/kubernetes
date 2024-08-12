# assuming you login already once 
gcloud config configurations create $config_name
gcloud config set project $project_id
gcloud config set account $email_address

# to activate 
gcloud config configurations activate $config_name
gcloud auth application-default login
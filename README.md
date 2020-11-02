# AWS Nomad Cluster

terraform apply -auto-approve

ssh to any of the servers

Check the status of the nomad
nomad server members
nomad node status

git clone https://github.com/stoffee/nomad-buildly.git
cd nomad-buildly/nomad_jobs
nomad job run traefik.hcl
nomad job run buildly_db.hcl
nomad job run buildly.hcl
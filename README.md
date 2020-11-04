# AWS Nomad Cluster

`terraform apply -auto-approve`

ssh to any of the servers

Check the status of the nomad<br>
`nomad server members`<br>
`nomad node status`<br>

```git clone https://github.com/stoffee/nomad-buildly.git```<br>
`cd nomad-buildly/nomad_jobs`<br>
`nomad job run traefik.nomad`<br>
`nomad job run buildly_db.nomad`<br>
`nomad job run buildly.nomad`<br>
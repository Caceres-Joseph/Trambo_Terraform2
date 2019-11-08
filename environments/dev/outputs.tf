 
  #-------------
  # Kub config

output "kubeconfig" {
  value = "${module.eks.kubeconfig}"
}



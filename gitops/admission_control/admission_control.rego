package admission_control

monitor[reason] {
  data.library.v1.kubernetes.admission.workload.v1.check_image_pull_policy[reason]
}


monitor[reason] {
  parameters := {
    "allowed": set()
  }

  data.library.v1.kubernetes.admission.workload.v1.deny_host_path_not_in_whitelist[reason]
    with data.library.parameters as parameters
}

deny[reason] {
  parameters = {

  }

  data.library.v1.kubernetes.admission.workload.v1.block_latest_image_tag[reason]
     with data.library.parameters as parameters
}

deny[reason] {
  parameters = {

  }

  data.library.v1.kubernetes.admission.workload.v1.block_master_toleration[reason]
     with data.library.parameters as parameters
}

# ------------------------------------------------------------------------------
# Kubernetes Admission Controller Interface
# Do not modify.

main = {
  "apiVersion": "admission.k8s.io/v1beta1", 
  "kind": "AdmissionReview", 
  "response": response
}

default response = {
  "allowed": true
}

response = x {
  x := {
    "allowed": false, 
    "status": {
      "reason": reason
    }
  }

  reason = concat(  ", ", 
  data.admission_control.deny)

  reason != ""
} else = x {
  x := {
    "allowed": true, 
    "status": {
      "reason": reason
    }
  }

  reason = concat(  ", ", 
  data.admission_control.monitor)

  reason != ""
}


package admission_control

monitor[reason] {
  data.library.v1.kubernetes.admission.workload.v1.check_image_pull_policy[reason]

}

monitor[reason] {
  data.library.v1.kubernetes.admission.workload.v1.expect_container_resource_requirements[reason]
}


monitor[reason] {
  data.library.v1.kubernetes.admission.workload.v1.check_image_pull_policy[reason]
}


monitor[reason] {
  data.library.v1.kubernetes.admission.workload.v1.check_image_pull_policy[reason]
}


deny[reason] {
  data.library.v1.kubernetes.admission.workload.v1.block_latest_image_tag[reason]
}

deny[reason] {
  data.library.v1.kubernetes.admission.workload.v1.block_master_toleration[reason]
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

  reason = concat(", ", data.admission_control.deny)

  reason != ""
} else = x {
  x := {
    "allowed": true,
    "status": {
      "reason": reason
    }
  }

  reason = concat(", ", data.admission_control.monitor)

  reason != ""
}

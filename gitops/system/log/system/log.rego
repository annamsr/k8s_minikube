package system.log

# The policy below instructs OPA to remove all data from secrets before uploading the decision
# https://www.openpolicyagent.org/docs/latest/decision-logs/#masking-sensitive-data

mask["/input/request/object/data"] {
  input.input.request.kind.kind == "Secret"
}

mask["/input/request/oldObject/data"] {
  input.input.request.kind.kind == "Secret"
}

mask["/input/request/object/metadata/annotations"] {
  input.input.request.kind.kind == "Secret"
}

mask["/input/request/oldObject/metadata/annotations"] {
  input.input.request.kind.kind == "Secret"
}

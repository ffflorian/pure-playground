workflow "Build and test" {
  on = "push"
  resolves = ["Build project", "Test project"]
}

action "Check for CI skip" {
  uses = "./.github/actions/skip_ci_check"
}

action "Install dependencies" {
  uses = "docker://node:10-slim"
  needs = "Check for CI skip"
  runs = "npm"
  args = "i -g purescript pulp psc-package"
}

action "Build project" {
  uses = "docker://node:10-slim"
  needs = "Install dependencies"
  runs = "pulp"
  args = "build"
}

action "Test project" {
  uses = "docker://node:10-slim"
  needs = "Install dependencies"
  runs = "pulp"
  args = "test"
}

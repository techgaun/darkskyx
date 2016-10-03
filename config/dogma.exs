# dogma config to override some settings

use Mix.Config
alias Dogma.Rule

config :dogma,
  rule_set: Dogma.RuleSet.All,
  override: [
    %Rule.LineLength{enabled: false}
  ]

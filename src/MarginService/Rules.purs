module MarginService.Rules where

import Prelude
import MarginService.Types as T

evaluateRules :: T.RuleData -> Array Number
evaluateRules rd = map (evalRulesFare rd.context) rd.fares

evalRulesFare :: T.RoundFareContext -> T.Fare -> Number
evalRulesFare ctx f = f.price
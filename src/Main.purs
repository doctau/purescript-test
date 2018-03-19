module Main where

import Prelude
	
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Node.Express.Types (EXPRESS)
import MarginService.Server (runServer)

main :: forall eff. Eff ( console :: CONSOLE
                        , express :: EXPRESS
                        | eff) Unit

main = runServer port
  where port = 8080
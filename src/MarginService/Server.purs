module MarginService.Server (runServer) where

import Prelude
import Control.Monad.Aff (runAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Node.Express.App (App, get, listenHttp, post)
import Node.Express.Types (EXPRESS)
import MarginService.HandlerV2 (roundFaresV2)

app :: forall eff. App (eff)
app = do
  get "/v2/fare-rounding" roundFaresV2
  
runServer :: forall eff.
             Int
          -> Eff ( express :: EXPRESS
                 , console :: CONSOLE
                 | eff ) Unit
runServer port = void $ runAff logShow $ do
  void $ liftEff $ listenHttp app port (\_ -> log $ "Server listening on :" <> show port)
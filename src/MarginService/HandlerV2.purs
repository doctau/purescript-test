module MarginService.HandlerV2 where

import Prelude
import Control.Monad.Aff.Class (liftAff)
import Data.Foreign.Class (class Decode, class Encode, encode)
import Data.Foreign.Generic (defaultOptions, genericDecode, genericEncode)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Int (fromString)
import Data.Maybe (Maybe(..))
import Data.Validation.Semigroup (V)
import Node.Express.Handler (Handler)
import Node.Express.Request (getQueryParam)
import Node.Express.Response (end, sendJson, setStatus)

import MarginService.Types as T

newtype RoundFareRequest = RoundFareRequest
  { siteCode :: String
  , interfaceCode :: String
  , routeOrigin :: String
  , routeDestination :: String
  , bookingType :: String
  , clientCurrentDateTime :: String
  , fares :: Array Fare
  }
derive instance genericRoundFareRequest :: Generic RoundFareRequest _
instance showRoundFareRequest :: Show RoundFareRequest where
  show = genericShow
instance decodeRoundFareRequest :: Decode RoundFareRequest where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }
instance encodeRoundFareRequest :: Encode RoundFareRequest where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }

newtype Fare = Fare
  { fareIdentifier :: String
  , marketingCarrier :: String
  , price :: Number
  }
derive instance genericFare :: Generic Fare _
instance showFare :: Show Fare where
  show = genericShow
instance decodeFare :: Decode Fare where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }
instance encodeFare :: Encode Fare where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }


roundFaresV2 :: forall eff. Handler (eff)
roundFaresV2 = getQueryParam "siteCode" >>= case _ of
  Nothing -> respond 422 { error: "siteCode is required" }
  Just siteCode -> respond 400 { error: "worked" }
      
respond :: forall eff a. Int -> a -> Handler eff
respond status body = do
  setStatus status
  sendJson body
  
  
validateRequest :: RoundFareRequest -> V (Array Error) RuleData
validate person = { first: _, last: _, email: _ }
  <$> validateName person.first
  <*> validateName person.last
  <*> validateEmail person.email
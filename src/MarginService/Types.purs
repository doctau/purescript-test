module MarginService.Types where

import Prelude
import Data.Foreign.Class (class Decode, class Encode)
import Data.Foreign.Generic (defaultOptions, genericDecode, genericEncode)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.DateTime (DateTime)

newtype Airport = Airport String
data PosCountry = AUSTRALIA
                | CANADA
                | NEW_ZEALAND
data Brand = FCAU
           | FCCA
           | FCNZ
           | ETAU
           | SFAU

data FlightPath = DOMESTIC
                | DOMESTIC_AUSTRALIA
                | DOMESTIC_NEW_ZEALAND
                | TRANS_TASMAN
                | AUSTRALIA_SOUTH_WEST_PACIFIC
                | NEW_ZEALAND_SOUTH_WEST_PACIFIC
                | INTERNATIONAL_DOMESTIC
                | INTERNATIONAL

newtype RoundFareContext = RoundFareContext
  { siteCode :: PosCountry
  , interfaceCode :: Brand
  , routeOrigin :: Airport
  , routeDestination :: Airport
  , bookingType :: FlightPath
  , clientCurrentDateTime :: DateTime
  }

newtype Fare = Fare
  { fareIdentifier :: String
  , marketingCarrier :: String
  , price :: Number
  }

newtype RuleData = RuleData
  { context :: RoundFareContext
  , fares :: Array Fare
  }

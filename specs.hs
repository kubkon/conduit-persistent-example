-- specs.hs
{-# LANGUAGE EmptyDataDecls    #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}

module Specs where

import qualified Database.Persist.TH as TH

TH.share [TH.mkPersist TH.sqlSettings, TH.mkMigrate "migrateAll"] [TH.persistLowerCase|
MyRecord
  value Int
  deriving Show
|]

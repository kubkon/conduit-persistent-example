-- createDB.hs
{-# LANGUAGE OverloadedStrings #-}

import Database.Persist (insertMany)
import Database.Persist.Sqlite (runSqlite,runMigration)
import qualified Specs as S

main :: IO ()
main = runSqlite "test.sqlite" $ do

  -- Create test DB and populate with values
  let n = 100000
  runMigration S.migrateAll
  insertMany $ map S.MyRecord [1..n]

  return ()

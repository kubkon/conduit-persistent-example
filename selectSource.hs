-- selectSource.hs
{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.IO.Class  (liftIO)
import Data.Conduit (await,yield,leftover,Conduit,($$),(=$))
import qualified Data.Conduit.List as CL
import Database.Persist (selectSource,entityVal,Entity)
import Database.Persist.Sqlite (runSqlite)
import Specs (MyRecord(..),myRecordValue)

entityToValue :: Monad m => Conduit (Entity MyRecord) m Int
entityToValue = CL.map (myRecordValue . entityVal)

printPairs :: Monad m => Conduit Int m String
printPairs = do
  mi1 <- await
  mi2 <- await
  case (mi1, mi2) of
    (Just i1, Just i2) -> do
      yield $ show (i1, i2)
      leftover i2
      printPairs
    _ -> return ()

main :: IO ()
main = runSqlite "test.sqlite" $ do

  -- Using Source Conduit Sink
  selectSource [] [] $$ entityToValue =$ printPairs =$ CL.mapM_ (liftIO . putStrLn)

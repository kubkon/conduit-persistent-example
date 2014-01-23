-- selectSource.hs
{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.IO.Class  (MonadIO,liftIO)
import Data.Conduit (await,yield,leftover,Conduit,Sink,($$),(=$))
import qualified Data.Conduit.List as CL
import Database.Persist (selectSource,entityVal,Entity)
import Database.Persist.Sqlite (runSqlite)
import Specs (MyRecord(..),myRecordValue)

-- |Unpacks incoming values from upstream from MyRecord to Int
entityToValue :: Monad m => Conduit (Entity MyRecord) m Int
entityToValue = CL.map (myRecordValue . entityVal)

-- |Converts pairwise tuples of Ints into String
showPairs :: Monad m => Conduit Int m String
showPairs = do
  mi1 <- await -- get the next value from the input stream
  mi2 <- await
  case (mi1, mi2) of
    (Just i1, Just i2) -> do
      yield $ show (i1, i2) -- pass tuple of Ints converted
                            -- to String downstream
      leftover i2           -- pass the second component of
                            -- the tuple back to itself (to
                            -- the upstream)
      showPairs
    _ -> return ()

-- |Prints input String
printString :: (Monad m, MonadIO m) => Sink String m ()
printString = CL.mapM_ (liftIO . putStrLn)

main :: IO ()
main = runSqlite "test.sqlite" $ do

  -- Select all records from DB and return them as a Source
  selectSource [] [] $$ entityToValue =$ showPairs =$ printString

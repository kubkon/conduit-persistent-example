-- selectList.hs
{-# LANGUAGE OverloadedStrings #-}

import Control.Monad (mapM_)
import Control.Monad.IO.Class  (liftIO)
import Database.Persist (selectList,entityVal)
import Database.Persist.Sqlite (runSqlite)
import Specs (myRecordValue)

main :: IO ()
main = runSqlite "test.sqlite" $ do

    -- Using standard list approach
    records <- selectList [] []
    let values = map (myRecordValue . entityVal) records
    mapM_ (liftIO . putStrLn . show) $ zip values $ tail values

{-# LANGUAGE MultiParamTypeClasses, NoImplicitPrelude #-}

module Control.Monad.Var.Class
  ( VarMonad (..)
  ) where

import Control.Monad (Monad)
import Data.Function ((.))
import System.IO (IO)

-- IORef
import Data.IORef (IORef, newIORef, readIORef, writeIORef)

-- MVar
import Control.Concurrent.MVar (MVar, newMVar, takeMVar, putMVar)

-- ST
import Control.Monad.ST (ST)
import Data.STRef (STRef, newSTRef, readSTRef, writeSTRef)

-- STM
import Control.Concurrent.STM (STM, atomically)
import Control.Concurrent.STM.TVar (TVar, newTVar, readTVar, writeTVar)
import Control.Concurrent.STM.TMVar (TMVar, newTMVar, takeTMVar, putTMVar)

class Monad m => VarMonad m v
  where
    new :: a -> m (v a)
    get :: v a -> m a
    put :: v a -> a -> m ()

instance VarMonad (ST s) (STRef s)
  where
    new = newSTRef
    get = readSTRef
    put = writeSTRef

instance VarMonad IO IORef
  where
    new = newIORef
    get = readIORef
    put = writeIORef

instance VarMonad IO MVar
  where
    new = newMVar
    get = takeMVar
    put = putMVar

instance VarMonad STM TVar
  where
    new = newTVar
    get = readTVar
    put = writeTVar

instance VarMonad STM TMVar
  where
    new = newTMVar
    get = takeTMVar
    put = putTMVar

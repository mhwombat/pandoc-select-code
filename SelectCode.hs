{-# LANGUAGE OverloadedStrings #-}

import qualified Text.Pandoc      as P
import           Text.Pandoc.JSON (toJSONFilter)

main :: IO ()
main = toJSONFilter formatProofs

formatProofs :: P.Block -> P.Block
formatProofs x@(P.CodeBlock _ _) = x
formatProofs _                   = P.Null

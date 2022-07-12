module CirclesPink.GenerateTSD where

import CirclesPink.Prelude

import CirclesPink.GenerateTSD.Modules (moduleMap, modules)
import Data.Array as A
import Effect.Class.Console (logShow)
import Language.TypeScript.DTS (printModule)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (writeTextFile)
import Node.Process as NP
import Options.Applicative (Parser, ParserInfo, execParser, fullDesc, header, help, helper, info, long, metavar, strOption, (<**>))
import PursTs (defineModules)

type GenerateTSOpts =
  { outputDir :: String
  }

parserOpts :: Parser GenerateTSOpts
parserOpts = ado
  outputDir <- strOption $ fold
    [ long "output-dir"
    , metavar "OUTPUT_DIR"
    , help "Dictionary containing compiled PureScript files"
    ]

  in { outputDir }

parserInfo :: ParserInfo GenerateTSOpts
parserInfo = info (parserOpts <**> helper)
  ( fold
      [ fullDesc
      , header "generate-tsd - Generate tsd files from PureScript modules"
      ]
  )

main :: Effect Unit
main = do
  opts <- execParser parserInfo
  logShow opts
  modules
    # defineModules moduleMap
    # traverse_
        ( \(modName /\ mod) ->
            writeTextFile UTF8
              (opts.outputDir <> "/" <> modName <> "/index.d.ts")
              (printModule mod)
        )


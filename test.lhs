> module CS50 where
> import Euterpea
> import qualified Turtle as T

Compose some music!

> youSleeping = [c 4 qn, d 4 qn, e 4 qn, c 4 qn]
> brotherJohn = [e 4 qn, f 4 qn, g 4 hn]
> morningBells = [g 4 en, a 4 en, g 4 en, f 4 en, e 4 qn, c 4 qn]
> dingDong = [(c 4 qn :=: e 3 qn), (f 3 qn :=: g 3 qn), (c 4 hn :=: e 3 hn)]

> frereJacques :: [Music Pitch]
> frereJacques = concat $ concatmap (replicate 2) [youSleeping, brotherJohn, morningBells, dingDong]

> withRound = let part1 = instrument AcousticGrandPiano (line frereJacques)
>                 part2 = instrument Violin (line (rest 2 : frereJacques))
>                 part3 = instrument SynthBass2 (line (rest 4 : frereJacques))
>                 part4 = instrument FrenchHorn (line (rest 6 : frereJacques))
> 	          in play (part1 :=: part2 :=: part3 :=: part4)

Output this to a shell script with Turtle; generate MIDI and convert to LilyPond
cmd will be: "midi2ly --flags"


> main :: (T.MonadIO io0) => io0 T.ExitCode
> main = do
> 		T.shell "ls" T.empty

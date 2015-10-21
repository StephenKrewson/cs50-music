> {-# LANGUAGE OverloadedStrings #-}

> module CS50 where
> import Euterpea
> import qualified Turtle as T

Part 1: Let's compose some music!
=================================

> youSleeping = [c 4 qn, d 4 qn, e 4 qn, c 4 qn]
> brotherJohn = [e 4 qn, f 4 qn, g 4 hn]
> morningBells = [g 4 en, a 4 en, g 4 en, f 4 en, e 4 qn, c 4 qn]
> dingDong = [(c 4 qn :=: e 3 qn), (f 3 qn :=: g 3 qn), (c 4 hn :=: e 3 hn)]

> song :: [Music Pitch]
> song = concat $ concatMap (replicate 2) [youSleeping, brotherJohn, morningBells, dingDong]

> frereJacques =
>	let
>		part1 = instrument AcousticGrandPiano (line song)
>		part2 = instrument Violin (line (rest 2 : song))
>		part3 = instrument SynthBass2 (line (rest 4 : song))
>		part4 = instrument FrenchHorn (line (rest 6 : song))
>	in (part1 :=: part2 :=: part3 :=: part4)

Part 2: Playing that music
==========================

> playMusic = play frereJacques
> generateMidi = writeMidi "song" frereJacques

Part 3: Sending MIDI to LilyPond
================================

> main :: IO T.ExitCode
> main = do
>		generateMidi
> 		T.shell "midi2ly song" T.empty
>		T.shell "lilypond song-midi.ly" T.empty
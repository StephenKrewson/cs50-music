> {-# LANGUAGE OverloadedStrings #-}

> module CS50 where
> import Euterpea
> import Data.Maybe
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
>		part1 = instrument Helicopter $ addVolume 127 (line song)
>		part2 = instrument Pad3Polysynth $ addVolume 127 (line (rest 2 : song))
>		part3 = instrument Lead1Square $ addVolume 70 (line (rest 4 : song))
>		part4 = instrument VoiceOohs $ addVolume 127 (line (rest 6 : song))
>	in (part1 :=: part2 :=: part3 :=: part4)

> gN :: Int
> gN = 32

> stepSequence :: Maybe Volume -> Int -> [Int] -> Music (Pitch, Volume)
> stepSequence _ _ [] = rest 0
> stepSequence v p xs = addVolume v' $ line [if x `elem` xs then perc (toEnum p) qn else qnr | x <- [1..gN]]
>	where v' = fromMaybe 75 v

> drumMachine :: Music (Pitch, Volume)
> drumMachine = let r = [1..gN]
>                   f n p = (\x -> x `mod` n == p)
>                   p1 = stepSequence (Just 127) 1 $ filter (f 4 1) r
>                   p2 = stepSequence Nothing 7 $ filter (f 4 3) r
>                   p3 = stepSequence (Just 127) 0 [7,10,14,23,26,30]
>                   p4 = stepSequence Nothing 4 $ filter (f 8 5) r
>                   p5 = stepSequence (Just 127) 27 $ foldr (:) [] $ filter (odd) [2,7,4,31,30,10,11,14]
>                   p6 = stepSequence Nothing 28 $ map (`mod` gN) $ scanr (+) 1 [1..5]
>                   p7 = stepSequence Nothing 29 $ zipWith (*) (concatMap (replicate (gN `quot` 3)) [8,15,16]) (take gN $ cycle [1..(gN `quot` 3)])
>                   p8 = stepSequence Nothing 41 $ take gN $ iterate (+3) 2
>                   p9 = stepSequence Nothing 35 $ filter (not . (f 4 1)) r
>                   p10 = stepSequence Nothing 3 [7,15,25,28,32]
>               in tempo 4 $ instrument Percussion $ repeatM $ chord [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10]

> playMusic = play $ frereJacques /=: drumMachine
> generateMidi = writeMidi "song.midi" frereJacques


Part 3: Sending MIDI to LilyPond
================================

> frere :: Music Pitch
> frere = p1 :+: p2 :+: p3 :+: p4
> twice x = x :+: x 
> p1 = twice (c 4 qn :+: d 4 qn :+: e 4 qn :+: c 4 qn)
> p2 = twice (e 4 qn :+: f 4 qn :+: g 4 hn)
> p3 = twice (g 4 en :+: a 4 en :+: g 4 en :+: f 4 en :+: e 4 qn :+: c 4 qn)
> p4 = twice (c 4 qn :+: g 3 qn :+: c 4 hn)

this has to exist already, but its easier to rewrite than find

> multDur :: Dur -> Integer -> Dur
> multDur d 1 = 0
> multDur d i = d + multDur d (i-1)

For that matter this probably exists too
Takes a Duration between voices # of voices and music

> round1 :: Dur -> Integer -> Music Pitch -> Music Pitch
> round1 d 1 m = m 
> round1 d v m = (rest (multDur d (v-1)) :+: m) :=: (round1 d (v-1) m)

This one will give back the round in a list so you 
can further manipulate individual voices

> round2 :: Dur -> Integer -> Music Pitch -> [Music Pitch]
> round2 d 1 m = [m]
> round2 d v m = (rest (multDur d (v-1)) :+: m) : (round2 d (v-1) m)

Now we can easily change the instrument of each voice

> assignInst :: [InstrumentName] -> [Music Pitch] -> [Music Pitch]
> assignInst (i:is) (m:ms) = instrument i m : assignInst is ms
> assignInst [] [] = []
> assignInst _ [] = error "too many instruments"
> assignInst [] _ = error "not enuf instruments"

> brassQuartet = [Tuba,Trombone,FrenchHorn,Trumpet]
> frereR = round2 bn 4 frere
> frereRI = assignInst brassQuartet frereR
> solution314 = play (foldl (:=:) (rest qn) frereRI) 



> main :: IO T.ExitCode
> main = do
>		generateMidi
>		T.shell "lilypond song-midi.ly" T.empty

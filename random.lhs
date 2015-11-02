> module CS50 where
> import Euterpea
> import System.Random
> import Data.Array.IO
> import Control.Monad

> filterNote seq = [n | n <- seq, n `elem` [1..10]]

> reverse' :: [a] -> [a]
> reverse' [] = []
> reverse' (x:xs) = reverse' xs ++ [x]

zip, cycle, take

list comp, typeclasses (Eq, Ord, etc.)

> beat = let p1 = perc BassDrum1 qn
>            p2 = perc AcousticBassDrum qn
>            p3 = perc ClosedHiHat en
>		 in tempo 2 $ instrument Percussion $ takeM 8 $ repeatM (p1)

> stepSequence' :: Int -> [Int] -> [Music Pitch]
> stepSequence' _ [] = []
> stepSequence' n xs = [if x `elem` xs then perc BassDrum1 qn else qnr | x <- [1..n]]

> gN :: Int
> gN = 32

> stepSequence :: Int -> [Int] -> Music Pitch
> stepSequence _ [] = rest 0
> stepSequence p xs = line [if x `elem` xs then perc (toEnum p) qn else qnr | x <- [1..gN]]

> drumMachine :: Dur -> IO ()
> drumMachine d = let r = [1..gN]
>                     f n p = (\x -> x `mod` n == p)
>                     p1 = stepSequence 1 $ filter (f 4 1) r
>                     p2 = stepSequence 7 $ filter (f 4 3) r
>                     p3 = stepSequence 0 [7,10,14,23,26,30]
>                     p4 = stepSequence 4 $ filter (f 8 5) r
>                     p5 = stepSequence 27 $ foldr (:) [] $ filter (odd) [1..5]
>                     p6 = stepSequence 28 $ map (`mod` gN) $ scanr (+) 1 [1..5]
>                     p7 = stepSequence 29 $ zipWith (*) (concatMap (replicate (gN `quot` 3)) [8,15,16]) (take gN $ cycle [1..(gN `quot` 3)])
>                     p8 = stepSequence 41 $ take gN $ iterate (+3) 2
>                     p9 = stepSequence 35 $ filter (not . (f 4 1)) r
>                     p10 = stepSequence 3 [7,15,25,28,32]
>                 in play $ tempo 4 $ instrument Percussion $ takeM d $ repeatM $ chord [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10]

> funkGroove :: Music Pitch
> funkGroove = let p1 = perc LowTom qn
>                  p2 = perc AcousticSnare en
>              in tempo 3 $ instrument Percussion $ takeM 8 $ repeatM ((p1 :+: qnr :+: p2 :+: qnr :+: p2 :+: p1 :+: p1 :+: qnr :+: p2 :+: enr ) :=: roll en (perc ClosedHiHat 2))

> tb = play beat

> houseGroove = let p1 = perc BassDrum1 qn
>                   p2 = perc HandClap qn
>                   p3 = perc Claves en
>				in tempo 2 $ instrument Percussion $ takeM 8 $ repeatM 
>                    (addVolume 127 (p1 :+: qnr :+: (p1 :=: p2) :+: qnr) :=: 
>                    addVolume 55 (roll en (perc PedalHiHat 1)) :=:
>                    addVolume 80 (qnr :+: p3 :+: enr :+: hnr))

> houseBass = instrument AcousticBass $ addVolume 100 $ line [c 3 hn, c 3 en, cs 3 en, c 4 en, c 3 hn, qnr, f 2 sn, f 2 en, g 2 en, e 2 hn, snr, e 2 sn]		 
> houseMel = instrument Pad2Warm $ addVolume 127 $ line [rest 2, e 4 en, f 4 en, e 4 en, g 4 en, g 4 sn, c 4 hn, c 5 qn, b 4 en, b 4 sn, chord [f 3 hn, a 3 hn, e 4 hn]]

> groove2 = takeM 16 $ repeatM (houseGroove :=: houseBass :=: houseMel)
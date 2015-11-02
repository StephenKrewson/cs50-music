# cs50-music

Hello! This is CS50. And we are Connor Harris (Harvard) and Stephen Krewson (Yale). This repo contains all the code we will use in our seminar on Computer Music. You can get it by running the command:

	git clone git@github.com:StephenKrewson/cs50-music
	cd cs50-music

Euterpea is a domain-specific (i.e. it's for music!) embedded language built on top of Haskell, which is one of the best known and most advanced *functional* programming languages.

LilyPond offers a way to engrave sheet music using a musical (an)notation syntax that has similarities to the typesetting system TeX.

NOTE: The MIDI software needed for this seminar exceeds the available disk space on the CS50 IDE. So, while less than ideal, you'll need to get the following pieces in place and talking to each other on your own machine.

## Requirements

- Haskell

We recommend installing the latest version of the Haskell Platform [here](https://www.haskell.org/downloads#platform). Then run:

	cabal install update-cabal
	cabal update

This will ensure that you have the latest version of everything before installing Euterpea.

- Euterpea

Run

	cabal install euterpea

See [the following](http://euterpea.com/install). My own setup uses Windows 7, but you will be able to download and use it no problem with \*nix systems. You may run into trouble trying to generate MIDI or audio, however.

One Mac, you'll need to install some additional software. On Ubuntu, there are just a few packages to download with apt-get.

- Audio

Presumably, your computer can generate sound. This is no guarantee that it can synthesize MIDI, however. Older versions of Windows did have a built-in wavetable synth. But in general, you'll need to install some software to take the MIDI representation of some musical sequence and turn it into audio.

Consult Donya Quick's [excellent overview] (http://donyaquick.com/midi-on-windows/).

I am using [CoolSoft's MIDI synth for Windows] (http://coolsoft.altervista.org/en/virtualmidisynth).

A virtual synth implies the need for some type of sample bank to generate the sounds for the various MIDI instruments: 

https://en.wikipedia.org/wiki/General_MIDI

Here's a recommended and free option: http://www.synthfont.com/soundfonts.html. For compresessed SoundFonts with the extension .sfark, use the [sfARK tool](http://www.synthfont.com/sfArk.zip). Extract the SoundFont library and then upload the .sf2 file to VirtualMIDISynth.

You'll have to unzip sfARK itself.

It may be easier to just pick an uncompresseed SountFont. There are plenty of them listed on the SynthFont website.

- LilyPond
You can install LilyPond [here] (http://lilypond.org/download.html). Don't change any of the defaults during the install, since we'll want things like the bundled Python interpreter to make our use of the midi2ly script easier.

- midi2ly
Make sure your PATH and PATHEXT environment variables are set correctly as described [here] (http://www.lilypond.org/doc/v2.19/Documentation/usage/invoking-midi2ly). More on midi2ly soon.
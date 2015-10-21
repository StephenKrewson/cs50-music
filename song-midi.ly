% Lily was here -- automatically converted by C:\Program Files (x86)\LilyPond\usr\bin\midi2ly.py from song
\version "2.14.0"

\layout {
  \context {
    \Voice
    \remove "Note_heads_engraver"
    \consists "Completion_heads_engraver"
    \remove "Rest_engraver"
    \consists "Completion_rest_engraver"
  }
}

trackAchannelA = {
  
  \tempo 4 = 120 
  
}

trackAchannelB = \relative c {
  c4 d e c 
  | % 2
  c d e c 
  | % 3
  e f g2 
  | % 4
  e4 f g2 
  | % 5
  g8 a g f e4 c 
  | % 6
  g'8 a g f e4 c 
  | % 7
  <e, c' >4 <g f >4 <e c' >2 
  | % 8
  <e c' >4 <g f >4 <e c' >2 
  | % 9
  
}

trackA = <<

  \clef bass
  
  \context Voice = voiceA \trackAchannelA
  \context Voice = voiceB \trackAchannelB
>>


trackBchannelA = {
  
  \tempo 4 = 120 
  
}

trackBchannelB = \relative c {
  r1*2 c4 d e c 
  | % 4
  c d e c 
  | % 5
  e f g2 
  | % 6
  e4 f g2 
  | % 7
  g8 a g f e4 c 
  | % 8
  g'8 a g f e4 c 
  | % 9
  <e, c' >4 <g f >4 <e c' >2 
  | % 10
  <e c' >4 <g f >4 <e c' >2 
  | % 11
  
}

trackB = <<

  \clef bass
  
  \context Voice = voiceA \trackBchannelA
  \context Voice = voiceB \trackBchannelB
>>


trackCchannelA = {
  
  \tempo 4 = 120 
  
}

trackCchannelB = \relative c {
  r1*4 c4 d e c 
  | % 6
  c d e c 
  | % 7
  e f g2 
  | % 8
  e4 f g2 
  | % 9
  g8 a g f e4 c 
  | % 10
  g'8 a g f e4 c 
  | % 11
  <e, c' >4 <g f >4 <e c' >2 
  | % 12
  <e c' >4 <g f >4 <e c' >2 
  | % 13
  
}

trackC = <<

  \clef bass
  
  \context Voice = voiceA \trackCchannelA
  \context Voice = voiceB \trackCchannelB
>>


trackDchannelA = {
  
  \tempo 4 = 120 
  
}

trackDchannelB = \relative c {
  r1*6 c4 d e c 
  | % 8
  c d e c 
  | % 9
  e f g2 
  | % 10
  e4 f g2 
  | % 11
  g8 a g f e4 c 
  | % 12
  g'8 a g f e4 c 
  | % 13
  <e, c' >4 <g f >4 <e c' >2 
  | % 14
  <e c' >4 <g f >4 <e c' >2 
  | % 15
  
}

trackD = <<

  \clef bass
  
  \context Voice = voiceA \trackDchannelA
  \context Voice = voiceB \trackDchannelB
>>


\score {
  <<
    \context Staff=trackA \trackA
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
  >>
  \layout {}
  \midi {}
}

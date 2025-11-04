Uebersicht = require 'uebersicht'
command: "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyInfo.scpt"
refreshFrequency: 5000

render: (output) ->
  return "<div class='spotify-widget'>Not Playing</div>" unless output?.trim()
  parts = output.trim().split("||")
  return "<div class='spotify-widget'>Not Playing</div>" if parts.length < 3

  [track, artist,artwork, state] = parts
  playPauseIcon = if state is 'playing' then '' else '▶⏸'

  """
  <div class='spotify-widget'>
    <div class='spotify-info'>♫ #{track} — #{artist}</div>
    <div class='spotify-popup'>
      <img class='spotify-cover' src='#{artwork}' alt='cover'>
      <div class='spotify-controls'>
        <button class='button spotify-prev'>⏮</button>
        <button class='button spotify-play'>#{playPauseIcon}</button>
        <button class='button spotify-next'>⏭</button>
      </div>
    </div>
  </div>
  """



afterRender: (domEl) ->
  domEl.querySelector('.spotify-prev')?.addEventListener 'click', ->
    Uebersicht.run "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyPrev.scpt"
  domEl.querySelector('.spotify-play')?.addEventListener 'click', ->
    if domEl.querySelector('.spotify-play').innerText is '⏸'
      Uebersicht.run "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyPause.scpt"
    else
      Uebersicht.run "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyPlay.scpt"
  domEl.querySelector('.spotify-next')?.addEventListener 'click', ->
    Uebersicht.run "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyNext.scpt"

style: """
  .spotify-widget {
    justify-content: center; 
    position: fixed;
    top: 0px; 
    left: 20px;
    padding: 6px 15px;
    font-family: -apple-system, sans-serif;
    font-size: 12px; 
    color: white;
    box-shadow: 0 4px 12px rgba(0,0,0,0.0);
    text-shadow: 1px 1px 1px black;
  }
  .spotify-popup { display: none; margin-top: 15px; justify-content: center; }
  .spotify-widget:hover .spotify-popup { 
  justify-content: center; 
  padding: 10px; 
  background: rgba(255,255,255,0.05);
  border: 2px solid rgba(255,255,255,0.15);
  border-radius: 50px; }
  .spotify-widget:hover .spotify-popup img {  display: block; margin: auto; width: 50%; padding: 10px; size: 5vw; border-radius: 35px;}
  .spotify-controls { 
  display: flex; 
  gap: 25px; 
  justify-content: center; 
  background:rgba(255,255,255,0.1); 
  padding-top: 0px; 
  border-radius: 50px;  }
  .spotify-widget:hover .spotify-info { font-size: 12px; }
  .spotify-widget:hover .spotify-popup { 
  box-shadow: 0 4px 12px rgba(0,0,0,0.2);
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 35px;
  display: block; 
  justify-content: center; 
  padding: 10px 10px;}
  .spotify-controls button {
    border-radius: 25px;
    padding: 3px 10px 0px 10px;
    color: white;
    cursor: pointer; 
    font-size: 22px;
    box-shadow: 0 10px 15px rgba(0,0,0,0.1);
    background: rgba(255,255,255,0.0);
    border: 1px solid rgba(255,255,255,0.0);
  }
  .spotify-controls button:hover { padding:0px 14px; background: rgba(255,255,255,0.2); border: 1px solid rgba(255,255,255,0.2);}
"""

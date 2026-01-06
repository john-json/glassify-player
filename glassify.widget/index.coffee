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
    z-index: 1000;
    display: flex;
    justify-content: left; 
    align-items: center;
    position: fixed;
    bottom: 10px;
    left:0;
    right: 0;
    margin-left: 5px;
    padding: 10px 16px 8px 16px;
    font-family: -apple-system, sf-pro, monospace;
    font-size: 10pt;
    color: white;
    box-shadow: px rgba(0,0,0,0.0);
    text-shadow: 0 0 1px rgba(0, 0, 0, 1);
    max-width: 10%;
    border-radius: 25px;
  }
  .spotify-info {
    pointer-events: none;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    justify-content: center;
    align-items: center;
  }
  .spotify-popup { display: none; padding: 30px 10px 8px 16px; justify-content: center; }
  .spotify-widget:hover .spotify-popup { 
  justify-content: center; 
  padding: 10px; 
  background: rgba(255,255,255,0.05);
  border: 2px solid rgba(255,255,255,0.15);
  border-radius: 25px; }
  .spotify-widget:hover .spotify-popup img {  display: block; margin: auto; width: 50%; padding: 10px; size: 5vw; border-radius: 25px; box-shadow: 0 15px 20px rgba(0,0,0,0.1);}
  .spotify-controls { 
  display: flex; 
  justify-content: space-around; 
  background:rgba(255,255,255,0.1); 
  padding-top: 2px; 
  border-radius: 25px;  }
  .spotify-widget:hover .spotify-info { display:none; font-size: 10pt; }
  .spotify-widget:hover .spotify-popup { 
  box-shadow: 0 4px 25px rgba(0,0,0,0.1);
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 25px;
  display: block; 
  justify-content: center; 
  padding: 10px 10px;}
  .spotify-controls button {
    padding: 5px 8px;
    border-radius: 25px;
    color: white;
    cursor: pointer; 
    font-size: 10pt;
    box-shadow: 0 15px 20px rgba(0,0,0,0.1);
    background: rgba(255,255,255,0.0);
    border: 1px solid rgba(255,255,255,0.0);
  }
  .spotify-controls button:hover {  background: rgba(255,255,255,0.2); border: 1px solid rgba(255,255,255,0.2);}
"""

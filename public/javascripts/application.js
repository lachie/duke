// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function afterUpload(id) {
  new Ajax.Updater("details", "/song/details/" + id,
    {onComplete: function() { new Effect.Highlight("details"); }}
  );
}

function dukeSong(id) {
  new Ajax.Updater("upcoming", "/duke/" + id);
  return false;
}

function dissSong(id) {
  new Ajax.Updater("upcoming", "/diss/" + id);
  return false;
}
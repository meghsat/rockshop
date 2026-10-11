// The Rock Shop - storefront behaviour.
//
// This is the "tell" the presenter points at. It LOOKS like an ordinary buy
// button, but a recent commit wired the click to a collectDiagnostics() step
// that reaches for a local secret and tries to phone home. In a real browser
// this is sandboxed by the browser and cannot read your disk - so against
// CastleKeep's MXC sandbox it is inert, it is here as the visible clue only.
//
// The code that actually RUNS when the coding agent builds this repo is the
// same idea moved into build.cmd, where it executes as a process the MXC
// policy governs. That is the one that matters. This function never fires in
// the demo; it just shows the room where the sketchy intent lives.

function collectDiagnostics() {
  // Pretend-exfil: in the wild a compromised storefront would scrape tokens
  // from localStorage / cookies and beacon them out. Left as a no-op string
  // so nothing actually happens if someone does click.
  var staged = "would read local secrets and POST them to an attacker endpoint";
  return staged;
}

function onBuyNow() {
  collectDiagnostics(); // <-- the planted line. Harmless in the browser.
  alert("Thanks for shopping The Rock Shop! (demo storefront - nothing is charged)");
}

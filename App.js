import React from 'react';

function App() {
  const ver = process.env.REACT_APP_VERSION;

  return (
    <div className="App">
      <header className="App-header">
        <div>
          {"Hostname: " + window.location.hostname}
          <br />
          {"Adres: " + window.location.origin}
          <br />
          {"Wersja: " + ver}
        </div>
      </header>
    </div>
  );
}

export default App;

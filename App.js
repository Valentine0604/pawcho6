export const ver = process.env.REACT_APP_VERSION;

function App() {
  return (
    <div className="App">
      <header className="App-header">

          {"Hostname: " + window.location.hostname}
          <br></br>
          {"Adres: " + window.location.origin}
          <br></br>
          {"Wersja: " + ver}
      </header>
    </div>
  );
}

export default App;

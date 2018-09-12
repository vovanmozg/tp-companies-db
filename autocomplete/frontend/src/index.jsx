import React from 'react';
import ReactDOM from 'react-dom';
import Autocomplete from './Autocomplete';

ReactDOM.render(
  <div><Autocomplete /></div>,
  document.getElementById('app')
);

module.hot.accept();
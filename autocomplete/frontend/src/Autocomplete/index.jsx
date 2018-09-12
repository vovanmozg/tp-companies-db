import React from 'react';
import axios from 'axios';
import List from '../List';
import './style.css';

class Autocompolete extends React.Component {
  constructor(props){
    super(props);
    this.state = { companies: [] };
    this.onChange = this.onChange.bind(this);
  }

  render() {
    return <div className='searchWrapper'>
      <input onChange={this.onChange} placeholder='Company name...'  />
      <List companies={this.state.companies} />
    </div>
  }

  onChange(event) {
    const term = event.target.value;

    if (term === '') {
      this.setState({ companies: [] })
      return;
    }

    const config = {
      headers: {'Access-Control-Allow-Origin': '*'}
    };
    axios.get(`http://localhost:3001/autocomplete/${term}`, config)
        .then( (response) => {
          this.setState({ companies: response.data })
        })

  }
}


export default Autocompolete;





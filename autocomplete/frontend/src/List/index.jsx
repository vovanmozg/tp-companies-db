import React from 'react';
import './style.css';

class Index extends React.Component {
  static defaultProps = {
    companies: [],
  };

  render() {
    const items = this.props.companies.map(company => <div className='item'>{company.company_name}</div>);
    return <div className='companies'>
      { items }
    </div>
  }
}

export default Index;





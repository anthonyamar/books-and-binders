import React from "react"
import PropTypes from "prop-types"

class Heading extends React.Component {
  
  constructor(props) {
    super(props);
    this.state = {
      book: JSON.parse(this.props.book)
    }
  }
  
  render () {
    const book = this.state.book
    
    return (
      <React.Fragment>
        <h1>{book.title}</h1>
        <h2>De {book.author}</h2>
        
      </React.Fragment>
    );
  }
}

export default Heading

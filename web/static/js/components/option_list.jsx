import React from "react"
import Option from "web/static/js/components/option"
import { newOption, load } from "web/static/js/actions/options"
import { store } from "web/static/js/stores/store"
const { array } = React.PropTypes

const OptionList = React.createClass({
  propTypes: {
    workflows: array.isRequired
  },

  getInitialState() {
    return {options: []}
  },

  componentWillMount() {
    store.subscribe(() => this.handleNewState())
  },

  componentDidMount() {
    load(this.props.options)
  },

  render() {
    const options = this.state.options.map((o, i) => <Option key={o.id} workflows={this.props.workflows} {...o} />)
    return (
      <div>
        {options}
        <button className="btn btn--primary" onClick={this.handleAddClick}>Add another option</button>
      </div>
    )
  },

  handleAddClick() {
    newOption()
  },

  handleNewState() {
    this.setState(store.getState())
  }
})

module.exports = OptionList

import React from "react"
import { updateName } from "../actions/setting"
import { store } from "../stores/store"
const { string } = React.PropTypes

const ChurchNameSetting = React.createClass({
  propTypes: {
    name: string.isRequired
  },

  getInitialState() {
    return { editing: false, name: this.props.name }
  },

  componentWillMount() {
    store.subscribe(() => this.handleNewState())
  },
  
  render() {
    return(
      <h2>
        <span>Church Name: </span>
        {this.renderChurchNameOrForm()}
      </h2>
    )
  },

  renderChurchNameOrForm() {
    if (this.state.editing) {
      return (
        <span>
          <input type="text" value={this.state.name} name="settings[church_name]" onChange={this.handleChange} />
          <input type="submit" onClick={this.handleSubmit} />
        </span>
      )
    } else {
      return (
        <span>
          {this.state.name}
          <i className="fa fa-pencil" onClick={this.handleEditClick}></i>
        </span>
      )
    }
  },

  handleChange(e) {
    this.setState({ name: e.target.value })
  },

  handleEditClick() {
    this.setState({ editing: true })
  },

  handleSubmit() {
    updateName(this.state.name)
  },

  handleNewState() {
    this.setState({ name: store.getState().settings.name, editing: false })
  }
})

module.exports = ChurchNameSetting

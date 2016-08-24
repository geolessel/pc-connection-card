import React from "react"
import { updateName, load } from "../actions/setting"
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
    load(this.props.name)
    store.subscribe(() => this.handleNewState())
  },

  render() {
    return(
      <h2 className="fs-24p">
        {this.renderChurchNameOrForm()}
      </h2>
    )
  },

  renderChurchNameOrForm() {
    if (this.state.editing) {
      return (
        <span>
          <input type="text" className="fs-12p" style={{padding: "7px", width: "300px"}} value={this.state.name} name="settings[church_name]" onChange={this.handleChange} />
          {' '}
          <button type="submit" className="fs-12p btn btn--primary" onClick={this.handleSubmit}>
            Save
          </button>
        </span>
      )
    } else {
      return (
        <span>
          {this.state.name}
          {' '}
          <i className="fa fa-pencil fs-18p p-r" style={{color: "#07b", cursor: "pointer", top: "-2px"}} onClick={this.handleEditClick}></i>
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

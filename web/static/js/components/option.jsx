import React from "react"
import { removeOption, createOption, deleteOption } from "web/static/js/actions/options"

const Option = React.createClass({
  getInitialState() {
    return {
      // we need this in case the user never changes the selected option
      // which would never fire handleSelectChange which would never
      // set the state's workflow_id
      workflow_id: this.props.workflow_id || this.props.workflows[0].id
    }
  },

  render() {
    const { props } = this
    if (props.id) { return <ExistingOption {...props} onClick={this.handleDelete.bind(null, props.id)} /> }
    else {
      const options = props.workflows.map(w => <option key={w.id} value={w.id}>{w.name}</option>)
      return (
        <fieldset className="pane">
          <div className="flex-stack">
            <div className="f-1" style={{flex: 0, flexBasis: "200px"}}>
              <strong>Name:</strong> <input type="hidden" name="option[id]" value={props.id} />
              <input
                type="text"
                name="option[name]"
                placeholder="Volunteering"
                defaultValue={props.name}
                onChange={this.handleNameChange}
                className="fs-12p"
              />
            </div>
            <div className="f-1 fb-0">
              <label htmlFor="option_workflow_id"><strong>Workflow:</strong></label>
              {' '}
              <select name="option[workflow_id]" defaultValue={this.state.workflow_id} className="select" onChange={this.handleSelectChange}>
                {options}
              </select>
            </div>
          </div>
          <div className="ta-r btw-1p pt-1r " style={{margin: "1rem -1rem 0", borderColor: "#eee"}}>
            <button className="fs-12p btn btn--primary" onClick={this.handleSave}>Save</button>
            <button className="fs-12p btn" onClick={this.handleCancel}>Cancel</button>
          </div>
        </fieldset>
      )
    }
  },

  handleNameChange(e) {
    this.setState({ name: e.target.value })
  },

  handleSelectChange(e) {
    this.setState({ workflow_id: e.target.value })
  },

  handleCancel() {
    removeOption(this.props)
  },

  handleSave() {
    this.props.id ? updateOption(this.state) : createOption(this.state)
  },

  handleDelete(id) {
    deleteOption(id)
  }
})

const ExistingOption = props => {
  name = props.workflows.find(w => w.id == props.workflow_id).name
  return (
    <div className="pane flex-stack">
      <div className="f-1" style={{flex: 0, flexBasis: "200px"}}>
        <strong>Name:</strong> {props.name}
      </div>
      <div className="f-1 fb-0 truncate">
        <strong>Workflow</strong>:
        {' '}
        {name}
      </div>
      <div className="delete-icon" onClick={props.onClick}>
        <div className="fa fa-close"></div>
      </div>
    </div>
  )
}

module.exports = Option

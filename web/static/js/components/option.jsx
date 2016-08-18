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
        <fieldset>
          <div className="form-group">
            <input type="hidden" name="option[id]" value={props.id} />
            <label htmlFor="option_name">Display name</label>
            <input type="text" name="option[name]" className="form-control" defaultValue={props.name} onChange={this.handleNameChange} />
          </div>
          <div className="form-group">
            <label htmlFor="option_workflow_id">Associated Workflow</label>
            <select name="option[workflow_id]" defaultValue={this.state.workflow_id} className="form-control" onChange={this.handleSelectChange}>
              {options}
            </select>
          </div>
          <button className="btn btn-primary" onClick={this.handleSave}>Save</button>
          <button className="btn btn-link" onClick={this.handleCancel}>Cancel</button>
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
    <div style={{fontSize: "1.5em"}}>
      <strong>Name</strong>: {props.name}
      {' '}<i className="fa fa-arrow-circle-o-right"></i>{' '}
      <strong>Workflow</strong>: {name}
      {' '}<i className="fa fa-minus-circle" onClick={props.onClick}></i>
    </div>
  )
}

module.exports = Option

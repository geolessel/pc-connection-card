import React from "react"
import Option from "web/static/js/components/option"
import { saveDefaultWorkflow } from "web/static/js/actions/setting"
const { array, string } = React.PropTypes

const DefaultWorkflow = React.createClass({
  propTypes: {
    workflows: array.isRequired,
    default_workflow_id: string.isRequired
  },

  getInitialState() {
    return {options: []}
  },

  render() {
    const options = this.props.workflows.map(w => <option key={w.id} value={w.id}>{w.name}</option>)
    return (
      <div>
        <select name="setting[default_workflow_id]" defaultValue={this.props.default_workflow_id} className="select" onChange={this.handleChange}>
          {options}
        </select>
      </div>
    )
  },

  handleChange(e) {
    saveDefaultWorkflow(e.target.value)
  }
})

module.exports = DefaultWorkflow

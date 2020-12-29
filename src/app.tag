<app>

  <section class="todoapp">

    <header class="header">
      <h1>todos</h1>
      <input
        class="new-todo"
        name="newTodo"
        data-path="{ schema.todos.newTodo.path }"
        placeholder="What needs to be done?"
        value="{ data.newTodo }"
        autofocus
      >
    </header>

    <section if={ data.allNo > 0 } class="main">

      <input
        data-path="{ schema.todos.toggleAll.path }"
        class="toggle-all"
        type="checkbox"
        checked={ data.activeNo === 0 }
      >
      <label for="toggle-all">Mark all as complete</label>

      <ul class="todo-list">

        <li
          each={ todo in data.todos }
          data-path="{ schema.todos.edit.path }"
          data-value="{ todo.id }"
          class={ todo.editing ? 'editing' : (todo.completed ? 'completed' : '') }
        >
          <div class="view">
            <input
              data-path="{ schema.todos.toggle.path }"
              data-value="{ todo.id }"
              class="toggle"
              type="checkbox"
              checked={ todo.completed }
            >
            <label>{ todo.title }</label>
            <button
              class="destroy"
              data-path="{ schema.todos.destroy.path }"
              data-value="{ todo.id }"
            ></button>
          </div>
          <input
            class="edit"
            data-path="{ schema.todos.newTitle.path }"
            value="{ todo.title }"
          >
        </li>

      </ul>

    </section>

    <footer if={ data.allNo > 0 } class="footer">

      <span class="todo-count">
        <strong>{ data.activeNo }</strong> item left
      </span>

      <ul class="filters">
        <li>
          <a
            class={ data.filter === 'all' ? 'selected' : '' }
            href="#/"
            data-path="{ schema.todos.filter.path }"
            data-value="all"
          >All</a>
        </li>
        <li>
          <a
            class={ data.filter === 'active' ? 'selected' : '' }
            href="#/active"
            data-path="{ schema.todos.filter.path }"
            data-value="active"
          >Active</a>
        </li>
        <li>
          <a
            class={ data.filter === 'completed' ? 'selected' : '' }
            href="#/completed"
            data-path="{ schema.todos.filter.path }"
            data-value="completed"
          >Completed</a>
        </li>
      </ul>

      <button
        if={ data.completedNo !== 0 }
        data-path="{ schema.todos.clearCompleted.path }"
        class="clear-completed"
      >Clear completed</button>

    </footer>

  </section>

  <script>
    export default {
      onBeforeMount() {
        this.schema = require('../lib/uiSchema.js').default
        let state = require('../lib/state.js').default
        state.data(this, {
          newTodo: '/ui/todos/data/newTodo/value',
          editing: '/todos/editing/id',
          allNo: ['/todos/all', length],
          activeNo: ['/todos/active', length],
          completedNo: ['/todos/completed', length],
          todos: '/ui/todos/filtered',
          filter: '/ui/todos/data/filter/value',
          toggleAll: '/ui/todos/data/toggleAll/value'
        })
      }
    }
  </script>

</app>

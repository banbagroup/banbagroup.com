---
layout: post
title:  "Vue JS Best Practices"
date:   "2019-04-19 08:11:55.536939"
categories: blog
excerpt: "An overview of some of the best practices we've applied to our projects at Banba Group. "
---
<div><strong>Naming Conventions</strong><br>Always Use Multi-Word<br>Use PascalCase or kebab-case for single file components<br>Use prefix for Base Component names&nbsp; (e.g.: BaseTable or AppTable<br>Use The for Single Instance Component names&nbsp; (e.g.: TheHeader or TheSidebar)<br>Use parent component name as prefix for tightly coupled child components<br><br></div><pre>components/
  | - TodoList.vue
  | - TodoListItem.vue
  | - TodoListItemButton.vue</pre><div><br><br>Props should always use camelCase during declaration, but kebab-case in templates and JSX</div><pre>props: {
  greetingText: String
}
&lt;WelcomeMessage greeting-text="hi"/&gt;
<br></pre><div><br><strong>Best Practices.</strong><br>Component data must be a function</div><pre>// Bad
export default {
  data: {
    foo: 'bar'  
  }
}

//Good
export default {
  data () {
    return {
      foo: 'bar'
    }
  }
}</pre><div><br>Prop definitions should be as detailed as possible.</div><pre>// This is only OK when prototyping
props: ['status']

//Good
props: {
  status: String
}</pre><div><br><br></div><div>Always use key with v-for</div><pre>&lt;ul&gt;
  &lt;li
    v-for="todo in todos"
    :key="todo.id"
  &gt;
    {{ todo.text }}
  &lt;/li&gt;
&lt;/ul&gt;</pre><div><br><br>Never use v-if on the same element as v-for.</div><pre>// Bad
&lt;ul&gt;
  &lt;li
    v-for="user in users"
    v-if="user.isActive"
    :key="user.id"
  &gt;
    {{ user.name }}
  &lt;/li&gt;
&lt;/ul&gt;
// Good
&lt;ul&gt;
  &lt;li
    v-for="user in activeUsers"
    :key="user.id"
  &gt;
    {{ user.name }}
  &gt;&lt;/li&gt;
&lt;/ul&gt;</pre><div><br>Directive shorthands&nbsp; (: for v-bind: and @ for v-on:)&nbsp; should be used always or never.</div><pre>// Bad
&lt;input
  v-bind:value="newTodoText"
  :placeholder="newTodoInstructions"
&gt;

// Good
&lt;input
  :value="newTodoText"
  :placeholder="newTodoInstructions"
&gt;

// Also Good
&lt;input
  v-bind:value="newTodoText"
  v-bind:placeholder="newTodoInstructions"
&gt;</pre>
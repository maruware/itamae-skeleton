execute "Hello, node['hello']['to']!" do
  command "echo \"Hello, #{node['hello']['to']}!\""
end
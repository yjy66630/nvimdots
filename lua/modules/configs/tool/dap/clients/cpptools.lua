-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
return function()
	local dap = require("dap")
	local utils = require("modules.utils.dap")
	local is_windows = require("core.global").is_windows

	-- dap.adapters.cppdbg = {
	-- 	type = "server",
	-- 	port = "${port}",
	-- 	executable = {
	-- 		-- command = vim.fn.exepath("OpenDebugAD7"), -- Find cppdbg on $PATH
	-- 		miDebuggerPath = '/usr/bin/gdb', -- Find cppdbg on $PATH
	-- 		args = { "--port", "${port}" },
	-- 		detached = is_windows and false or true,
	-- 	},
	-- }

	local dap = require('dap')
	dap.adapters.cppdbg = {
	  id = 'cppdbg',
	  type = 'executable',
	  command = vim.fn.exepath("OpenDebugAD7"),
	}

	local dap = require('dap')
	dap.configurations.c = {
	  {
	    name = "Launch file",
	    type = "cppdbg",
	    request = "launch",
	    program = utils.input_exec_path(),
	    cwd = '${workspaceFolder}',
	    stopAtEntry = true,
	    setupCommands = {
	        {
	            text = '-enable-pretty-printing',
	            description =  'enable pretty printing',
	            ignoreFailures = false
	        },
	        {
	            text = 'set follow-fork-mode parent',
	            description =  'follow parent process',
	            ignoreFailures = false
	        },
	        {
	            text = 'set detach-on-fork off',
	            description =  'disable detach on fork',
	            ignoreFailures = false
	        },
	    },
	  },
	  {
	    name = 'Attach to gdbserver :1234',
	    type = 'cppdbg',
	    request = 'launch',
	    MIMode = 'gdb',
	    miDebuggerServerAddress = 'localhost:1234',
	    miDebuggerPath = '/usr/bin/gdb',
	    cwd = '${workspaceFolder}',
	    program = utils.input_exec_path(),
	    setupCommands = {
	        {
	            text = '-enable-pretty-printing',
	            description =  'enable pretty printing',
	            ignoreFailures = false
	        },
	        {
	            text = 'set follow-fork-mode parent',
	            description =  'follow parent process',
	            ignoreFailures = false
	        },
	        {
	            text = 'set detach-on-fork off',
	            description =  'disable detach on fork',
	            ignoreFailures = false
	        },
	    },
	  },
	}

	


	-- dap.configurations.c = {
	-- 	{
	-- 		name = "Debug",
	-- 		type = "cppdbg",
	-- 		request = "launch",
	-- 		program = utils.input_exec_path(),
	-- 		cwd = "${workspaceFolder}",
	-- 		-- miDebuggerPath = vim.fn.exepath("OpenDebugAD7"),
	-- 		miDebuggerPath = '/usr/bin/gdb',
	-- 		setupCommands = {  
	-- 		  { 
	-- 		     text = '-enable-pretty-printing',
	-- 		     description =  'enable pretty printing',
	-- 		     ignoreFailures = false 
	-- 		  },
	-- 		},
	-- 		stopOnEntry = false,
	-- 		terminal = "integrated",
	-- 	},
	-- 	{
	-- 		name = "Debug (with args)",
	-- 		type = "cppdbg",
	-- 		request = "launch",
	-- 		program = utils.input_exec_path(),
	-- 		args = utils.input_args(),
	-- 		cwd = "${workspaceFolder}",
	-- 		-- miDebuggerPath = vim.fn.exepath("OpenDebugAD7"),
			
	-- 		miDebuggerPath = '/usr/bin/gdb',

	-- 		setupCommands = {  
	-- 		  { 
	-- 		     text = '-enable-pretty-printing',
	-- 		     description =  'enable pretty printing',
	-- 		     ignoreFailures = false 
	-- 		  },
	-- 		},
	-- 		stopOnEntry = false,
	-- 		terminal = "integrated",
	-- 	},
	-- 	{
	-- 		name = "Attach to a running process",
	-- 		type = "cppdbg",
	-- 		request = "attach",
	-- 		program = utils.input_exec_path(),
	-- 		setupCommands = {  
	-- 		  { 
	-- 		     text = '-enable-pretty-printing',
	-- 		     description =  'enable pretty printing',
	-- 		     ignoreFailures = false 
	-- 		  },
	-- 		},
	-- 		stopOnEntry = false,
	-- 		waitFor = true,
	-- 	},
	-- }
	dap.configurations.cpp = dap.configurations.c
	dap.configurations.rust = dap.configurations.c
end

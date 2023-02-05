"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[919],{91465:e=>{e.exports=JSON.parse('{"functions":[{"name":"fromValue","desc":"Retrieves a new value (class) from the server and returns a RepliClient","params":[{"name":"class","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"RepliClient"}],"function_type":"static","source":{"line":72,"path":"src/shared/Repli/RepliClient.lua"}},{"name":"isReady","desc":"Returns true if the client is ready to receive data","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","source":{"line":112,"path":"src/shared/Repli/RepliClient.lua"}},{"name":"onReady","desc":"Returns a promise that resolves when the client is ready","params":[],"returns":[{"desc":"","lua_type":"Promise<any>"}],"function_type":"method","source":{"line":121,"path":"src/shared/Repli/RepliClient.lua"}},{"name":"subscribe","desc":"Subscribes to changes","params":[{"name":"callback","desc":"","lua_type":"function"}],"returns":[{"desc":"","lua_type":"RBXScriptConnection"}],"function_type":"method","source":{"line":143,"path":"src/shared/Repli/RepliClient.lua"}},{"name":"get","desc":"Returns the current value\\n\\n:::caution\\nThis will return nil if the client is not ready\\n:::","params":[],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","source":{"line":163,"path":"src/shared/Repli/RepliClient.lua"}}],"properties":[{"name":"isReady","desc":"Whether or not the client is ready to receive data","lua_type":"boolean","source":{"line":12,"path":"src/shared/Repli/RepliClient.lua"}},{"name":"value","desc":"The current value of the class","lua_type":"any","source":{"line":18,"path":"src/shared/Repli/RepliClient.lua"}}],"types":[],"name":"RepliClient","desc":"","source":{"line":21,"path":"src/shared/Repli/RepliClient.lua"}}')}}]);
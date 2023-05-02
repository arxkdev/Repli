"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[556],{3905:(e,t,n)=>{n.d(t,{Zo:()=>c,kt:()=>k});var l=n(67294);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function r(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var l=Object.getOwnPropertySymbols(e);t&&(l=l.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,l)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?r(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):r(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function o(e,t){if(null==e)return{};var n,l,a=function(e,t){if(null==e)return{};var n,l,a={},r=Object.keys(e);for(l=0;l<r.length;l++)n=r[l],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(l=0;l<r.length;l++)n=r[l],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var u=l.createContext({}),p=function(e){var t=l.useContext(u),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},c=function(e){var t=p(e.components);return l.createElement(u.Provider,{value:t},e.children)},s="mdxType",d={inlineCode:"code",wrapper:function(e){var t=e.children;return l.createElement(l.Fragment,{},t)}},m=l.forwardRef((function(e,t){var n=e.components,a=e.mdxType,r=e.originalType,u=e.parentName,c=o(e,["components","mdxType","originalType","parentName"]),s=p(n),m=a,k=s["".concat(u,".").concat(m)]||s[m]||d[m]||r;return n?l.createElement(k,i(i({ref:t},c),{},{components:n})):l.createElement(k,i({ref:t},c))}));function k(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var r=n.length,i=new Array(r);i[0]=m;var o={};for(var u in t)hasOwnProperty.call(t,u)&&(o[u]=t[u]);o.originalType=e,o[s]="string"==typeof e?e:a,i[1]=o;for(var p=2;p<r;p++)i[p]=n[p];return l.createElement.apply(null,i)}return l.createElement.apply(null,n)}m.displayName="MDXCreateElement"},26437:(e,t,n)=>{n.r(t),n.d(t,{contentTitle:()=>i,default:()=>s,frontMatter:()=>r,metadata:()=>o,toc:()=>u});var l=n(87462),a=(n(67294),n(3905));const r={},i=void 0,o={type:"mdx",permalink:"/Repli/CHANGELOG",source:"@site/pages/CHANGELOG.md",description:"0.0.1-alpha",frontMatter:{}},u=[{value:"0.0.1-alpha",id:"001-alpha",level:2},{value:"0.0.2-alpha",id:"002-alpha",level:2},{value:"0.0.3-alpha",id:"003-alpha",level:2}],p={toc:u},c="wrapper";function s(e){let{components:t,...n}=e;return(0,a.kt)(c,(0,l.Z)({},p,n,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h2",{id:"001-alpha"},"0.0.1-alpha"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Initial release")),(0,a.kt)("h2",{id:"002-alpha"},"0.0.2-alpha"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Added support for (filter functions, clear functions):")),(0,a.kt)("hr",null),(0,a.kt)("p",null,"Clearing:"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("inlineCode",{parentName:"li"},"clearValue")),(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("inlineCode",{parentName:"li"},"clearValueFilter")),(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("inlineCode",{parentName:"li"},"clearValueForClient")),(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("inlineCode",{parentName:"li"},"clearValueForList"))),(0,a.kt)("hr",null),(0,a.kt)("p",null,"Filtering:"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("inlineCode",{parentName:"li"},"setValueFilter"))),(0,a.kt)("hr",null),(0,a.kt)("p",null,"Update functions:"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("inlineCode",{parentName:"li"},"updateValue")),(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("inlineCode",{parentName:"li"},"updateValueForClient")),(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("inlineCode",{parentName:"li"},"updateValueForList"))),(0,a.kt)("hr",null),(0,a.kt)("p",null,"Misc:"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("inlineCode",{parentName:"li"},"subscribe")," - This is a new function that is similar to the client subscribe function, but it allows you to subscribe on the server aswell."),(0,a.kt)("li",{parentName:"ul"},"Added more examples in the code (not yet in the documentation)"),(0,a.kt)("li",{parentName:"ul"},"Minor bug fixes."),(0,a.kt)("li",{parentName:"ul"},"Added examples on how to use each function.")),(0,a.kt)("h2",{id:"003-alpha"},"0.0.3-alpha"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Added new way for retrieving data on the client."),(0,a.kt)("li",{parentName:"ul"},"Introducing: ",(0,a.kt)("inlineCode",{parentName:"li"},"listenForCreation"),". You can provide it a class name and callback and it'll give you the classObject that you can attach to using methods like ",(0,a.kt)("inlineCode",{parentName:"li"},"getValue")," and ",(0,a.kt)("inlineCode",{parentName:"li"},"subscribe"),"."),(0,a.kt)("li",{parentName:"ul"},"Quick Example:")),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-lua"},'Repli.listenForCreation("TestValue", function(testValue)\n    -- Gett the initial value\n    local initialValue = testValue:getValue();\n\n    -- Listen for further changes\n    testValue:subscribe(function(newValue)\n        print(newValue);\n    end);\nend);\n')))}s.isMDXComponent=!0}}]);
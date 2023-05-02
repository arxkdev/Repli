"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[454],{3905:(e,a,t)=>{t.d(a,{Zo:()=>c,kt:()=>d});var r=t(67294);function l(e,a,t){return a in e?Object.defineProperty(e,a,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[a]=t,e}function n(e,a){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);a&&(r=r.filter((function(a){return Object.getOwnPropertyDescriptor(e,a).enumerable}))),t.push.apply(t,r)}return t}function i(e){for(var a=1;a<arguments.length;a++){var t=null!=arguments[a]?arguments[a]:{};a%2?n(Object(t),!0).forEach((function(a){l(e,a,t[a])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):n(Object(t)).forEach((function(a){Object.defineProperty(e,a,Object.getOwnPropertyDescriptor(t,a))}))}return e}function o(e,a){if(null==e)return{};var t,r,l=function(e,a){if(null==e)return{};var t,r,l={},n=Object.keys(e);for(r=0;r<n.length;r++)t=n[r],a.indexOf(t)>=0||(l[t]=e[t]);return l}(e,a);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);for(r=0;r<n.length;r++)t=n[r],a.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(l[t]=e[t])}return l}var u=r.createContext({}),s=function(e){var a=r.useContext(u),t=a;return e&&(t="function"==typeof e?e(a):i(i({},a),e)),t},c=function(e){var a=s(e.components);return r.createElement(u.Provider,{value:a},e.children)},p="mdxType",f={inlineCode:"code",wrapper:function(e){var a=e.children;return r.createElement(r.Fragment,{},a)}},m=r.forwardRef((function(e,a){var t=e.components,l=e.mdxType,n=e.originalType,u=e.parentName,c=o(e,["components","mdxType","originalType","parentName"]),p=s(t),m=l,d=p["".concat(u,".").concat(m)]||p[m]||f[m]||n;return t?r.createElement(d,i(i({ref:a},c),{},{components:t})):r.createElement(d,i({ref:a},c))}));function d(e,a){var t=arguments,l=a&&a.mdxType;if("string"==typeof e||l){var n=t.length,i=new Array(n);i[0]=m;var o={};for(var u in a)hasOwnProperty.call(a,u)&&(o[u]=a[u]);o.originalType=e,o[p]="string"==typeof e?e:l,i[1]=o;for(var s=2;s<n;s++)i[s]=t[s];return r.createElement.apply(null,i)}return r.createElement.apply(null,t)}m.displayName="MDXCreateElement"},37962:(e,a,t)=>{t.r(a),t.d(a,{assets:()=>u,contentTitle:()=>i,default:()=>f,frontMatter:()=>n,metadata:()=>o,toc:()=>s});var r=t(87462),l=(t(67294),t(3905));const n={sidebar_position:4},i="More Examples",o={unversionedId:"moreexamples",id:"moreexamples",title:"More Examples",description:"Here are some examples that include more advanced features of the library.",source:"@site/docs/moreexamples.md",sourceDirName:".",slug:"/moreexamples",permalink:"/Repli/docs/moreexamples",draft:!1,editUrl:"https://github.com/Kumarion/Repli/edit/main/docs/moreexamples.md",tags:[],version:"current",sidebarPosition:4,frontMatter:{sidebar_position:4},sidebar:"defaultSidebar",previous:{title:"Examples",permalink:"/Repli/docs/examples"}},u={},s=[{value:"Clearing Values",id:"clearing-values",level:2},{value:"Clearing Values for a Client",id:"clearing-values-for-a-client",level:2},{value:"Clearing Values for a List",id:"clearing-values-for-a-list",level:2},{value:"Setting Values for a List",id:"setting-values-for-a-list",level:2}],c={toc:s},p="wrapper";function f(e){let{components:a,...t}=e;return(0,l.kt)(p,(0,r.Z)({},c,t,{components:a,mdxType:"MDXLayout"}),(0,l.kt)("h1",{id:"more-examples"},"More Examples"),(0,l.kt)("p",null,"Here are some examples that include more advanced features of the library.\nSuch as using the ",(0,l.kt)("inlineCode",{parentName:"p"},"clearValue"),", ",(0,l.kt)("inlineCode",{parentName:"p"},"clearValueForClient"),", ",(0,l.kt)("inlineCode",{parentName:"p"},"clearValueForList")," and ",(0,l.kt)("inlineCode",{parentName:"p"},"setValueForList"),"."),(0,l.kt)("h2",{id:"clearing-values"},"Clearing Values"),(0,l.kt)("p",null,"The ",(0,l.kt)("inlineCode",{parentName:"p"},"clearValue")," function is used to clear the value of a field."),(0,l.kt)("pre",null,(0,l.kt)("code",{parentName:"pre",className:"language-lua"},'-- Create a value\nlocal Value = Repli.createValue("TestValue", 0);\n\n-- Set the value to 10\nValue:setValue(10);\n\n-- Clear the value\nValue:clearValue();\n')),(0,l.kt)("h2",{id:"clearing-values-for-a-client"},"Clearing Values for a Client"),(0,l.kt)("p",null,"The ",(0,l.kt)("inlineCode",{parentName:"p"},"clearValueForClient")," function is used to clear the value of a field for a specific client."),(0,l.kt)("pre",null,(0,l.kt)("code",{parentName:"pre",className:"language-lua"},'-- Create a value\nlocal Value = Repli.createValue("TestValue", 0);\n\n-- Set the value to 10\nValue:setValueForClient(player, 10);\n\n-- Clear the value\nValue:clearValueForClient(player);\n')),(0,l.kt)("h2",{id:"clearing-values-for-a-list"},"Clearing Values for a List"),(0,l.kt)("p",null,"The ",(0,l.kt)("inlineCode",{parentName:"p"},"clearValueForList")," function is used to clear the value of a field for a specific list."),(0,l.kt)("pre",null,(0,l.kt)("code",{parentName:"pre",className:"language-lua"},'-- Create a value\nlocal Value = Repli.createValue("TestValue", 0);\n\n-- Set the value to 10\nValue:setValueForList({player1, player2}, 10);\n\n-- Clear the value\nValue:clearValueForList({player1, player2});\n')),(0,l.kt)("h2",{id:"setting-values-for-a-list"},"Setting Values for a List"),(0,l.kt)("p",null,"The ",(0,l.kt)("inlineCode",{parentName:"p"},"setValueForList")," function is used to set the value of a field for a specific list."),(0,l.kt)("pre",null,(0,l.kt)("code",{parentName:"pre",className:"language-lua"},'-- Create a value\nlocal Value = Repli.createValue("TestValue", 0);\n\n-- Set the value to 10\nValue:setValueForList({player1, player2}, 10);\n')))}f.isMDXComponent=!0}}]);
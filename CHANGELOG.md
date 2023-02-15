## 0.0.1-alpha
- Initial release

## 0.0.2-alpha
- Added support for (filter functions, clear functions):
---
Clearing:
- ``clearValue``
- ``clearValueFilter``
- ``clearValueForClient``
- ``clearValueForList``
---
Filtering:
- ``setValueFilter``
---
Update functions:
- ``updateValue``
- ``updateValueForClient``
- ``updateValueForList``
---
Misc:
- ``subscribe`` - This is a new function that is similar to the client subscribe function, but it allows you to subscribe on the server aswell.
- Added more examples in the code (not yet in the documentation)
- Minor bug fixes.
- Added examples on how to use each function.

## 0.0.3-alpha
- Added new way for retrieving data on the client.
- Introducing: ``listenForCreation``. You can provide it a class name and callback and it'll give you the classObject that you can attach to using methods like ``getValue`` and ``subscribe``.
- Quick Example:
```lua
Repli.listenForCreation("TestValue", function(testValue)
    -- Gett the initial value
    local initialValue = testValue:getValue();

    -- Listen for further changes
    testValue:subscribe(function(newValue)
        print(newValue);
    end);
end);
```
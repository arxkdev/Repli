---
sidebar_position: 4
---

# More Examples
Here are some examples that include more advanced features of the library.
Such as using the ``clearValue``, ``clearValueForClient``, ``clearValueForList`` and ``setValueForList``.

## Clearing Values
The ``clearValue`` function is used to clear the value of a field.
```lua
-- Create a value
local Value = Repli.createValue("TestValue", 0);

-- Set the value to 10
Value:setValue(10);

-- Clear the value
Value:clearValue();
```

## Clearing Values for a Client
The ``clearValueForClient`` function is used to clear the value of a field for a specific client.
```lua
-- Create a value
local Value = Repli.createValue("TestValue", 0);

-- Set the value to 10
Value:setValueForClient(player, 10);

-- Clear the value
Value:clearValueForClient(player);
```

## Clearing Values for a List
The ``clearValueForList`` function is used to clear the value of a field for a specific list.
```lua
-- Create a value
local Value = Repli.createValue("TestValue", 0);

-- Set the value to 10
Value:setValueForList({player1, player2}, 10);

-- Clear the value
Value:clearValueForList({player1, player2});
```

## Setting Values for a List
The ``setValueForList`` function is used to set the value of a field for a specific list.
```lua
-- Create a value
local Value = Repli.createValue("TestValue", 0);

-- Set the value to 10
Value:setValueForList({player1, player2}, 10);
```
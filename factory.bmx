SuperStrict

Rem
	bbdoc: htbaapub.factory
EndRem
Module htbaapub.factory
ModuleInfo "Name: htbaapub.factory"
ModuleInfo "Version: 1.00"
ModuleInfo "Author: Christiaan Kras"
ModuleInfo "Git repository: <a href='http://github.com/Htbaa/factory.mod/'>http://github.com/Htbaa/factory.mod/</a>"

Import brl.map
Import brl.retro

Rem
	bbdoc: Function callback
End Rem
Type TFunc
	'Function pointer
	Field func:Object(data:Object)

	Rem
		bbdoc: Function to create TFunc object
	End Rem
	Function Create:TFunc(func:Object(data:Object))
		Local obj:TFunc = New TFunc
		'Assign function
		obj.func = func
		Return obj
	End Function
End Type

Rem
	bbdoc: Type that implements the Factory Design Pattern
End Rem
Type TFactory
	'Map with all the constructors
	Field products:TMap = New TMap

	Rem
		bbdoc: Register a function callback
	End Rem
	Method Register(key:String, func:TFunc)
		Self.products.Insert(key, func)
	End Method
	
	Rem
		bbdoc: Reset registered callbacks
	End Rem
	Method Reset()
		Self.products.Clear()
	End Method
	
	Rem
		bbdoc: Create an object from the requested key
	End Rem
	Method Create:Object(key:String, data:Object = Null)
		'Check if the key is known
		If Not Self.products.Contains(key)
			Throw "Product " + key + " isn't registered with TFactory!"
		End If
	
		'Retrieve TFunc
		Local f:TFunc = TFunc(Self.products.ValueForKey(key))
		'Execute method with given data
		Return f.func(data)
	End Method
End Type

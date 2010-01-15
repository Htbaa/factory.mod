Rem
	Copyright (c) 2010 Christiaan Kras
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
End Rem

SuperStrict

Rem
	bbdoc: htbaapub.factory
EndRem
Module htbaapub.factory
ModuleInfo "Name: htbaapub.factory"
ModuleInfo "Version: 1.01"
ModuleInfo "License: MIT"
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

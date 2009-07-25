SuperStrict
Rem
	This example shows you how to setup a factory and let it create 3 different objects.
	Although in the example they're all derived types of TAnimal you can ofcourse use any
	and lots of different types. The only requirement for a type to be able to register it
	with the factory is that it requires a creation function with the signature:
		<FunctionName>:Object(data:Object)
	The data:Object parameter can be optional data you may want to pass to your object constructor.
End Rem


Import htbaapub.factory

'Create our new factory
Local factory:TFactory = New TFactory
'Register the types we want to create with the factory
factory.Register("cat", TFunc.Create(TCat.FactoryFunc))
factory.Register("dog", TFunc.Create(TDog.FactoryFunc))
factory.Register("parrot", TFunc.Create(TParrot.FactoryFunc))

'Now lets create a couple of animals!
Local animal1:TAnimal = TAnimal(factory.Create("cat", "*couch* hairball *couch*"))
Local animal2:TAnimal = TAnimal(factory.Create("dog"))
Local animal3:TAnimal = TAnimal(factory.Create("parrot"))

'Now lets hear what they've got to say!
animal1.Say() 'This should be a cat!
animal2.Say() 'This should be a dog!
animal3.Say() 'This should be a parrot!

'----------------------------------------------------------------

'Abstract base class
Type TAnimal Abstract
	Method Create:Object(data:Object)
		Return Self
	End Method
	
	Method Say() Abstract
End Type

'A cat
Type TCat Extends TAnimal
	Field extra:String

	'Lets overide the Create() method so we can use the data passed to it from the FactoryFunc function	
	Method Create:Object(data:Object)
		Self.extra = String(data)
		Return Self
	End Method

	Method Say()
		Print Self.extra + "Miauw!"
	End Method

	Function FactoryFunc:Object(data:Object)
		Return TCat(New TCat.Create(data))
	End Function
End Type

'A dog
Type TDog Extends TAnimal
	Method Say()
		Print "Woof!"
	End Method

	Function FactoryFunc:Object(data:Object)
		Return New TDog
	End Function
End Type

'A rather smart parrot
Type TParrot Extends TAnimal
	Method Say()
		Print "Good day to you sir! What? You already said that?"
	End Method

	Function FactoryFunc:Object(data:Object)
		Return New TParrot
	End Function
End Type

---
title: Real World Ocaml (第2版) 读书笔记 (1-3章)
date: 2024-11-08 18:29:20
tags:
    - 计算机
    - 函数式编程
---



# Book Reading Report: *Real World OCaml* (2nd Edition) (Chapter 1-3)

## Summary of Key Chapters

### Chapter 1: A Guided Tour

> REPL stands for Read, Evaluate, Print, and Loop,it is usually a environment where you can type in your code and get quick result

All the operation now are done in `utop` (fancier REPL of ocaml) or the REPL of `ocaml`

This chapter covers the basics of OCaml, such as the most basic operator

```ocaml
# 3 + 4;;
- : int = 7
# 8 / 3;;
- : int = 2
# 3.5 +. 6.;;
- : float = 9.5
# 30_000_000 / 300_000;;
- : int = 100
# 3 * 5 > 14;;
- : bool = true
```

Also introduces the most basic let-binding technique,which is essential for value-binding and function definition.

```ocaml
# let x = 3 + 4;; (*Value Binding*)
val x : int = 7
# let y = x + x;;
val y : int = 14
# let square x = x * x;; (*Function Definition*)
val square : int -> int = <fun>
# square 2;;
- : int = 4
# square (square 2);;
- : int = 16
```

Also it introduces the if statement.

```ocaml
# let sum_if_true test first second =
(if test first then first else 0)
+ (if test second then second else 0);;
val sum_if_true : (int -> bool) -> int -> int -> int = <fun>
```

> **Warning**: `==` in ocaml means that two things are **Physical equal**,if you want to use structural equal or inequal please use `=` for equal and `<>` for inequal

Type inference and generic types are also important in Ocaml because this impoves the experience and overall type system.

```ocaml
(*This is a function with full type notation*)
(*But we can skip it because of type inference*)
# let sum_if_true (test : int -> bool) (x : int) (y : int) : int =
(if test x then x else 0)
+ (if test y then y else 0);;
val sum_if_true : (int -> bool) -> int -> int -> int = <fun>

# let sum_if_true (test : int -> bool) (x : int) (y : int) : int =
(if test x then x else 0)
+ (if test y then y else 0);;
val sum_if_true : (int -> bool) -> int -> int -> int = <fun>
```

Then it introduces some useful data structure that are essential in development such as

- Tuples

- Lists

- Options

- Record

- Variants

- Arrays

- Mutable Record Fields

- Refs

For basic loops conditioning ocaml supports `for` and `while`

```ocaml
(*While loop*)
# let find_first_negative_entry array =
let pos = ref 0 in
while !pos < Array.length array && array.(!pos) >= 0 do
pos := !pos + 1
done;
if !pos = Array.length array then None else Some !pos;;
val find_first_negative_entry : int array -> int option = <fun>
# find_first_negative_entry [|1;2;0;3|];;
- : int option = None
# find_first_negative_entry [|1;-2;0;3|];;
- : int option = Some 1


(*For loops*)
# let permute array =
let length = Array.length array in
for i = 0 to length - 2 do
(* pick a j to swap with *)
let j = i + Random.int (length - i) in
(* Swap i and j *)
let tmp = array.(i) in
array.(i) <- array.(j);
array.(j) <- tmp
done;;
val permute : 'a array -> unit = <fun>
```

### Chapter 2: Variables and Functions

Explains how to declare variables and functions in OCaml. Introduces the concept of immutability in OCaml variables.

Anonymous Functions is an important concept introduced in this chapter.it starts with The [lambda calculus](https://en.wikipedia.org/wiki/Lambda_calculus "Lambda calculus"), developed in the 1930s by [Alonzo Church](https://en.wikipedia.org/wiki/Alonzo_Church),it is defined like this in ocaml

```ocaml
# (fun x -> x + 1);;
- : int -> int = <fun>
```

It can be used just as a normal function,you can apply it with value or pass it to other functions.

Also,the chapter introduces currying and uncurrying.

```ocaml
let abs_diff x y = abs (x - y);;
(*Is equalivent to*)

let abs_diff =
(fun x -> (fun y -> abs (x - y)));; 
(*actually only one argument with param list*)
```

The key to interpreting the type signature of a curried function is the
observation that -> is right-associative

so

```ocaml
int -> int -> int
after curried can be
(int -> int) -> int
```

Also,ocaml introduces labeled arguments and optional arguments

label funtions can be passed with labels without caring of the order of the arguments,It does matter in a higher-order context,
e.g., when passing a function with labeled arguments to another function

optional arguments can be marked by using `?` in front of the name of the arguments,also you can provide a defualt value for optional arguments e.g `?(s="")`

### Chapter 3: Lists and Patterns

An OCaml list is an immutable, finite sequence of elements of the same type,and it can be expressed using a bracket-and-semicolon notation.

Also we can use `::` notation,which has the same meaning but more oftenly used in pattern matching.

```ocaml
# [1;2;3];;
- : int list = [1; 2; 3]
# 1 :: (2 :: (3 :: []));;
- : int list = [1; 2; 3]
# 1 :: 2 :: 3 :: [];;
- : int list = [1; 2; 3]
```

In ocaml,the empty list `[]` is used to terminate a list,and `[]` can be a list of any type and can be combined with a list of any type.

we can extract data out of list using pattern matching in match guards in ocaml,such as

```ocaml
let rec sum l =
match l with
| [] -> 0
| hd :: tl -> hd + sum tl;;
```

pattern matching is very efficent,but we need to consider the shaowding binding problem and exsaustive binding problem,we need to cover all the possible case in pattern matching.

There are some useful functions to play with lists in the standard library `Base`

```ocaml
# List.reduce ~f:(+) [1;2;3;4;5];;
- : int option = Some 15
# List.filter ~f:(fun x -> x % 2 = 0) [1;2;3;4;5];;
- : int list = [2; 4]
filter_map : ('a -> 'b option) -> 'a list -> 'b list
# List.append [1;2;3] [4;5;6];;
- : int list = [1; 2; 3; 4; 5; 6]
(*You can also use @ like [1;2;3] @ [4;5;6];;*)
# List.concat [[1;2];[3;4;5];[6];[]];;
- : int list = [1; 2; 3; 4; 5; 6]
(*You can use list.concat to link list of lists*)
```

This chapter also mentions tail recursion optmization,which is also an important technique in practice.

Considering this function

```ocaml
# let rec length = function
| [] -> 0
| _ :: tl -> 1 + length tl;;
```

it's great,but when the lists are too long (more than 100000 elements),it produces a stackoverflow exception,why?

To understand where the error in the above example comes from, you need to learn a
bit more about how function calls work. Typically, a function call needs some space to
keep track of information associated with the call, such as the arguments passed to the
function, or the location of the code that needs to start executing when the function call
is complete. To allow for nested function calls, this information is typically organized
in a stack, where a new
 stack frame is allocated for each nested function call, and then
deallocated when the function call is complete.

So how can we solve this problem with only a few stack frame used?The answer is having a variable or a ref when doing recusion.

```ocaml
# let rec length_plus_n l n =
match l with
| [] -> n
| _ :: tl -> length_plus_n tl (n + 1);;
# let length l = length_plus_n l 0;;
# length (make_list 10_000_000);;
- : int = 10000000
```

Also,there's a common case for match xxx with ... in ocaml,so there's a sugar `function` for it.

`function` also defines a function but **it only takes one param** and it is nameless.

so we can write the original `length` function like this

```ocaml
# let rec length = function
| [] -> 0
| _ :: tl -> 1 + length tl;;
val length : 'a list -> int = <fun>
```

The optmization for recursive function and pattern matching are important,we should

- Avoid using too much stack frame

- Remove duplicate pattern which can cause reallocation

- Make a good use of grammaratical sugar

## Conclusion

The previous three chapters give us a brief overall introduction to the ocaml and functional programming.

Also it introduces the detail of the basic ocaml grammar and commonly used data structures.

---
title: Real World Ocaml (第2版) 读书笔记 (1-3章) [施工中]
date: 2024-11-08 18:29:20
tags:
    - 计算机
    - 函数式编程
---

学校作业哈,上传到这里防止自己忘了

# Book Reading Report: *Real World OCaml* (2nd Edition) (Chapter 1-3)

## Summary of Key Chapters

### Chapter 1: A Guided Tour

All the operation now are done in `utop` or the REPL of `ocaml`

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

# TODO

### Chapter 3: Data Structures

Covers common data structures in OCaml, such as **lists, tuples, arrays**, and **records**. Discusses how these data structures are used in functional programming.

# TODO

## Conclusion

Concluding thoughts on continuing with the book, such as motivation to finish and specific topics of interest in upcoming chapters.

# Task 4 - Binary Tree (25p)

The purpose of this task is to familiarize you with function calls and recursion in assembly language.

---

In this task you will work with a binary tree, whose
nodes have the following structure:
c
struct node {
     int value;
     struct node *left;
     struct node *right;
} __attribute__((packed));
```
---
---
## Exercise I
The first exercise consists of traversing a binary tree
of searching in [_inorder_](https://www.geeksforgeeks.org/tree-traversals-inorder-preorder-and-postorder/) and storing the values from the nodes.
c
inorder_parc(struct node *node, int *array);
````
The function receives as arguments:
1. node &nbsp; = tree root;
2. array&nbsp;&nbsp; = the vector in which the node values will be stored.

**CAREFUL**

1. To retain the position in the **array** vector where you will store
next element use the imported variable **array_idx_1**. The vector is **indexed from 0**!


**REMARKS**
1. The **array** vector is allocated beforehand.
2. The **array_idx_1** variable is set to 0 for each test in advance.


## Example
<img src=https://i.imgur.com/dOUWnlw.png width="300" height="200" align="center" title="Example">
  
  
### In this example, the **array** vector will contain the elements [5, 10, 15, 19, 20, 25, 30, 35].

---
---

## Exercise II
The second exercise consists in traversing a binary tree
of searching in [_inorder_](https://www.geeksforgeeks.org/tree-traversals-inorder-preorder-and-postorder/) and to store the values from the nodes that do not respect the binary search tree property.
c
inorder_intruders(struct node *node, struct node *parent, int *array);
````
The function receives as arguments:
1. node &nbsp;&nbsp;&nbsp; = tree root;
2. parent&nbsp; = father/parent of the current node in the search tree;
3. array &nbsp;&nbsp;&nbsp; = the vector in which the node values will be stored.

The property that interests us consists of the two inequalities:
1. root->value > root->left->value, if root->left exists;
2. root->value < root->right-> value, if root->right exists.

**CAREFUL**

1. **Only** in **leaves** wrong values can appear;
1. To retain the position in the **array** vector where you will store
next element use the imported variable **array_idx_2**. The vector is **indexed from 0**!


**REMARKS**
1. The **array** vector is allocated beforehand.
2. The **array_idx_2** variable is set to 0 for each test in advance.
3. The tree **doesn't** need to be modified.


## Example
<img src=https://i.imgur.com/YA8wzpx.png width="300" height="200" align="center" title="Example">
  
  
### In this example, the **array** vector will contain the elements [12, 40].

---
---

## Exercise III
The third exercise consists in traversing a binary tree
of searching in [_inorder_](https://www.geeksforgeeks.org/tree-traversals-inorder-preorder-and-postorder/) and to modify the values in the nodes that do not respect the binary search tree property.
c
inorder_fixing(struct node *node, struct node *parent);
````
The function receives as arguments:
1. node &nbsp;&nbsp;&nbsp; = tree root;
2. parent&nbsp; = father/parent of the current node in the search tree;

The property that interests us consists of the two inequalities:
1. root->value > root->left->value, if root->left exists;
2. root->value < root->right-> value, if root->right exists.

The algorithm according to which the wrong values will be modified is the following:
1. If the current node is the left child, it will receive the value of the father -1, in other words:
  root->value = parent->value - 1;
2. If the current node is the right son, it will receive the value of the father +1, in other words:
  root->value = parent->value + 1.

**CAREFUL**

1. **Only** in **leaves** wrong values can appear;


**REMARKS**
1. The wrong values **do not** have to be saved, only modified in the tree.


## Example
<img src=https://i.imgur.com/YA8wzpx.png width="300" height="200" align="left" title="Example">
  
  
<img src=https://i.imgur.com/E5IFteR.png width="300" height="200" align="right" title="Example">
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

     
&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp; &nbsp;&nbsp;===============================>
   
&nbsp;
&nbsp;
&nbsp;
&nbsp;




---
---
## Use checker
The checker can be used individually for each exercise, not before compiling the sources using **make**:
1. **./checker 1**
1. **./checker 2**
1. **./checker 3**

To check all exercises simultaneously use **./checker**.
You will receive feedback (**failed**\/**passed**) for each individual test, and at the end a provisional score.
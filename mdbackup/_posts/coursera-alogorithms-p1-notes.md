---
title: Coursera Alogorithm 课程 Lecture2 笔记
date: 2024-09-28 20:28:38
tags:
    - 计算机
    - 笔记
---

## Lecture 2

![](./pictures/alg1.png)

![](./pictures/alg2.png)

本章仅讨论此路径是否存在，确切给出该路径的算法之后会讨论

### Union Find(并查集)

用0～N-1为对象命名

连接的抽象性质

- 等价 $r \rightarrow r$

- 对称性 $if\ p \rightarrow q \  then\ q \rightarrow p$

- 连接性 $if \ p \rightarrow q \ and \ q \rightarrow r \ then\ p \rightarrow r$

即使直觉，但明确列出性质并确定算法具备此性质是必要的。

当等价关系存在时，一个对象和连接的集合就分裂为子集(连通分量)，连通分量是互相连接对象的最大集合

![](./pictures/alg3.png)

连通分量中的节点互相连接并且不与连通分量之外的对象连接。

算法将通过连通分量来实现

算法要实现的接口

- 查找两个节点是否连接

- 连接两个节点

查找就是检查两个节点是否在同一连通分量中，合并就是将两个对象的分量替换为其并集。

实现算法时要考虑是否高效

### 算法1: 贪心

![](./pictures/alg4.png)

C++ 代码:

```cpp
struct Union {
    vector<size_t> id;
    void connect(size_t node1, size_t node2)
    {
        for (size_t i = 0; i < id.size(); i++) {
            if (id[i] == node2) {
                id[i] = node1;
            }
        }
    }
    bool connected(size_t node1, size_t node2) { 
        return id[node1] == id[node2]; 
    }
    Union(size_t n)
    {
        for (size_t i = 0; i < n; i++) {
            id[i] = i;
        }
    }
};
```

查找: $O(1)$

合并: $O(n)$

初始化: $O(n)$

实际操作中至多$O(n^2)$,问题规模若是过大便无法解决,如何改进?

### 算法2

![](./pictures/alg5.png)

考虑将数据结构变为多个树(森林),每个节点的内容是该节点父节点的位置,若无父节点则指向自身.

查找: 检查两个节点是否存在共同的根节点

合并: 仅需将两个节点的根节点设置成相同的即可

C++ 代码

```cpp
struct Union {
    vector<size_t> id;
    void connect(size_t node1, size_t node2)
    {
        id[find_root(node1)] = find_root(node2);
    }
    size_t find_root(size_t n)
    {
        // 用递归的效果是一样的
        while (id[n] != n)
            n = id[n];
        return n;
    }
    bool connected(size_t node1, size_t node2)
    {
        return find_root(node1) == find_root(node2);
    }

    Union(size_t n)
    {
        for (size_t i = 0; i < n; i++) {
            id[i] = i;
        }
    }
};
```

若是节点过多且遍历需要$O(n)$,依然过慢,如何改进?

#### 改进1: 带权

显然,我们在合并操作时可以避免操作到过高的树,从而避免增加树的深度,因而缩减`find_root`函数的时间

```cpp
struct Union {
    vector<size_t> id;
    vector<int> tree_size;
    void connect(size_t node1, size_t node2)
    {
        size_t root1 = find_root(node1), root2 = find_root(root2);
        // 默认node1是高的那个树
        if (root1 == root2) {
            return;
        }
        if (tree_size[root1] < tree_size[root2]) {
            return connect(node2, node1);
        }
        id[root2] = root1;
        // 目前树所拥有的节点个数加上子树的节点个数
        tree_size[root1] += tree_size[root2];
    }
    size_t find_root(size_t n)
    {
        // 用递归的效果是一样的
        while (id[n] != n)
            n = id[n];
        return n;
    }
    bool connected(size_t node1, size_t node2)
    {
        return find_root(node1) == find_root(node2);
    }

    Union(size_t n)
    {
        for (size_t i = 0; i < n; i++) {
            id[i] = i;
            tree_size[i] = 1;
        }
    }
};
```

#### 证明: 加权之后的所有树的深度均不超过$\log_2N$

假设$T_1,T_2$为两颗树

显然,合并操作的发生当且仅当$|T_2| \geq |T_1|$时发生(注意这里是节点数量不是深度)

所以当深度增加时,树的大小至少翻倍,那么如果从1开始我们翻倍到$N$(也就是节点增加1)的次数就是$\log_2N$

#### 改进2: 路径压缩

当执行`find_root`时我们将会访问每个从当前节点到根节点路径上的节点,这一过程是很费时的,所以我们可以将每个节点都指向根节点,所需的代价是常数级别的.

我们回溯一次路径找到根节点,然后再回溯一次将树展平

改动:

```cpp
    size_t find_root(size_t n)
    {
        // 用递归的效果是一样的
        while (id[n] != n) {
            //把目前节点指向的父节点换成祖父节点以节省时间
            id[n] = id[id[n]];
            n = id[n];
        }
        return n;
    }
```

ps: 你也可以将当前节点直接指向根节点,这样树是完全展平的,当然上面的做法也被证明是在实际应用中效果几乎一样

时间复杂度: 对于$N$个元素最多 $c(N+M\lg^\*N)$次. $lg^\*N$是使N变为1需要取对数的次数.

在现实生活中可以被认为$lg^{\*}N \leq 5$ 因为$lg^*(2^{65536}) = 5$

### 总结

根据以上两个优化后我们发现并查集所需的时间是及其接近线性的,但事实上并不存在并查集的线性算法(由Friedman和Sachs证明)

## 可持久化和可回退并查集

可持久化分两种: 部分和完全

完全可持久化可以修改历史版本

部分可持久化的历史版本是只读的

这个日后再说,不属于课内范畴

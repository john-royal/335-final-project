; Project Ideas and Specs
; ------------------------

; Firstly an undirected graph is a type of grpah that has no specific direction when it comes to the edges connecting two vertices.
; In other words (A,B) = (B, A)
;(Directed graphs have specific directions the vertices travel so (A,B) doesn't always equal (B, A)

; General Formula for an Undirected graph is:
; |E| = |v| - 1
; This basically means that for every vertice there should be one less edge, makes sense because if we want to connect two edges, we only need one edge.
; The outlier would be if the graph is acyclic, which means that there are no self-loops so if (A, A)

; For this let's try a basic induction (Will most likely need to be improved on LOL)

; Base case: if |v| = 1, then there should be 0 edges. (This graphs can no cycles)

; Induction step: Let n >= 1 and suppose every graph n vertices has n - 1 edges. So every n + 1 vertices has n edges

; -------------------------------------------------------------------------------------------------------------------------------------

; Regarding finding the shortest path between two vertices, we have a few options to choose:

; First we have Depth-First Search (DFS)

; This is recursion
; So for this we would start at V1 and mark that it is visited and mark it as already visited.
; After this we will be recall DFS again for each unvisited vertex.
; Once V2 is found, the path is stored
; This should be easy enough to implement but the catch is that it isn't reliable in finding the shortest path
; [We can use this to check if there is a path between the vertices]

; Dijkstra Algorithm

; This will make sure we went the shortest path between the two vertices [I'm leaning towards this]

; Assign a distance of 0 to the V1 and the rest of the grpah
; Have all the vertices marked as unvisited
; start with the source V1
; For each unvisited vertix calculate the distance from V1, and if the distance is less than the tenative distance of the neighbor, update the distance and store the path
; These steps is repeated until all the vertices are vistied

; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Is the grpah acyclic?

; Firstly let's identify what this means. We want to check if the graph has a self loop. So if one of the edges were to be [A,A]
; This mean that there is one vertice and one edge as a spec.

; So to implement this, we would need to essentially check if that path of a V1 goes to V1 again.
; Upon some research (ChatGBT LOL) We can use DFS, which adjustments to it. This can score us some brownie points as well hopefully.

; We can set an empty list (so tail-wind recursion?) this will be used to keep track of of the unvisted edges.
; For the unvisited vertices of the current vertex, mark the neighbor vertex as visited and perfrom DFS recursively with the neighbor as the current vertex.
; During this process if a previously visited neighbor that isn't the parent of the current vertex, there is a cycle in the graph.


; ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; So we should implore a data type that checks if the graph is connected or not, which means if all the vertices of the graph connect or not
; Maybe using DFS could help solve that issue if we modify the code a bit?
; With this idea in DFS we are essentially checking if the vertices are visited during the transversal. So we can essentially just addif all of the
; vertices are visited then its true, and if not return false.
; We can explore the implementation of this later.

; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; So next let's look at spanning trees

; A spanning tree was actually described earlier by us, it's essentially having an undirected graph that has no cycles
; easy enough
; The best approach is just using a tie in from the other algorithms and essentially checking if the tree has n - 1 edges.
; So we make sure for every two vertices for example there is one edge.
; To do this we essentially have to check that there is nothing like [A, A] or [B,B] sinc ethat describes a loop,and we don't want that.
; I get this can be helpful in the sense of finding the shortest path of an undirected graph, because neglecting cycles, will erase any unnecessary work in our algorithms.
; We don't need it, but it can help.

; ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; So let's find the diameter which would actually be very useful
; The diameter basically checked the largest shortest paths between any two vertices in a graph.
; So it tells the greatest nuber of possible edges we need to transverse
; [Let's circle back to this]

; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Let's try starting some of the code.

; First we should consider adding an empty graph function

(define (make-graph)
  '())

; Now we should create a datatype to describe an undirected graph

; We need to add verteices for the grpahs
; Example of an adjacent list
(define ex-graph
  '((A B)
    (B A C)
    (C B)))
; So from some chatgbt questions, we can use a built in function assoc, that will basically return the sublist when presented a key, which is the car of the sublist.
; So for this example (assoc 'B graph) = '(b a c)
; This can be uselful when visting neigbors for vertices.


; Realized I can use this to add vertices.

; So how can we add vertices, bit of learning curve I have realized upon further inspection, but let's see how I do LOL.

; First we want to make sure that the grpah we are adding the vertice into doesn't already exist.
; We can add a conditional to combat that.
; We are working with an empty list, so we can add it to that.

; first we need two parameters one for the new value and the other for the graph, we are adding to

; Let's try the code

; This marks the first part of the project. I doubt we need to make much changes for this as, it's just creating an undirected graph (1.1)

(define (add-vertex graph vertex)
  (if (assoc vertex graph)
      graph
      (cons (cons vertex '()) graph)))
(define graph (make-graph))

(define graph (add-vertex graph 'A))
(define graph (add-vertex graph 'B))
(define graph (add-vertex graph 'C))

; (display graph)

; It seems to work possiblly tweak the code so it doesn't reverse, but that's probably not an issue we have to care about

; Let's begin working on creating a function to add edges to our graph

(define (add-edge graph v1 v2)
  (define (update-vertex v w graph)
    (map (lambda (entry)
           (if (eq? v (car entry))
               (cons v (cons w (cdr entry)))
               entry))
         graph))
  (let ((graph (update-vertex v1 v2 graph)))
    (update-vertex v2 v1 graph)))

(define graph (add-edge graph 'A 'B))
(define graph (add-edge graph 'B 'C))
(define graph (add-edge graph 'A 'C))

;(display graph)

;---------------------------------------------------------------------------------------------------------------------------------------------------------

; Let try do steps for 1.2 (This will most likely be the most bothersome part of the project

; Let's start with seeing if vertice 1 and 2 are connected.
; This actually can be doable without too much issue, but idk if my approach would be good enough or not, let's see

; So from how the undirected graph is created, it's basically a big list with a bunch of sublists that represent the edges, or connect between the vertices.
; So if we want to see if there's a connection between two vertices, we essentially can just spearate the sublists and check if two vertices are in the sublist, that should prove a
; connection or not.

;(define (graph-connection v1 v2 graph)
;  (cond ((null? graph) #f)
;        ((and (member v1 (car graph)) (member v2 (car graph))) #t)
  ;      (else (graph-connection v1 v2 (cdr graph)))))

;(define graph (graph-connection 'a 'b graph))

; According to chatgbt, this code wouldn't work --- which is very unfortunate, guess we gotta use DFS

; I used a lot of chatgbt for this, but I got a pretty good understanding for it.

; Design Idea
; So we are trying to find if there is a connection between two vertices of the graph.
; The best approach we gathered is using Depth-First Search (DFS)
; DFS will be used for 4 parameters, the two vertices, the graph we are using, and an empty list that is used to keep track of vertices visited
; the first vertex will act as the current vertex, and we have to find v2, which is the target vertex
; if v1 and v2 are the same that means that we have found the target vertex, so the the program would stop and prove there's a graph connection
; else, we have to go through the neighbor vertices of v1, which we can use the assoc function to find all the vertices associated with v1
; To iterate through all these vertices, we can use iteration
; if there are no neighbors in the associate list, there is no connection, so it's false
; if not, we scan through the list
; If the current vertex in the iteration isn't in the visited list, we add it into visited
; This continues until the target vertex is found, and once that is, the program immeditately returns true

(define (dfs v1 v2 graph visited)
  (if (eq? v1 v2)
      #t
      (let ((neighbors (cdr (assoc v1 graph))))
        (define (dfs-iter nbrs)
          (if (null? nbrs)
              #f
              (let ((nbr (car nbrs)))
                (if (not (member nbr visited))
                    (or (dfs nbr v2 graph (cons v1 visited)) (dfs-iter (cdr nbrs)))
                    (dfs-iter (cdr nbrs))))))
        (dfs-iter neighbors))))

(define (graph-connection v1 v2 graph)
  (dfs v1 v2 graph '()))

; Proof
; The point of DFS is to visit all the 'reachable' vertices from the starting vertex (v1)
; Also no vertex is visited more than once
; Base Case: if the current vertex is the same as the target vertex, then the algorithm proves true
; Inductive Step: We need to show that if the property holds for n, it has to also hold for n + 1
; If we need to find n + 1, we can assum that DFS will find a path from v1 to n + 1 by recursively searching neighors until n + 1 is found
; If n + 1 isn't in the same path as v1, it will search through the list until there is no more paths to go through

; Test code
;(define graph (make-graph))
;(define graph (add-vertex graph 'A))
;(define graph (add-vertex graph 'B))
;(define graph (add-vertex graph 'C))
;(define graph (add-edge graph 'A 'B 1))
;(define graph (add-edge graph 'A 'C 3))
;(define graph (add-edge graph 'B 'C 2))

;(display (dijkstra graph 'A 'C)) ; Output: 3

; [Side Not John, this doesn't work, it's chatgbt code, I'm sorry I couldn't find the energy to implement it myself, so can you? I cant provide a conceptual view on it for you!]

; ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; So now let's try to find out if the grpah is acyclic or not
; Just a reminder an acyclic grpah is if there is a self loop so if (A, B), (A, C), which in theory should be not too diffuclt to prove.
; The main concern is of either finding our own algorithm or using an existing algorithm to prove it.
; So a broad design plan would be to recursively go through the graph list and check if we see in a sublist if there is an edge that connected V1 to V1.
; Sounds easy enough or is it? LOL

; Okay let's try modifying the DFS model, so we want to see if there is an edge with one vertex
; We can set parameters graph, and visited.

;Design Idea
; So we want to check if the graph has any cycles or not, for simplicity we went with DFS again
; first we need to identify what a cycle would mean, if the current vertex we have found is also already visited
; That means there's a cycle, unless the current vertex is also it's own parent
; We can create a local function, loop that takes the start of the current vertex, and finds all it's edges in the graph
; First in the loop we check if the current neighbor has any edges, if it doesn't, that means there are no cycles
; else it takes the first element of neighbors and checks if it's not equal to the parent vertex
; if it's not then we recursively call the function switching the current vertex to the next
; and adding the previous current vertex to the visited list
; if in the next recursion, it's true the program returns true, if not, we go through the loop function again, until it goes through all the edges.
; Essentially it returns true if the function has a cycle.

(define (dfs-acyclic current_vertex parent graph visited)
  (if (member current_vertex visited)
      (if (eq? parent current_vertex)
          #f
          #t)
      (let loop ((neighbors (cdr (assoc current_vertex graph))))
        (if (null? neighbors)
            #f
            (let ((neighbor (car neighbors)))
              (if (not (eq? parent neighbor))
                  (if (dfs-acyclic neighbor current_vertex graph (cons current_vertex visited))
                      #t
                      (loop (cdr neighbors)))
                  (loop (cdr neighbors))))))))

(define (is-acyclic graph)
  (let ((starting_vertex (caar graph))) (dfs-acyclic starting_vertex #f graph '())))
 ; the parent input is used to identify back edges since an undirected graph doesn't follow a specifc direction

; Proof
; General Invariant:
; At any point during the DFS program, a vertex in the visited list if an only if all paths from the starting vertex have been explored
; No vertex is visited more than once, because the prgoram checks before the iterative recall if the vertex has been added
; to the visited list
; All vertices that can be reached are eventually visited, since we added a vertex to the visited list as soon as we begin exploring
; it, and we xplore all neighbors of each vertex, we can make the assumption that we visit alll the vertices reachable from the starting vertex
    
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Now let's create a data type for spanning trees

; Essentially a spanning tree is a graph that has no circuits, or in other words doesn't loop back;
; For this the best coruse is findig a spanning tree inside our unidrected graph. We can do this by having an empty list, which can add a direction, that is a spanning tree
; Obviously this is a very simplistic way to look at it, and will have to add in a lot of knowledge to it

; Oh wait lol, it's easy to define a spanning tree, well I mean if the graph is unidrected, all we need is for it to be connected and doesn't have loops lol

; the function can be to comapre if the graph is connected and doesn't have loops. Let's back track and and create a function to check if the graph is connected

; To start on finding if the graph is connected, I'm gonna implement, I'm going to use a helper function that lets me know how many vertices are in the graph.

; Complete Design Idea

; So we want to check if the graph is connected, which means that all the vertices are connected through one parent vertex
; Honestly from all we've done so far this isn't diffuclt, we essentially can just run DFS, and calculate from this
; We'll reimplement DFS, and then a helper function that checks the number of vertices in the graph
; The point of that is to compare the visited elements of DFS with how many vertices there are in the graph
; Then we create a function connect? that essentially started DFS on the first vertex.
; Once that is done, it compares the visted vertices from DFS to the number of vertices in the graph
; If the number of vertices are the same, we have a connected graph!



(define (dfs-connected current visited graph)
  (if (member current visited)
      visited
      (let ((neighbors (cdr (assoc current graph))))
        (define (iter-connect nbrs)
          (if (null? nbrs)
              visited 
              (let ((nbr (car nbrs)))
                (if (not (member nbr visited))
                    (iter-connect (dfs-connected nbr (cons current visited) graph))
                    (iter-connect (cdr nbrs))))))
        (iter-connect neighbors))))


(define (number-of-vertices graph)
  (length graph))
; The point of this is to compare the number of vertices in the graph vs the completed vertices of the visted graphs

(define (connected? graph)
  (let* ((start-vertex (caar graph))
         (visited (dfs-connected start-vertex '() graph)))
    (= (number-of-vertices graph) (length visited))))

; Proof



; So i just realized I'm continously creating DFS function, when I don't have to, realized how stupid this is. I can fix it eventually for the final product, so please bear with me
; for now John lol

; Cool, so now we can check if the graph is connected and check if there's a loop
; So now that we have these implemented, we can easily check if there is a spanning tree in the unidrected graph

(define (spanning? graph)
  (and (is-acyclic graph) (connected? graph)))
; The conditional is obviously usueless but, I feel like more now, it can give a more conceptual feel of it

; Now with this placed, we can create a way to find the spanning graph

; Now with this placed, we can create a way to find the spanning graph
; So originally I was going to use Kurskal's algorithm, but since for now we aren't working with a weighted graph, we can just use DFS
; However, once we implement a weight graph, I can use it for brownie points

; So from this, it would be easy to return a spanning tree then using DFS, we just have to modify the previous function a bit:

(define (dfs-spanning-tree current visited tree graph)
  (if (member current visited)
      tree
      (let ((neighbors (cdr (assoc current graph))))
        (define (iter-tree nbrs)
          (if (null? nbrs)
              tree
              (let ((nbr (car nbrs)))
                (if (not (member nbr visited))
                    (iter-tree (dfs-spanning-tree nbr (cons current visited) (cons (list current nbr) tree) graph))
                    (iter-tree (cdr nbrs))))))
        (iter-tree neighbors))))

(define (spanning-tree graph)
  (let ((start-vertex (caar graph)))
    (dfs-spanning-tree start-vertex '() '() graph)))

; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Finding the largest clique will be a tricky problem to solve, since you can't gather a full effective solution to it.
; Best course of action can be to use a few helper functions to brute force the solution.

; First create a function check if vertices are adjacient.

(define (adjacient? v1 v2 graph)
  (cond ((null? graph) #f)
        ((assoc v1 (car graph)) (member v2 (car graph)))
        (else (adjacient v1 v2 (cdr graph)))))

; Then let's implement a function that returns all the possible pairs of the list:

(define (all-pairs lst)
  (cond ((null? lst) '())
        ((null? (cdr lst)) '())
        (else (append (map (lambda (x) (list (car lst) x)) (cdr lst))
                      (all-pairs (cdr lst))))))

; Then let's find all possible subsets for the unidrected graph

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

; Next let's find the cliques for the graph

(define (all? pred lst)
  (cond ((null? lst) #t)
        ((pred (car lst)) (all? pred (cdr lst)))
        (else #f)))

(define (clique? vertices graph)
  (let ((pairs (all-pairs vertices)))
    (all? (lambda (pair) (adjacient? (car pair) (cadr pair) graph)) pairs)))

(define (all-cliques graph)
  (let* ((vertices (map car graph))
         (vertex-subsets (subsets vertices)))
    (filter (lambda (subset) (clique? subset graph)) vertex-subsets)))

; Now we find the largest clique by comparing all the cliques and finding which sublist has the most vertices

(define (largest l)
  (if (null? l)
      '()
      (let ((rest-largest (largest (cdr l))))
        (if (> (length (car l)) (length rest-largest))
            (car l)
            rest-largest))))

(define (largest-clique graph)
  (let ((cliques (all-cliques graph)))
    (largest cliques)))



; ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Let's take a step back and create a weighted graph, this is where Dijasktra and Kruscal algorithm will come to shine.

; A weighted graph essentially means that the edges are have a value set to them, so you can track the cost of going through edges.

; Let's do a list type representation so, the weighted graph would look something like this: (1 ((2 10) (3 20))

; First let's make an empty weighted graph

(define (make-weighted-graph)
  '())

; Then let's recreated the function that adds the vertices to the graph

(define (add-vertex-weighted graph vertex)
  (if (assoc vertex graph)
      graph
      (cons (cons vertex '()) graph)))

; Great the easy part is done, not we need to connect to the edges

(define (add-weight-edge graph v1 v2 weight)
  (letrec ((update-edge (lambda (graph v1 v2 weight)
                          (if (null? graph)
                              '()
                              (let ((vertex (car graph)))
                                (if (eq? (car vertex) v1)
                                    (cons (cons (car vertex) (cons (list v2 weight) (cdr vertex)))
                                          (cdr graph))
                                    (cons vertex (update-edge (cdr graph) v1 v2 weight))))))))
    (if (string<? (symbol->string v1) (symbol->string v2))
        (update-edge graph v1 v2 weight)
        (update-edge graph v2 v1 weight))))
; the problem with this is that idk if we can use String<? 

;(define weighted-graph (make-weighted-graph))
; Add vertices
;(define weighted-graph (add-vertex-weighted weighted-graph 'A))
;(define weighted-graph (add-vertex-weighted weighted-graph 'B))
;(define weighted-graph (add-vertex-weighted weighted-graph 'C))
;(define weighted-graph (add-vertex-weighted weighted-graph 'D))
;(define weighted-graph (add-vertex-weighted weighted-graph 'E))
; Add edges
;(define weighted-graph (add-weight-edge weighted-graph 'A 'B 1))
;(define weighted-graph (add-weight-edge weighted-graph 'A 'C 3));
;(define weighted-graph (add-weight-edge weighted-graph 'B 'C 4))
;(define weighted-graph (add-weight-edge weighted-graph 'E 'C 6))
;(define weighted-graph (add-weight-edge weighted-graph 'D 'E 2))
;(define weighted-graph (add-weight-edge weighted-graph 'E 'A 3))
;Display
;(display weighted-graph)


; --------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Let's implement an directed graph

; The difference between an undirected graph, and directed graph is that a directed graph, goes a specific path through the vertices, while that doesn't matter for
; undirected graphs.

; Implementing the function to add vertices, should be the same.

(define (make-directed-graph)
  '())


(define (add-vertex-directed graph vertex)
  (if (assoc vertex graph)
      graph
      (cons (cons vertex '()) graph)))
(define graph (make-directed-graph))

; We have to just modify how the edge connects for the next function.

(define (add-edge-directed graph v1 v2)
  (map (lambda (entry)
         (if (eq? v1 (car entry))
             (cons v1 (cons v2 (cdr entry)))
             entry))
       graph))

; The modification was actually very easy to make, all I had to do was remove the lines of code in which v1 goes into v2, so that v2 goes into v1.

; Now we have a directed graph

(define directed-graph (make-directed-graph))

(define directed-graph (add-vertex-directed directed-graph 'A))
(define directed-graph (add-vertex-directed directed-graph 'B))
(define directed-graph (add-vertex-directed directed-graph 'C))

(define directed-graph (add-edge-directed directed-graph 'A 'B))
(define directed-graph (add-edge-directed directed-graph 'B 'C))
(define directed-graph (add-edge-directed directed-graph 'A 'C))


(display directed-graph)

(newline)
(newline)


; -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Let's now try an implementation of topological sort

; This will be a bit tricky, it seems, but essentially this sorting method, just follow a direct line of vertices connected by the edge
; so like this A -> B -> C -> D

; So first a graph can only be topological if it's acyclic, lucky for us we already have a function that does that, so we can check that off.
; Next we can use DFS to help us out with this.
; First we can create an empty stack to hold all the vertices that we sort
; Then create a set to keep track of visited vertices
; We want to go through adjacient vertices. and push the visited ones up to the stack
; It will sort the order from top to bottom, if we can execute this right LOL.

; First let's implement the DFS helper function we need
; We need to slightlty modify the previous ones, not too much work for that
(define (dfs-topo-sort current visited graph)
  (if (member current visited)
      visited
      (let ((neighbors (cdr (assoc current graph))))
        (define (iter-connect nbrs visited)
          (if (null? nbrs)
              (cons current visited)  ;; Add current node to visited after visiting all neighbors
              (let ((nbr (car nbrs)))
                (if (not (member nbr visited))
                    (iter-connect (cdr nbrs) (dfs-topo-sort nbr (cons current visited) graph))  ;; Recursively visit neighbors
                    (iter-connect (cdr nbrs) visited)))))
        (iter-connect neighbors visited))))

; Now that we have implemented DFS, let's create our main function

(define (topological-sort graph) ; the graph is the input value
  (let ((order '())) ; Create an empty stack to store the visited vertices
    (letrec ((iter (lambda (vertices order) ; letrec helps us store a local function for iteration
      (if (null? vertices) ; if we run out of vertices to check is returns us the visited vertices 
          order
          (iter (cdr vertices) ; if it's not empty it, it calls the local function again to go through the rest of the list, and dfs helps us store and adds the vertices to the order list
                (dfs-topo-sort (car vertices) order graph))))))
             (reverse (iter (map car graph) '()))))) ; The map function helps us extract the list of vertices from the graph, and then we reverse the list so the vertices are in the front of the order

          
    

; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Let's take a look at weighted graphs again

; Recall from before I was talking about Kruscal's algorithm to find a spanning tree, but since my graph wasn't weighted, it was overkill so I used DFS?
; Now that we have a weight graph, it would be cool to use Kruscal's now.
; It's a greedy method, meaning it finds the minimum spanning tree

; First as I said earlier a spanning tree can't have cycles.
; We have to take it mind, that it will connect all edges that have the list weight, that's what makes this algorithm powerful

; The conceptual view is that first we sort all the edges from the grpah in non-decreasing order of their weights
; Then start adding edges to the minimum spanning tree. If adding an edge creates a cycle, then do not add an edge.
; Continue this untill you have a spanning tree, which means all vertices are connected and there are no cycles.

; First we have use the is-acyclic function again to most likely make a check if adding a specific edge causes a cycle.
; We probably need a stack that is empty that we add the sorted edges to
; Possibly another empty stack, that we start adding the minimum spanning tree to
; Obviosuly this will have to be done recursively

; So doing this will have a lot of steps, which actually is beneficial for us John, it can earn us a lot of brownie points.

; First let's create a function that sorts the edges.
; First we can extract the edges by using map.

; Let's first sort the edges --- John this may not be optimal, we can see if we should change this

;(define (sort-edge edge)
;  (if (< (cadr edge) (car edge))
 ;    (list (cadr edge) (car edge) (caddr edge))
 ;     edge))
; ---> This implementation didn't work so I'm using for now a chatgbt code --> should be changes later on

; okay so turns out using the sorting implementation isn't working out, I gotta change the weighted graph then

;(define (insert-in-order new-edge edge-list)
 ; (if (or (not (list? new-edge)) 
        ;  (< (length new-edge) 3) 
         ; (null? edge-list)
          ;(not (list? (car edge-list))) 
          ;(< (length (car edge-list)) 3))
      ;(error "Invalid edge or edge list")
      ;(if (< (caddr new-edge) (caddr (car edge-list)))
        ;  (cons new-edge edge-list)
          ;(cons (car edge-list) (insert-in-order new-edge (cdr edge-list))))))


;(define (sort-edges edge-list)
  ;(if (null? edge-list)
   ;   '()
     ; (insert-in-order (car edge-list) (sort-edges (cdr edge-list)))))

(define (extract-edges graph)
  (if (null? graph)
      '()
      (let ((vertex (caar graph))
            (edges (cdar graph)))
        (append (map (lambda (edge) (list vertex (car edge) (cadr edge))) edges)
                (extract-edges (cdr graph))))))
(define (insert-in-order new-edge edge-list)
  (cond ((null? edge-list) (list new-edge))
        ((not (and (list? new-edge) (>= (length new-edge) 3))) 
         (display "Invalid edge") '())
        ((not (and (list? (car edge-list)) (>= (length (car edge-list)) 3))) 
         (display "Invalid edge list") '())
        ((< (caddr new-edge) (caddr (car edge-list))) 
         (cons new-edge edge-list))
        (else (cons (car edge-list) (insert-in-order new-edge (cdr edge-list))))))

(define (sort-edges edge-list)
  (if (null? edge-list)
      '()
      (insert-in-order (car edge-list) (sort-edges (cdr edge-list)))))


  (define weighted-graph (make-weighted-graph))
  ; Add vertices
  (set! weighted-graph (add-vertex-weighted weighted-graph 'A))
  (set! weighted-graph (add-vertex-weighted weighted-graph 'B))
  (set! weighted-graph (add-vertex-weighted weighted-graph 'C))
  ; Add edges
  (set! weighted-graph (add-weight-edge weighted-graph 'A 'B 3))
  (set! weighted-graph (add-weight-edge weighted-graph 'A 'C 2))
  (set! weighted-graph (add-weight-edge weighted-graph 'B 'C 1))

  (display "Graph: ")
  (display weighted-graph)
  (newline)

  (define extracted-edges (extract-edges weighted-graph))
  (display "Extracted Edges: ")
  (display extracted-edges)
  (newline)

  (define sorted-edges (sort-edges extracted-edges))
  (display "Sorted Edges: ")
  (display sorted-edges)
  (newline)

; Okay this part was extremely hard to do, my implementation didn't work so I just after many specification updates got chatgbt to write it.

; Now we gotta disjoint, which is a bit hard to grasp, but let me try to explain it the best I can.

; So first we want to make the vertices into sets, so we can split all the vertices out, so they can be their own sets
; The implementation of this:

(define (make-set vertices)
  (map (lambda (vertex) (cons vertex vertex)) vertices))

; This assigns a vertice to it's own set, as well as making the vertex it's own parent for now.
; Now this is where it gets confusing --> I had to make chatgbt use a lego block analogy and then a classroom analogy to make me understand it
; So we need to implement a find function that finds the parent of the vertex, this means that we have keep asking a vertex where it comes from, and goes down until one identifies itself as the parent

(define (find set x)
  (if (eq? x (cdr (assoc x set))) ; This checks if x is it's own parent // if it is then you return x, because it's at the top of the tree
      x
      (find set (cdr (assoc x set))))) ; Otherwise we go through the program again, with the current disjoint strucutre and repeat the process until we find the parent
  
; Now we need to implement the union for this, which is slighlty less confusing
; So we have sets right now, with each vertex being it's own parent, but let's say for set A, we want to implement it so it becomes the parent for set B.
; It basically combines two sets to each other
; Then we use the find function to find the parents of each of these new sets

(define (union set v1 v2)
  (let ((x (find set v1)) (y (find set v2))) ; This defines the two sets with have to join together
    (if (not (eq? x y)) ; This checks if x and y set aren't equal 
        (map (lambda (pair) ; If they aren't we use map and a lambda function
               (if (eq? (cdr pair) y) ; This if the second set is in the parent set
                   (cons (car pair) x) ; if it is, it combines and creates a new set where x is the parent of y
                   pair))
             set)
        set)))
; Oh lord finally implemented all the data structures for this, my brain is fried from this, honestly probably the hardest part of the project I've done so far

; Bro after all the work, Ima just use chatbpt code, I'll change it later, but let's just see if it works meaning I implemented the data structures correctly

(define (kruskal graph)
  (let ((sorted-edges (sort-edges (extract-edges graph)))
        (disjoint-set (make-set (extract-vertices graph)))
        (result '()))
    (define (kruskal-helper edges)
      (if (null? edges)
          result
          (let* ((edge (car edges))
                 (v1 (car edge))
                 (v2 (cadr edge)))
            (let ((v1-root (find disjoint-set v1))
                  (v2-root (find disjoint-set v2)))
              (if (eq? v1-root v2-root)
                  (kruskal-helper (cdr edges))
                  (begin (set! result (cons edge result))
                         (set! disjoint-set (union disjoint-set v1 v2))
                         (kruskal-helper (cdr edges))))))))
    (kruskal-helper sorted-edges)))

(define (extract-vertices graph)
  (if (null? graph)
      '()
      (cons (caar graph) (extract-vertices (cdr graph)))))

(define result (kruskal weighted-graph))
(display "Minimum spanning tree: ")
(display result)
(newline)

; Alot of changes were made in the weight graph code, but at least now after modifying the chatgpt function I got it to work

; ----------------------------------------------------------------------------------------------------------------------------------------------------------------------\

; Lastly lets created a labeled undirected graph, which may be the easiest thing I've done in the last few days.

; So first make an empty graph:

(newline)
(newline)
(newline)

(define (make-label-undirect-graph)
  '())

; Now add the vertices
(define (add-vertex-label graph vertex)
  (if (assoc vertex graph)
      graph
      (cons (cons vertex '()) graph)))
(define graph (make-graph))

; Okay now we add the edges, we can just add another input that is for labels

(define (add-edge graph v1 v2 label)
  (define (update-vertex v w l graph)
    (map (lambda (entry)
           (if (eq? v (car entry))
               (cons v (cons (list w l) (cdr entry)))
               entry))
         graph))
  (let ((graph (update-vertex v1 v2 label graph)))
    (update-vertex v2 v1 label graph)))


                    
        
        







This time we will hold the presentations in a new place:

ELTE Lágymányosi Campus - Déli Tömb - 0.311-es terem (König terem) (on the ground floor, near the northern entrance, see the [floor map][konig_terem])

We will have four 10-15 minute lightning talks. The topics will be the following:

**Péter Diviánszky: Pattern match compilation**

The task of pattern match compilation is to transform function alternatives with pattern matching to simple function definition and case expressions.

I present a pattern match compilation algorithm which does exhaustiveness and reachability checks, and supports many extensions like pattern guards and view patterns too.

**Matthias Fischmann & Andor Pénzes: Liquid democracy & Haskell**

[Aula][aula] is a [project][aula_github] for bringing delegation-based decision processes to the school curriculum in Germany. It is implemented in Haskell using servant, lens, acid-state, and digestive-functors. We will talk about using servant for html forms. Aula is a project of liqd.net, which is a non-profit in Berlin that offers open-source software and consulting for democratic processes in politics and all kinds of organisations.

**Csaba Hruska: Data Definition Haskell EDSL for cross language data exchange (supporting Java/C#/C++/Haskell/PureScript)**

Exchanging data between programs running on different platforms is an everyday problem. Thrift and Protocol Buffers perfectly solve this problem for object oriented languages. However they do not support Algebraic Data Types. Fortunately, with some work, we can write our own Data Definition Language as a Haskell Embedded Domain Specific Language that will support cross language data serialization between several languages (Haskell, PureScript, C#, C++, Java, etc.)

[slides](http://htmlpreview.github.io/?https://github.com/BP-HUG/presentations/blob/master/2016_april/data-definition-haskell-edsl/slides.html)

[pdf](https://github.com/BP-HUG/presentations/blob/master/2016_april/data-definition-haskell-edsl/Data%20Definition%20Language%20in%20Haskell.pdf)

[source code](https://github.com/lambdacube3d/lambdacube-ir/tree/v0.3/ddl)

**Patrick Chilton: Solga - simple type-safe web routing**

Servant is becoming very popular for type-safe web routing in Haskell. However, we found that for our use case, it is somewhat overcomplicated and uncomfortable. We developed a similar, but simpler library, Solga, and found that it presents a number of advantages.

[konig_terem]: https://immanuel60.hu/wp-content/uploads/2011/09/elte_ik_deli_epulet_alaprajz.jpg
[aula]: https://aula-blog.website/
[aula_github]: https://github.com/liqd/aula

## Intro

This time we will held the [presentations][meetup] in a new place:

ELTE Lágymányosi Campus - Déli Tömb - 0.311-es terem (König terem) (on the ground floor, near the northern entrance, see the [floor map][konig_terem])

## Presentations

We held four 20-30 minute talks. The topics were be the following:

### Péter Diviánszky: Pattern match compilation

_Abstract:_
> The task of pattern match compilation is to transform function alternatives with pattern matching to simple function definition and case expressions.

> I present a pattern match compilation algorithm which does exhaustiveness and reachability checks, and supports many extensions like pattern guards and view patterns too.

More info:

* [HTML slides][pattern_html]
* [The code for the presentation][pattern_code]

You can generate the slides from the `pandoc` file with the following command:

    pandoc --css common.css patternMatchComp.pandoc -o patternMatchComp.html

### Matthias Fischmann & Andor Pénzes: Liquid democracy & Haskell

_Abstract:_
> Aula is a project for bringing delegation-based decision processes to the school curriculum in Germany. It is implemented in Haskell using servant, lens, acid-state, and digestive-functors. We will talk about using servant for html forms. Aula is a project of liqd.net, which is a non-profit in Berlin that offers open-source software and consulting for democratic processes in politics and all kinds of organisations.

The presentation was a demo, so there aren't any slides, you can find out more about Liquid Democracy and Aula here:

* [Liquid Democracy][liqd]
* [The website for the Aula project (german)][aula]
* [The source code for the project][aula_github]

### Csaba Hruska: Data Definition Haskell EDSL for cross language data exchange (supporting Java/C#/C++/Haskell/PureScript)

_Abstract:_
> Exchanging data between programs running on different platforms is an everyday problem. Thrift and Protocol Buffers perfectly solve this problem for object oriented languages. However they do not support Algebraic Data Types. Fortunately, with some work, we can write our own Data Definition Language as a Haskell Embedded Domain Specific Language that will support cross language data serialization between several languages (Haskell, PureScript, C#, C++, Java, etc.)

More info:

* [HTML slides][edsl_html]
* [PDF slides][edsl_pdf]
* [The source code for the project][edsl_source]

### Patrick Chilton: Solga - simple type-safe web routing

_Abstract:_
> Servant is becoming very popular for type-safe web routing in Haskell. However, we found that for our use case, it is somewhat overcomplicated and uncomfortable. We developed a similar, but simpler library, Solga, and found that it presents a number of advantages.

This was also a demo. The Solga library will be open sourced in the near future. We will post a link when it is.

[meetup]: http://www.meetup.com/Bp-HUG/events/230094042/
[konig_terem]: https://immanuel60.hu/wp-content/uploads/2011/09/elte_ik_deli_epulet_alaprajz.jpg
[pattern_html]: https://rawgit.com/BP-HUG/presentations/master/2016_april/pattern-match-compilation/patternMatchComp.html
[pattern_code]: https://rawgit.com/BP-HUG/presentations/master/2016_april/pattern-match-compilation/PatCompile.hs
[aula]: https://aula-blog.website/
[aula_github]: https://github.com/liqd/aula
[liqd]: https://liqd.net
[edsl_html]: https://rawgit.com/BP-HUG/presentations/master/2016_april/data-definition-haskell-edsl/slides.html
[edsl_pdf]: https://github.com/BP-HUG/presentations/blob/master/2016_april/data-definition-haskell-edsl/Data%20Definition%20Language%20in%20Haskell.pdf
[edsl_source]: https://github.com/lambdacube3d/lambdacube-ir/tree/v0.3/ddl

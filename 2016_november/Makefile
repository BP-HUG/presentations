lazy_evaluation.pdf: lazy_evaluation.pandoc lazy_evaluation.preamble
	pandoc -t beamer --slide-level=2 --toc --metadata date="`date '+%B %d, %Y'`" -H lazy_evaluation.preamble -s $< -o $@


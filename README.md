# Fillit Randomized Bench Testing

These are some tools I developed to help my partner and I test our fillit. 

It uses [jzck's random test file generator](https://github.com/jzck/fillit-tests) to generate random valid input files, and compares our fillit against various teams who have validated fillit with 100/100:
 - [oanamateiflorin](https://github.com/oanamateiflorin/Fillit)
 - [rchioreanu](https://github.com/rchioreanu/fillit)
 - [jgengo](https://github.com/jgengo/42-Fillit)
 - [davhojt](https://github.com/davhojt/fillit)
 - [pbondoer](https://github.com/pbondoer/42-fillit)
 - [Itokoyamato](https://github.com/Itokoyamato/42_projects)
 - [ValeriiaMur](https://github.com/ValeriiaMur/Fillit_42)

I removed their repos from this one, but to use any validated fillit you can just modify the shell scripts to point to a fillit executable. It should be reasonably self explanatory the way it's set up.

rolling-tester.sh is a diff tester.
bencher.sh is a timing bench tester.
bencher-withtimeout.sh is a version of bencher that can also set a timeout limit.

Feel free to use it, but figure out how to use it on your own for now. Maybe I'll polish it for use later.

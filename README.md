WARNING
=======

The code in this repo (https://github.com/L2G/mutant) is HIGHLY EXPERIMENTAL at
this time (see the note below about threading). Please take care in using it if
you are unfamiliar with it. DO NOT rely on it for production or
mission-critical applications.

----

mutant
======

Mutant is a mutation testing tool for ruby.

The idea is that if code can be changed and your tests do not notice, either that code isn't being covered
or it does not have a speced side effect.

A more readable introduction can be found under: http://solnic.eu/2013/01/23/mutation-testing-with-mutant.html

Mutant supports MRI and RBX 1.9 and 2.0, while support for jruby is planned. It
should also work under any ruby engine that supports POSIX-fork(2) semantics.
(In environments without fork(), mutant will attempt to use threading instead of
forking; note, however, that this feature is *_highly experimental_* and may
break in unknown situations!)

Only rspec2 is supported currently. This is subject to change.

It is easy to write a mutation killer/strategy for other test/spec frameworks than rspec2.

Projects using Mutant
---------------------

The following projects adopted mutant, and aim 100% mutation coverage:

* [axiom](https://github.com/dkubb/axiom)
* [axiom-types](https://github.com/dkubb/axiom-types)
* [rom-mapper](https://github.com/rom-rb/rom-mapper)
* [rom-session](https://github.com/rom-rb/rom-session)
* [event_bus](https://github.com/kevinrutherford/event_bus)
* [virtus](https://github.com/solnic/virtus)
* [quacky](https://github.com/benmoss/quacky)
* [substation](https://github.com/snusnu/substation)
* [large_binomials](https://github.com/filipvanlaenen/large_binomials)
* various small/minor stuff under https://github.com/mbj

Feel free to ping me to add your project to the list!

Installation
------------

Install the gem `mutant` via your preferred method.

The 0.2 series is stable but has outdated dependencies. The 0.3 series is in beta phase currently.

```ruby
gem install mutant --pre
```

Mutations
---------

Mutant supports a very wide range of mutation operators. Listing them all in detail would blow this document up.

It is planned to parse a list of mutation operators from the source. In the meantime please refer to the
[code](https://github.com/mbj/mutant/tree/master/lib/mutant/mutator/node) each subclass of `Mutant::Mutator::Node`
emits around 3-6 mutations.

Currently mutant covers the majority of ruby's complex nodes that often occur in method bodies.

Some stats from the [axiom](https://github.com/dkubb/axiom) library:

```
Subjects:  424       # Amount of subjects being mutated (currently only methods)
Mutations: 6760      # Amount of mutations mutant generated (~13 mutations per method)
Kills:     6664      # Amount of successfully killed mutations
Runtime:   5123.13s  # Total runtime
Killtime:  5092.63s  # Time spend killing mutations
Overhead:  0.60%
Coverage:  98.58%    # Coverage score
Alive:     96        # Amount of alive mutations.
```


Nodes still missing a dedicated mutator are handled via the
[Generic](https://github.com/mbj/mutant/blob/master/lib/mutant/mutator/node/generic.rb) mutator.
The goal is to remove this mutator and have dedicated mutator for every type of node and removing
the Generic handler altogether.

Examples
--------

```
cd virtus
# Run mutant on virtus namespace
mutant --rspec '::Virtus*'
# Run mutant on specific virtus class
mutant --rspec ::Virtus::Attribute
# Run mutant on specific virtus class method
mutant --rspec ::Virtus::Attribute.build
# Run mutant on specific virtus instance method
mutant --rspec ::Virtus::Attribute#name
```

Subjects:
---------

Mutant currently mutates code in instance and singleton methods. It is planned to support mutation
of constant definitions and domain specific languages, DSL probably as plugins.

Test-Selection
--------------

Mutation testing is slow. The key to making it fast is selecting the correct set of tests to run.
Mutant currently supports the following built-in strategy for selecting tests/specs:

Mutant uses the "longest rspec example group descriptions prefix match" to select the tests to run.

Example for a subject like `Foo::Bar#baz` it will run all example groups with description prefixes in
`Foo::Bar#baz`, `Foo::Bar` and `Foo`. The order is important, so if mutant finds example groups in the
current prefix level, these example groups *must* kill the mutation.

This test selection strategy is compatible with the old `--rspec-dm2` and `--rspec-unit` strategy.
The old flags where removed.  It allows to define very fine grained specs, or coarse grained - as you like.

Alternatives
------------

* [heckle](https://github.com/seattlerb/heckle)

Support
-------

I'm very happy to receive/answer feedback/questions and critism.

Your options:

* GitHub Issues https://github.com/mbj/mutant/issues
* Ping me on https://twitter.com/_m_b_j_
* #mutant channel on freenode, I hang around on CET daytimes. (nick mbj)
  You'll also find others [ROM](https://github.com/rom-rb) team members here that can answer questions.

Credits
-------

* [Markus Schirp (mbj)](https://github.com/mbj)
* A [gist](https://gist.github.com/1065789) from [dkubb](https://github.com/dkubb) showing ideas.
* Older abandoned [mutant](https://github.com/txus/mutant). For motivating me doing this one.
* [heckle](https://github.com/seattlerb/heckle). For getting me into mutation testing.

Contributing
-------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile or version
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

License
-------

See LICENSE file.

Hunt the Wumpus
===============

The hunter is all alone in this cave full of perils - or is she? It is her 
goal to find the precious treasure and make her way back to the cave's 
entrance, to safety. Beware of the hideous, foul-smelling Wumpus!

Say, I should make this into a commercial video game. Although the original
creators would probably fine me double if I did...

Abstract
========

An implementation of the classic Wumpus hunt  for didactic purposes (as 
remembered from my Russel/Norvig tome). 
This repository provides the infrastructure for the game, while the student 
will supply the implementation of the agent - the Wumpus hunter!

Possible future extensions include

  * Different types of visualization
  * Additional types of peril (bat country!)
  * Pets (ha ha, just kidding. Although people seem to be willing to pay a
    pretty penny for those...)

The interface of the hunter consists of a single function:
  make_move: Senses -> Action
This can be read like this: In each turn of the hunt, the hunter assesses her
sensory input and then decides which action to take.
Senses are: Breeze, Stench, Glitter, Bump, Scream
Actions are: Turn, Forward, Shoot, Grab, Climb

Rules of the Hunt
=================

The Perils (and the Good Stuff)
-------------------------------

There are pits in the cave which will kill the hunter, if she walks into them.
There's the Wumpus, which may be shot to death with the hunter's single
arrow. Maybe it's best to avoid it altogether...
There's some gold, which is the reason for the hunter's venture into this
cave full of danger and funk.

The Setup
---------

At the beginning, the hunter finds herself on some random square of a 4x4 grid
 (the cave). She better make note of this start point, because she will need
to return here eventually - it is the only point from which she will be able
to leave the cave after defeating the Wumpus. She can only move on the grid of
the cave.

The Senses
----------

Each turn, her senses will tell her something about her immediate 
surroundings. Since it's pitch black in the cave, she won't be able to see any
further than the square she's on. If on any of the four horizontally and 
vertically adjacent squares there's a *Pit*, she will feel a *Breeze* on her 
face. If she smells a vile *Stench*, that means the *Wumpus* must be near her.
Its *Scream* will let her know if she managed to hit it with her arrow.
A faint *Glitter* means that she is standing right on the pile of *Gold*. If
she tries to walk forward, but there's a *Wall* in the way, she'll *Bump* her
head.

The Actions
-----------

The hunter moves about carefully, first she must *Turn* in the desired 
direction (each turn will rotate her by 90 degrees clockwise). When she is 
ready, she moves *Forward*. This will take her to the next square in the 
direction she is facing. Unless there's a wall there, in which case she'll 
just bump her head. Once she has located the Wumpus, she will turn to face it
and *Shoot* her single arrow at it. The arrow will travel horizontally or
vertically in the direction the hunter is facing until it either hits and 
kills the Wumpus - or until it hits a wall, if the Wumpus wasn't actually in
its path. If the hunter is standing on the glittering pile of gold, she can
just *Grab* it and be a whole lot richer. After annihilating the Wumpus and
possibly grabbing the gold, the hunter must return to the start position and
*Climb* to safety.

The End
-------

The hunt is over when the hunter returns to the start and climbs out of the
cave, if she falls into a pit, or if she steps on the Wumpus's square and it
devours her sweet, sweet flesh. In any case, this is how her score will be 
evaluated: 

  * +1000 points for securing the gold
  * -1000 points for being killed, by Wumpus or pit
  * -10 points for shooting the arrow
  * -1 point for every action taken

The Nitty-Gritty
----------------

For starters, the student will povide their implementation of the hunter in
a file called `hunter.rb`. Therein must be found a class by the name of
`Hunter`, which verily shalt possess a method calléd `Hunter#make_move(senses)`!
The object passed as an argument into the parameter `senses` will have 
accessors `breeze`, `stench`, `glitter`, `bump`, `scream`, indicating wether
or not the respecitive sensory input is present.
The value returned by the method shall be the description of the hunter's
desired action, one of `Action::TURN`, `Action::FORWARD`, `Action::SHOOT`,
`Action::GRAB` and `Action::CLIMB`.

The game will continue to call the method `Hunter#make_move` until the hunt is over
(good or bad), or until ten turns have passed without the hunter moving from
her current square *(this is preliminary, will probably be refined later)*.
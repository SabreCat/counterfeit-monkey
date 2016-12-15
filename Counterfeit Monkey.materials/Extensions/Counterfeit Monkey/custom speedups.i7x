Custom Speedups by Counterfeit Monkey begins here.

Use authorial modesty.

[ These are used to speed up Scope Caching ]

To rapidly set everything marked invisible:
	(- MyAllSetMarkedInvisible(); -).

To rapidly set (n - an object) marked visible:
	(- MySetMarkedVisible({n}); -).

To rapidly set everything marked-visible as seen:
	(- MySetAllMarkedVisibleAsSeen(); -).

Include (-

	[ MyAllSetMarkedInvisible obj;
		for (obj=IK2_First: obj: obj=obj.IK2_Link) {
			give obj ~(+ marked-visible +);
		}
	];

	[ MySetMarkedVisible obj;
		give obj (+ marked-visible +);
	];


	[ MySetAllMarkedVisibleAsSeen obj;
		for (obj=IK2_First: obj: obj=obj.IK2_Link) {
			if (obj has (+ marked-visible +) )
				give obj (+ seen +);
		}
	];


	[ ApartmentalThing i o start thing;
		i = 1;
		thing = nothing;

		! Search the container of the player for things
		i = FindApartmentalThing(child((+ My Apartment +)), i);

		! Pick a random thing out of all found and return it
		! I'm reusing Table of Inventory Ordering for this until somebody tells me not to
		if ( i > 0)
			thing = ((+ Table of Inventory Ordering +)-->2)-->(random(i)+COL_HSIZE);

		return thing;
	];

	[ FindApartmentalThing start i o;
		!loop through everything in start object
		for (o=start : o : i++ ) {

			if (~~(o ofclass (+ person +))) {
				if (i >= 100) return 100;
				((+ Table of Inventory Ordering +)-->2)-->(i+COL_HSIZE) = o;
				i++;
				if (i >= 100) return 100;
			}
			!Check any components recursively
			if (o.component_child)
				i = FindApartmentalThing(o.component_child, i);

			! Don't look inside closed containers or the backpack
			if (child(o) &&  ~~(o has openable && o hasnt open) && ~~(o == (+ the backpack +) )) o = child(o);
			else
				while (o) {
					if (sibling(o)) { o = sibling(o); break; }

					o = parent(o);
					if ( o == parent(start)) return i;
				}
		}
		return i;
	];

-) after "Output.i6t".


Custom Speedups ends here.
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP Take 3, ARM OMAP1 platform support 3/5
Date: Sun, 30 Jul 2006 18:58:51 -0700
Message-ID: <200607301858.52096.david-b@pacbell.net>
References: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>
	<200607261728.40443.david-b@pacbell.net>
	<44CD0937.6060905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44CD0937.6060905@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: Matthew Locke <matt@nomadgs.com>, patrick.mochel@intel.com, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Sunday 30 July 2006 12:32 pm, Eugeny S. Mints wrote:

> > Whereas I say that arch dependent is arch dependent ... unless
> > that "core" is indirecting through "struct powerop_point *", the
> > interface doesn't include the struct at all.  Ergo my comment.
> >
> >   =

> Let me try to set it this way.
> struct powerop_point is an arch independent piece in the sense that any =

> platform
> which leverages PorewOP concept should implement struct powerop_point.
> struct powerop_point is fundamental component that has to be defined by
> a platfrom.

We're not communicating here ... if the contents are arch-specific,
it doesn't matter to the interface except that it exist.  A better
way to define it would be:

	struct powerop_point {
		struct kobject	kobj;
		void		*arch_hook;
		// presumably there will be method hooks too, like
		int		(*enter_prepare)(struct powerop_point *);
		int		(*enter)(struct powerop_point *);
		int		(*enter_complete)(struct powerop_point *);
	};

where that "void *" is the entire arch hook, and the kobj holds the
name and represents the /sys/power/... directory for that arch.

(Those methods are just placeholders for what might be needed; the
prepare might suspend certain devices, the complete might resume
them with different underlying clock or voltage availability, and
the enter would change voltage, clocks, and whatever else.)


> In this way struct powerop_point _is_ part of PowerOP interface .
> Let me refer to the picture of proposed framework as well. PowerOP is
> interface between PM Core and any upper layer in the framework. Pushing
> power parameters definition down to PM Core interface (into some patch wi=
th
> a name related to pm core rather than to PowerOP) makes understanding
> of the framework layers much harder IMO.

If the arch wants to expose parameters for a given operating point,
that'd be its own responsibility ... and trivial, there's lots of
utility code to do that.


> If you are  referring to the certain implementation let assume that I put
> "struct powerop_point;" instead of inclusion of 'asm/powrop.h' in
> include/linux/powerop.h file.

I'd rather assume something as shown above ... something where it's
reasonable for the core to access the struct, if its declaration
must for whatever reason be visible to the core.  :)


> This way you get a compilable arch independent powerop core
> piece but let me ask what for? To allow arch independent powerop core
> to be standalone compilable?

Call it "information hiding" or "clean interface design".  There's
no reason for the core to know _anything_ about the arch-specific
details.  You've set it up so they will, which means that the code
will probably evolve to try using that information.  This should be
a loosely coupled interface, not a tightly coupled one.

One artifact of an effective loosely coupled interface design is
that it's easy to completely revamp the implementation of one of
the coupled components without changing the other.  In this case,
one component is (minimal) core code, the other is platform specific
code implementing each operating point.


> It's just useless: if the arch you are  =

> building for
> does not implement definition of struct powerop_point you just  defer
> compilation error to the link phase. Currently you can chose PowerOP
> core only if you chose an arch which implements arch dependent piece
> of PowerOP.

It's very useful.  How could you have modules defining new operating
points, with new parameters, with tight coupling?  Surely it should
be possible to link every operating point except the initial "system
startup" point dynamically, using kernel modules?

(That bootstrap issue needs looking at too.  I think there may well
need to be an arch independent initial operating point.  That's a
topic for a different thread though.)

 =


> >>>  - In general, shouldn't an operating point be board-specific, so
> >>>    that the parts of the system outside the SOC can be included
> >>>   =

> >>>       =

> >> good question. Basically current assumption is that definition is for =
an SoC
> >> and the values are board specific. While definition will most likely b=
e the
> >> same for every board based on a certain SoC I can imaging for example
> >> that we can have an external clock source for an external hw on a boar=
d.
> >>     =

> >
> > I agree that parts of an OP will merit that approach.  But ... the SOC
> > is not the only system component that needs managing, and it won't alwa=
ys
> > be practical to shuffle the others under the "device-specfic PM" tent.
> >
>  =

> OK, I am almost ready to buy this per SoC and per baord-specific OP =

> definition approach.

Code can come later.  :)


> But let me ask first whether you have at least one example of  =

> a platform which fits into this model nowadays?

Certainly.  Any two boards using the same SOC but different
external circuitry would naturally fit that model ... be they
OMAP boards, or PXA ones, or Atmel ones, etc.


> >> Since that  powerop_point structure definition could be board specific
> >> but that's where I'd prefer to get some input from the community to
> >> decide whether we have to move to board specific operating point
> >> structure definition.
> >>     =

> >
> > My input:  make it easy to partition things into components.  One way
> > to do that might be to have an SOC component, multiple device component=
s,
> > and a board-specific glue component that connects them in the right way.
> >
> >   =

> please elaborate multiple device components.

Considering only OMAP boards ... there are a variety of different
power management chips, audio chips, touchscreen controllers, and
backlight arrangements.  It's reasonable to expect that two points
differ in which of those may be active.

- Dave

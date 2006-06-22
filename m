From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 23 Jun 2006 08:43:41 +1000
Message-ID: <1151016222.4046.44.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> Our problem is that it's damn hard to debug the mess, AND A LARGE PART OF =

> THAT IS THAT STUPID INTERFACE!

Ugh ?

> Let's revisit why I want to do as much _independently_ of actually callin=
g =

> suspend() on a device again:
> =

>  - debugging is basically impossible during the _actual_ suspend sequence.
> =

> This is why we want to (nay, NEED) to split that "suspend()" function up, =

> so that it doesn't do five different things. The more we can do _outside_ =

> of suspend(), the better. Exactly because suspend() is a total bitch to =

> debug, and because in order to actually do things like printk() and use =

> netconsole, we want to minimize the amount of code that gets run in that =

> state.

I call that bullshit. Sorry Linus, but the problem _is_ in what
suspend() has to do. You just can't say you'll move it out just so you
can debug etc... It's in there because it has to be there. There is no
sane way around it. As you mentioned yourself, in many cases, that
save_state thing you talked about will do nothing... It's NOT state
saving that is either hard or bug prone. It's suspend itself.

> So I simply DO NOT CARE about stupid people doing operations that change =

> the state of a device at the same time as a suspend. It's so far off my =

> radar that it's not even funny. If you do something stupid, and the =

> machine doesn't come up, it's YOUR fault.

NO ! It's not. Because people do not know, subsystems do now know,
userland does not know, that suspend is in progress, and those
operations can be part of _NORMAL_ device activity, they aren't only
things like "user did hdparm to tweak his timings". Again, I've taken
the time of slicing the actual states and describing what happen for
each kind. The third kind, dynamic state is the problem. You can't just
ignore it by saying "don't change it" if you don't provide some kind of
infrastructure to notify all clients and fix them all not to change
it ... and that will be a bitch with dynamic PM. =


> I want the machine to come back when you _don't_ do anything stupid, and =

> in order to do that, we need to make the suspend sequence more debuggable.
>
> What I actually _care_ about is that I can have drivers do "printk()" in =

> their "save_state()" routines, and we can have a debug mode that logs the=
m =

> to disk, and even do a "sync()" before the suspend() that hangs the =

> machine, and we can get a f*cking clue about what is so special about tha=
t =

> machine that it never comes back.

But as we noted before, there is really nothing that matters in
save_state() ! Those printk's I bet won't help you at all

> And there's NOT A WAY IN HELL we can do that with the current setup, =

> exactly because the current "suspend()" does five different things,

No, it does three things. Suspend the driver and the device, atomically
as viewed from the outside (or rather driver first, device next), and
save the necessary state if any (which most of the time is non except
the PCI config space and that is trivial, after we _FINALLY_ fixed the
stupid bug we had in there of doing the restore in the wrong order).

> and trying to log anything even half-way informative at all (even to scre=
en, =

> but much less to network or to disk) is just not going to work at all, =

> because by the time we hit half the devices, we've have done things that =

> make logging impossible.

But it will not work ANYWAY. The real problem is in suspend. Not
save_state. Period.

> The actual final suspend() action will always be that way. There's nothin=
g =

> we can do about that (although my other patch - the [1/2] int he series =

> that became the start of this thread - tries to at least put some =

> infrastructure in place for that too). But we can sure as hell try to =

> split that undebuggable section up, and at least make slightly _more_ of =

> it debuggable.

So you'll break the entire model, introducing new problems due to
possible loss of state etc etc etc... just to be able to printk in a
save_state() step that does nothing interesting in most cases anyway ?

Ben.

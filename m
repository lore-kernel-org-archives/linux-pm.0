From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 12:23:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<200606221130.30614.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606221130.30614.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Thu, 22 Jun 2006, David Brownell wrote:

> On Thursday 22 June 2006 9:10 am, Linus Torvalds wrote:
> > =

> > The fact that worries me is that suspend-to-ram DOES NOT WORK FOR PEOPL=
E. =

> > I have never _ever_ met a laptop or machine of mine that "just worked". =

> > I've always had to fix something, and people always end up having to do =

> > something ridiculous like unlink all modules etc.
> =

> And when I've looked at the causes of such problems, they've been
> either (a) driver bugs, or (b) ACPI bugs.  As you know, both of
> them are hard to debug, especially when the symptom is on resume
> paths with no console.  (Oooh, see $SUBJECT, this isn't offtopic!!)

EXACTLY.

We're back to square one.

The #1 problem _by_far_ with suspend has absolutely ZERO to do with =

suspend being "hard", block device queues, or how to save driver state per =

se.

Each individual driver tends to be fairly easy to fix, I'd say. I suspect =

that even USB in the end is just a "Small Matter Of Programming", but it's =

a total bitch to debug.

Our problem is that it's damn hard to debug the mess, AND A LARGE PART OF =

THAT IS THAT STUPID INTERFACE!

Let's revisit why I want to do as much _independently_ of actually calling =

suspend() on a device again:

 - debugging is basically impossible during the _actual_ suspend sequence.

This is why we want to (nay, NEED) to split that "suspend()" function up, =

so that it doesn't do five different things. The more we can do _outside_ =

of suspend(), the better. Exactly because suspend() is a total bitch to =

debug, and because in order to actually do things like printk() and use =

netconsole, we want to minimize the amount of code that gets run in that =

state.

So I simply DO NOT CARE about stupid people doing operations that change =

the state of a device at the same time as a suspend. It's so far off my =

radar that it's not even funny. If you do something stupid, and the =

machine doesn't come up, it's YOUR fault.

I want the machine to come back when you _don't_ do anything stupid, and =

in order to do that, we need to make the suspend sequence more debuggable.

What I actually _care_ about is that I can have drivers do "printk()" in =

their "save_state()" routines, and we can have a debug mode that logs them =

to disk, and even do a "sync()" before the suspend() that hangs the =

machine, and we can get a f*cking clue about what is so special about that =

machine that it never comes back.

And there's NOT A WAY IN HELL we can do that with the current setup, =

exactly because the current "suspend()" does five different things, and =

trying to log anything even half-way informative at all (even to screen, =

but much less to network or to disk) is just not going to work at all, =

because by the time we hit half the devices, we've have done things that =

make logging impossible.

The actual final suspend() action will always be that way. There's nothing =

we can do about that (although my other patch - the [1/2] int he series =

that became the start of this thread - tries to at least put some =

infrastructure in place for that too). But we can sure as hell try to =

split that undebuggable section up, and at least make slightly _more_ of =

it debuggable.

			Linus

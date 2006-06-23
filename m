From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 11:06:46 -0700
Message-ID: <200606231106.46863.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday 22 June 2006 12:23 pm, Linus Torvalds wrote:
> =

> On Thu, 22 Jun 2006, David Brownell wrote:
> =

> > On Thursday 22 June 2006 9:10 am, Linus Torvalds wrote:
> > > =

> > > The fact that worries me is that suspend-to-ram DOES NOT WORK FOR PEO=
PLE. =

> > > I have never _ever_ met a laptop or machine of mine that "just worked=
". =

> > > I've always had to fix something, and people always end up having to =
do =

> > > something ridiculous like unlink all modules etc.
> > =

> > And when I've looked at the causes of such problems, they've been
> > either (a) driver bugs, or (b) ACPI bugs.  As you know, both of
> > them are hard to debug, especially when the symptom is on resume
> > paths with no console.  (Oooh, see $SUBJECT, this isn't offtopic!!)
> =

> EXACTLY.
> =

> We're back to square one.
> =

> The #1 problem _by_far_ with suspend has absolutely ZERO to do with =

> suspend being "hard", block device queues, or how to save driver state pe=
r =

> se.
> =

> Each individual driver tends to be fairly easy to fix, I'd say. I suspect =

> that even USB in the end is just a "Small Matter Of Programming", but it'=
s =

> a total bitch to debug.

Actually, testing is more of a problem, given the 2^(about 8) different
configurations, with different fault paths in each.  That one is never
going away, while the "is printk available" issue has at least had some
system-specific workarounds.


> Our problem is that it's damn hard to debug the mess, AND A LARGE PART OF =

> THAT IS THAT STUPID INTERFACE!

Specifically, that the interface de-facto includes "printk unavailable"
during interesting sequence like resume, so there's no way to see what
broke and when.


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

Seriously, suspend() tends to be less of a problem than resume().  Which
is why I'm lukewarm to notions of refactoring suspend().

Going from a first-principles model based approach, the conceptual issue
is that providing a console has to date been purely a side effect of the
driver model suspend and resume sequences.  There are multiple sequences
of driver suspend/resume calls which observe the parent/child constraints,
but there's no effort to keep a consoles maximally active.

- Dave

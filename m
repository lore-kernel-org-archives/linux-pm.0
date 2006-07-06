From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 6 Jul 2006 03:15:10 +0200
Message-ID: <20060706011510.GC5303@elf.ucw.cz>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607051140.14194.david-b@pacbell.net>
	<Pine.LNX.4.64.0607051305070.12404@g5.osdl.org>
	<200607051603.29787.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607051603.29787.david-b@pacbell.net>
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
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed 2006-07-05 16:03:29, David Brownell wrote:
> On Wednesday 05 July 2006 1:12 pm, Linus Torvalds wrote:
> > =

> > On Wed, 5 Jul 2006, David Brownell wrote:
> > > =

> > > I expect this is what you meant, but one issue I've observed
>                     ^ "NOT" ... omitted by editing error, sorry
> > > on at least one platform is that after swsusp resume the preempt
> > > count is goofed ... it's one too big.  Which in a recent test, meant
> > > that resume failed because pci_set_power_state() got called in a
> > > context that couldn't msleep().  And in previous tests has led to
> > > similar failures, since resume() calls all expect sleeping is OK
> > > (since that's part of that API contract).
> > =

> > Yes. =

> > =

> > I had a patch that did
> > =

> > 	system_state =3D SYSTEM_BOOTING;
> > 	..
> > 	system_state =3D SYSTEM_RUNNING;
> > =

> > around the final stages of suspend/resume, because the resume stage rea=
lly =

> > _does_ end up looking like the boot: single CPU, various special code e=
tc.
> > =

> > And that gets rid of some of the warnings, and is arguably a valid thin=
g =

> > to do (exactly because it's "true" to some degree that we're in the boo=
tup =

> > state).
> =

> Didn't try that.  In this case, debug diagnostics confirmed that what
> was happening was pretty strange (to me):  the preempt count was goofed.
> It was correct as the snapshot was being taken, but wrong after that
> snapshot got resumed.

I have seen that before: Atomic snapshot used fpu copy in some wrong
variants. Symptom was exactly that -- elevated preempt count --
because fpu copy routine elevated it, then copied the task struct.

But I thought we solved that problem...?
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

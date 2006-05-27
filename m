From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-usb-devel] Re: [patch/rft 2.6.17-rc2] swsusp
	resume must not device_suspend()
Date: Sat, 27 May 2006 16:38:37 +0000
Message-ID: <20060527163837.GE4242@ucw.cz>
References: <200604241429.52022.david-b@pacbell.net>
	<200605252006.06866.david-b@pacbell.net>
	<20060526231628.GA9284@elf.ucw.cz>
	<200605261719.57601.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200605261719.57601.david-b@pacbell.net>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi!

> > > 		 the patch appended
> > > here shows what I'm pursuing.  Same calling convention, new PRETHAW m=
essage
> > > that "pm-naive" drivers (most of them!) can handle just like FREEZE.
> > > =

> > > Other than this, it affects about 20 files with about 2/3 being drive=
rs; say
> > > that maybe 5% of all in-tree drivers needed trivial changes, most of =
which
> > > could count as bugfixes _before_ defining the new message.
> > =

> > Okay, so you changed the interface, and it needed fixing at 16 places.
> =

> Not what I said ... in many of those places, the driver code was already =
dubious.
> Making the event code __bitwise would have helped catch those errors.

Yep, __bitwise (+ someone using sparse :-) would be nice.

> > > + * PRETHAW	Quiesce as if for FREEZE; additionally, prepare for resto=
ring
> > > + * 		the system from a snapshot taken after an earlier FREEZE.
> > > + * 		Some drivers will need to reset their hardware state instead
> > > + * 		of preserving it, to ensure that it's never mistaken for the
> > > + * 		state which that earlier snapshot had set up.
> > =

> > And you *do* realize that PRETHAW is like a FREEZE... So... can we use
> > FREEZE, and add aditional flag field that says it is preTHAW?
> =

> Of course, FREEZE is like a SUSPEND, and SUSPEND is the only behavior tha=
t's
> required of all drivers, or which most drivers understand.  So why did yo=
u not
> implement FREEZE as a flag in the first place, if you like that model?  :)
> =

> Most drivers treat all suspend() messages as SUSPEND anyway; mesg.event w=
as
> already little more than a fancy flag (SUSPEND vs FREEZE).  We only need
> three transition types (so far), not four (flag x flag =3D=3D> 4 states).

Okay, I still don't 100% like it, but it makes some sense and I think
we can live with PREFREEZE.

> > This will result in if (message =3D=3D FREEZE || message =3D=3D PRETHAW=
) that
> > is kind-of ugly.
> =

> switch (mesg.event) { ... } for the few drivers that actually care about
> more than one of the transitions.  Only a handful need to care about more
> than whether it's a real SUSPEND or not.

Okay, you are right that suspend and freeze are similar, too. Can you
retransmit the patch?
							Pavel
-- =

Thanks for all the (sleeping) penguins.

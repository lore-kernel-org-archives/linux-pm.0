From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [patch/rft 2.6.17-rc2] swsusp
	resume must not device_suspend()
Date: Fri, 26 May 2006 17:19:54 -0700
Message-ID: <200605261719.57601.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200605252006.06866.david-b@pacbell.net>
	<20060526231628.GA9284@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060526231628.GA9284@elf.ucw.cz>
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
To: linux-usb-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 26 May 2006 4:16 pm, Pavel Machek wrote:
> =

> > 		 the patch appended
> > here shows what I'm pursuing.  Same calling convention, new PRETHAW mes=
sage
> > that "pm-naive" drivers (most of them!) can handle just like FREEZE.
> > =

> > Other than this, it affects about 20 files with about 2/3 being drivers=
; say
> > that maybe 5% of all in-tree drivers needed trivial changes, most of wh=
ich
> > could count as bugfixes _before_ defining the new message.
> =

> Okay, so you changed the interface, and it needed fixing at 16 places.

Not what I said ... in many of those places, the driver code was already du=
bious.
Making the event code __bitwise would have helped catch those errors.


> > + * Other transitions are triggered by messages sent using suspend().  =
All
> > + * these transitions quiesce the driver, so that I/O queues are inacti=
ve.
> > + * That commonly entails turning off IRQs and DMA; there may be rules
> > + * about how to quiesce that are specific to the bus or the device's t=
ype.
> > + * (For example, network drivers mark the link state.)  Other details =
may
> > + * differ according to the message:
> > + *
> > + * SUSPEND	Quiesce, enter a low power device state appropriate for
> > + * 		the upcoming system state (such as PCI_D3hot), and enable
> > + * 		wakeup events as appropriate.
> > + *
> > + * FREEZE	Quiesce operations so that a consistent image can be saved;
> > + * 		but do NOT otherwise enter a low power device state, and do
> > + * 		NOT emit system wakeup events.
> > + *
> > + * PRETHAW	Quiesce as if for FREEZE; additionally, prepare for restori=
ng
> > + * 		the system from a snapshot taken after an earlier FREEZE.
> > + * 		Some drivers will need to reset their hardware state instead
> > + * 		of preserving it, to ensure that it's never mistaken for the
> > + * 		state which that earlier snapshot had set up.
> =

> And you *do* realize that PRETHAW is like a FREEZE... So... can we use
> FREEZE, and add aditional flag field that says it is preTHAW?

Of course, FREEZE is like a SUSPEND, and SUSPEND is the only behavior that's
required of all drivers, or which most drivers understand.  So why did you =
not
implement FREEZE as a flag in the first place, if you like that model?  :)

Most drivers treat all suspend() messages as SUSPEND anyway; mesg.event was
already little more than a fancy flag (SUSPEND vs FREEZE).  We only need
three transition types (so far), not four (flag x flag =3D=3D> 4 states).

Plus, I'd never add flags to that structure.  I've elaborated some of the r=
easons
why not in the past, and I won't repeat that here; it's basically a bad ide=
a,
wastes data and code space, is an error prone and ugly state machine design
practice, and so forth.


> This will result in if (message =3D=3D FREEZE || message =3D=3D PRETHAW) =
that
> is kind-of ugly.

switch (mesg.event) { ... } for the few drivers that actually care about
more than one of the transitions.  Only a handful need to care about more
than whether it's a real SUSPEND or not.

- Dave

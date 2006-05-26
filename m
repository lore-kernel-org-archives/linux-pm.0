From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Sat, 27 May 2006 01:16:28 +0200
Message-ID: <20060526231628.GA9284@elf.ucw.cz>
References: <200604241429.52022.david-b@pacbell.net>
	<200604271241.28944.david-b@pacbell.net>
	<20060502161208.GC9337@linux.intel.com>
	<200605252006.06866.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200605252006.06866.david-b@pacbell.net>
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

> > It's Ok if it involves a drive change, so long as its an optional chang=
e, which
> > means that it shouldn't affect the interface very much (i.e. the callin=
g =

> > convention). That's why it'd be good to augment and/or modify pm_messag=
e_t
> > to implement the changes, so we wouldn't have to change every single dr=
iver
> > again.. =

> =

> I'll post more patches after I sort out some oddness -- why is swsusp_sus=
pend()
> leaving preempt_count() =3D=3D 1, code I was nowhere near? -- but the pat=
ch appended
> here shows what I'm pursuing.  Same calling convention, new PRETHAW messa=
ge
> that "pm-naive" drivers (most of them!) can handle just like FREEZE.
> =

> Other than this, it affects about 20 files with about 2/3 being drivers; =
say
> that maybe 5% of all in-tree drivers needed trivial changes, most of which
> could count as bugfixes _before_ defining the new message.

Okay, so you changed the interface, and it needed fixing at 16 places.


> @@ -143,29 +143,61 @@ typedef struct pm_message {
>  } pm_message_t;
>  =

>  /*
> - * There are 4 important states driver can be in:
> - * ON     -- driver is working
> - * FREEZE -- stop operations and apply whatever policy is applicable to a
> - *           suspended driver of that class, freeze queues for block lik=
e IDE
> - *           does, drop packets for ethernet, etc... stop DMA engine too=
 etc...
> - *           so a consistent image can be saved; but do not power any ha=
rdware
> - *           down.
> - * SUSPEND - like FREEZE, but hardware is doing as much powersaving as
> - *           possible. Roughly pci D3.
> - *
> - * Unfortunately, current drivers only recognize numeric values 0 (ON) a=
nd 3
> - * (SUSPEND).  We'll need to fix the drivers. So yes, putting 3 to all d=
ifferent
> - * defines is intentional, and will go away as soon as drivers are fixed=
.  Also
> - * note that typedef is neccessary, we'll probably want to switch to
> - *   typedef struct pm_message_t { int event; int flags; } pm_message_t
> - * or something similar soon.
> + * Several driver power state transitions are externally visible, affect=
ing
> + * the state of pending I/O queues and (for drivers that touch hardware)
> + * interrupts, wakeups, and other hardware state.  There may also be
> + * internal transitions to various low power modes, which are transparent
> + * to the rest of the driver stack (such as a driver that's ON gating off
> + * clocks which are not in active use).
> + *
> + * One transition is triggered by resume(), after a suspend() call; the
> + * message is implicit:
> + *
> + * ON		Driver starts working again, responding to hardware events
> + * 		and software requests.  The hardware may have gone through
> + * 		a power-off reset, or it may have maintained state from the
> + * 		previous suspend() which the driver will rely on while
> + * 		resuming.  On most platforms, there are no restrictions on
> + * 		availability of resources like clocks during resume().
> + *
> + * Other transitions are triggered by messages sent using suspend().  All
> + * these transitions quiesce the driver, so that I/O queues are inactive.
> + * That commonly entails turning off IRQs and DMA; there may be rules
> + * about how to quiesce that are specific to the bus or the device's typ=
e.
> + * (For example, network drivers mark the link state.)  Other details may
> + * differ according to the message:
> + *
> + * SUSPEND	Quiesce, enter a low power device state appropriate for
> + * 		the upcoming system state (such as PCI_D3hot), and enable
> + * 		wakeup events as appropriate.
> + *
> + * FREEZE	Quiesce operations so that a consistent image can be saved;
> + * 		but do NOT otherwise enter a low power device state, and do
> + * 		NOT emit system wakeup events.
> + *
> + * PRETHAW	Quiesce as if for FREEZE; additionally, prepare for restoring
> + * 		the system from a snapshot taken after an earlier FREEZE.
> + * 		Some drivers will need to reset their hardware state instead
> + * 		of preserving it, to ensure that it's never mistaken for the
> + * 		state which that earlier snapshot had set up.

And you *do* realize that PRETHAW is like a FREEZE... So... can we use
FREEZE, and add aditional flag field that says it is preTHAW?

This will result in if (message =3D=3D FREEZE || message =3D=3D PRETHAW) th=
at
is kind-of ugly.

Now, you are right that you only needed to fix 16 places, so it is not
_that_ bad...

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

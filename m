From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 17 Jun 2006 09:04:08 +1000
Message-ID: <1150499049.23600.72.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606161135280.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606161135280.5498@g5.osdl.org>
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

On Fri, 2006-06-16 at 11:45 -0700, Linus Torvalds wrote:
> =

> On Fri, 16 Jun 2006, Linus Torvalds wrote:
> > =

> > ie I think it's literally an "outl()" followed by a "udelay()", and the=
re =

> > is basically _zero_ room for problems. The "unfreeze" is then just =

> > setting the "run controller" bit again.
> =

> Something like
> =

> 	/*
> 	 * Used to temporarily stop all activity.
> 	 */
> 	static void freeze_uhci(struct uhci_hcd *uhci)
> 	{
> 		u16 cmd;
> =

> 		if (uhci->is_stopped)
> 			return;
> 		cmd =3D inw(uhci->io_addr + USBCMD) & ~USBCMD_RS;
> 		outw(cmd, uhci->io_addr + USBCMD);
> 		udelay(1);
> 	}
> =

> 	static void unfreeze_uhci(struct uhci_hcd *uhci)
> 	{
> 		u16 cmd;
> 		if (uhci->is_stopped)
> 			return;
> 		cmd =3D inw(uhci->io_addr + USBCMD) | USBCMD_RS;
> 		outw(cmd, uhci->io_addr + USBCMD);
> 	}
> =

> would seem to be enough, if the caller also guarantees that interrupts ar=
e =

> off during this (which you'd also want regardless, I assume).

Well, you also need to synchronize with other things trying to re-enable
queue processing (I don't know secifically about UHCI here but there may
be issues with OHCI) and other things like that...  (root hub activity,
urb processing, etc....)

Depending on the device, the "frozen" state may cause all sort of
troubles if requests come in and no protection against that are taken.
Granted freezing userland helps for some of that (though one would have
to freeze also things like kernel nfs server, prevent filesystem
read-ahead, etc...), but you know how intricated some drivers can be... =


Thus you end up with something quite similar to a full suspend ...
except the power off part. That is you stop processing of queues and
stop the hardware from DMA'ing. That is something simple for network
drivers and more complicated for various others...

That's why having a simple parameter to suspend() indicating wether you
want a full suspend or just a freeze works well in most cases: The
driver author doesn't have to think too much about it and can default to
suspend (suboptimal but works). I think it makes things easier on the
driver side of things.

In fact, if we implement the prepare() step we discussed and we also
make sure, as I proposed, that "bus drivers" do not hotplug new devices
in between prepare() and finish(), that will handle part of the problem
for STD as well: the hub driver of USB would be esssentially "stopped"
by prepare() (at least stopped from a device insertion point of view),
thus limiting the issues with both suspend and freeze later on
(sycnhronisation with the root hub for example has been typically
annoying to deal with in the past). =


> For a number of simple devices, just disabling interrupts guarantees that =

> they won't do anything, but busmasters obviously need to be told to stop =

> their BM engine (which is what the above should do for UHCI).

Yes but various code path in drivers tend to re-enable interrupts or
re-enabling DMA processing, it's not _that_ simple... in the end, as I
said, the necessary driver code to acheive that end up being very
similar if not identical to what is needed for suspend.

> Of course, these days EHCI etc is probably more interesting than UHCI, bu=
t =

> I only personally worked with UHCI, so I don't know the details, but I =

> assume it has a similar "run" bit in some command register.
> =

> My point is, this has nothing to do with _suspending_ the device.

No, but it's about suspending the _driver_. My point is that suspending
the device and suspending the driver are 2 different things. STR
involves both, STD involves only the driver. However, because of the
dependency on parent devices, they always have to be done at the same
time.

Ben.

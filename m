From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Request for testing remote wakeup during STD
Date: Sun, 11 Feb 2007 14:44:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0702111406320.18883-100000@netrider.rowland.org>
References: <1171140730.30705.28.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171140730.30705.28.camel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 11 Feb 2007, Nigel Cunningham wrote:

> Hi.
> =

> On Sat, 2007-02-10 at 12:08 -0500, Alan Stern wrote:
> > On Sat, 10 Feb 2007, Nigel Cunningham wrote:
> > =

> > > Hi Alan.
> > =

> > > I'd love to be able to help you. My lappy loads ehci and lsusb shows =
the
> > > controller, but I'll be darned if I can find the socket! I have other
> > > things to get done right now, but if no-one beats me to it, I'll try =
the
> > > desktop I have - I think that has ehci somewhere.
> > =

> > Thanks, Nigel.  You mean your laptop has an EHCI controller but no USB
> > ports?  That's odd...
> =

> Yeah. I have three USB ports on it, but two of them seem to be connected
> to one controller (going by lsusb after plugging my Palm into each of
> them).

The contents of /proc/bus/usb/devices would be easier to read.
Nevertheless, here's a capsule explanation:

Most high-speed USB host controllers aren't capable of supporting full
speed or low speed.  In order to make a completely functional system,
vendors have to pair each high-speed controller with a companion
full-and-low-speed controller.  USB ports are wired internally to both
controllers, and an electronic switch decides which controller actually
manages the port at any time, based on the speed of the device plugged
into the port.

Sometimes a single high-speed controller will have more than one
companion.  For example, each companion controller might handle only two
ports while the high-speed controller can handle six; in that case there
would have to be three companions.

And sometimes controllers aren't connected to anything at all!  For
example, I've got a PCI USB card on my machine.  It contains 1 EHCI (high
speed) controller capable of handling six ports and 3 OHCI (full and low
speed) each capable of handling two ports, as described above.  But the
card has only 4 ports!  Each port is connected to the EHCI controller and
to one of the OHCI controllers, and one OHCI is connected to nothing.  =

The card is a cut-down version of a 6-port model, and the manufacturer
simply removed two of the ports while leaving the third OHCI controller on
board.

As another example, my motherboard has three USB ports and three OHCI =

controllers, each of which is capable of driving two ports but is wired up =

only to one.

> > Anyway, here are instructions for you or anyone else who can do the tes=
t.  =

> > (I forgot to include them in the original message.)  Running the test
> > involves two steps.
> > =

> > The first step is to check that an unpatched system supports Wake-on-US=
B.  =

> > This means enabling it in the BIOS and/or in ACPI (whatever that might
> > entail; I have no idea what's needed) and actually trying it out.  Eith=
er
> > plugging or unplugging a USB device while the system is in STD should w=
ake
> > the machine up.
> > =

> > The second step is to see whether Wake-on-USB continues to work after
> > applying the patch mentioned previously.  That's the real question.
> > =

> > It may turn out that _nobody_ has Wake-on-USB working at all... in whic=
h =

> > case we'd have a different problem to solve.
> =

> Thanks!

On further thought, I wonder if this could ever work reliably.  During =

suspend-to-disk, after the memory snapshot is created every device is =

woken up to write out the image (or at least, every device that was awake =

before the suspend-to-disk started).  The image is written and then the =

system shuts down, without bothering to suspend anything.

Now I don't know about other subsystems, but in USB we disable remote
wakeup when a device is resumed and enable it when the device is
suspended.  Since the sequence of events is <resume, write image,
shutdown> with no intervening suspend, remote wakeup will not be enabled.

That's true for external devices, anyway.  For devices on the motherboard, =

like host controllers, it's entirely possible that the firmware uses some =

other technique to control remote wakeup (something involving ACPI, for =

example).  Documentation on this point is almost non-existent, so it's =

kind of hard to say anything definite.

This suggests that I shouldn't worry about remote wakeup during
suspend-to-disk at all -- it's a lost cause.

Alan Stern

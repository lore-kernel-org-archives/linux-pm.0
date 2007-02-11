From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Request for testing remote wakeup during STD
Date: Sun, 11 Feb 2007 22:43:08 +0100
Message-ID: <200702112243.09335.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0702111406320.18883-100000@netrider.rowland.org>
	<1171225701.4493.38.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171225701.4493.38.camel@nigel.suspend2.net>
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
To: linux-pm@lists.osdl.org, nigel@nigel.suspend2.net
List-Id: linux-pm@vger.kernel.org

On Sunday, 11 February 2007 21:28, Nigel Cunningham wrote:
> Hi.
> =

> On Sun, 2007-02-11 at 14:44 -0500, Alan Stern wrote:
> > On Sun, 11 Feb 2007, Nigel Cunningham wrote:
> > =

> > > Hi.
> > > =

> > > On Sat, 2007-02-10 at 12:08 -0500, Alan Stern wrote:
> > > > On Sat, 10 Feb 2007, Nigel Cunningham wrote:
> > > > =

> > > > > Hi Alan.
> > > > =

> > > > > I'd love to be able to help you. My lappy loads ehci and lsusb sh=
ows the
> > > > > controller, but I'll be darned if I can find the socket! I have o=
ther
> > > > > things to get done right now, but if no-one beats me to it, I'll =
try the
> > > > > desktop I have - I think that has ehci somewhere.
> > > > =

> > > > Thanks, Nigel.  You mean your laptop has an EHCI controller but no =
USB
> > > > ports?  That's odd...
> > > =

> > > Yeah. I have three USB ports on it, but two of them seem to be connec=
ted
> > > to one controller (going by lsusb after plugging my Palm into each of
> > > them).
> > =

> > The contents of /proc/bus/usb/devices would be easier to read.
> > Nevertheless, here's a capsule explanation:
> > =

> > Most high-speed USB host controllers aren't capable of supporting full
> > speed or low speed.  In order to make a completely functional system,
> > vendors have to pair each high-speed controller with a companion
> > full-and-low-speed controller.  USB ports are wired internally to both
> > controllers, and an electronic switch decides which controller actually
> > manages the port at any time, based on the speed of the device plugged
> > into the port.
> > =

> > Sometimes a single high-speed controller will have more than one
> > companion.  For example, each companion controller might handle only two
> > ports while the high-speed controller can handle six; in that case there
> > would have to be three companions.
> > =

> > And sometimes controllers aren't connected to anything at all!  For
> > example, I've got a PCI USB card on my machine.  It contains 1 EHCI (hi=
gh
> > speed) controller capable of handling six ports and 3 OHCI (full and low
> > speed) each capable of handling two ports, as described above.  But the
> > card has only 4 ports!  Each port is connected to the EHCI controller a=
nd
> > to one of the OHCI controllers, and one OHCI is connected to nothing.  =

> > The card is a cut-down version of a 6-port model, and the manufacturer
> > simply removed two of the ports while leaving the third OHCI controller=
 on
> > board.
> > =

> > As another example, my motherboard has three USB ports and three OHCI =

> > controllers, each of which is capable of driving two ports but is wired=
 up =

> > only to one.
> > =

> > > > Anyway, here are instructions for you or anyone else who can do the=
 test.  =

> > > > (I forgot to include them in the original message.)  Running the te=
st
> > > > involves two steps.
> > > > =

> > > > The first step is to check that an unpatched system supports Wake-o=
n-USB.  =

> > > > This means enabling it in the BIOS and/or in ACPI (whatever that mi=
ght
> > > > entail; I have no idea what's needed) and actually trying it out.  =
Either
> > > > plugging or unplugging a USB device while the system is in STD shou=
ld wake
> > > > the machine up.
> > > > =

> > > > The second step is to see whether Wake-on-USB continues to work aft=
er
> > > > applying the patch mentioned previously.  That's the real question.
> > > > =

> > > > It may turn out that _nobody_ has Wake-on-USB working at all... in =
which =

> > > > case we'd have a different problem to solve.
> > > =

> > > Thanks!
> > =

> > On further thought, I wonder if this could ever work reliably.  During =

> > suspend-to-disk, after the memory snapshot is created every device is =

> > woken up to write out the image (or at least, every device that was awa=
ke =

> > before the suspend-to-disk started).  The image is written and then the =

> > system shuts down, without bothering to suspend anything.
> > =

> > Now I don't know about other subsystems, but in USB we disable remote
> > wakeup when a device is resumed and enable it when the device is
> > suspended.  Since the sequence of events is <resume, write image,
> > shutdown> with no intervening suspend, remote wakeup will not be enable=
d.
> > =

> > That's true for external devices, anyway.  For devices on the motherboa=
rd, =

> > like host controllers, it's entirely possible that the firmware uses so=
me =

> > other technique to control remote wakeup (something involving ACPI, for =

> > example).  Documentation on this point is almost non-existent, so it's =

> > kind of hard to say anything definite.
> > =

> > This suggests that I shouldn't worry about remote wakeup during
> > suspend-to-disk at all -- it's a lost cause.
> =

> Or we should change to suspend drivers rather than shutting them down,
> if that's possible.

I thought about the same thing.

Greetings,
Rafael

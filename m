From: David Brownell <david-b@pacbell.net>
Subject: Re: Suspended devices and drivers
Date: Sun, 04 Sep 2005 13:46:41 -0700
Message-ID: <20050904204641.8D1B2C1BF2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509041209570.29929-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============95112262954001414=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509041209570.29929-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============95112262954001414==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Date: Sun, 4 Sep 2005 12:13:58 -0400 (EDT)
> From: Alan Stern <stern@rowland.harvard.edu>
>
> Is there any recommendation about what to do when a driver is probed
> for a suspended device?

Sure; see below ("common solution").


>	Probably most drivers don't bother to check
> the device state; if they encounter errors because the device doesn't
> respond the way they expect, the probe will simply fail.  (The USB
> subsystem, for example, doesn't take this into account.)

Actually the USB HCDs do take that into account.  The "subsystem"
does as much as it can:  PCI HCDs have utilities to share.  The first
thing usb_hcd_pci_probe() routine does is call the pci_enable_device(),
which puts the HC in D0 state (assuming the HC supports PCI PM at all).
In fact that's much of _why_ that call is made so early ...

The non-PCI HCDs necessarily work a bit differently, and can't share
any bus-specific code; there can't be much of a "subsystem" role.


>		One possible
> answer is that this should be handled at the bus level -- the bus
> subsystem could be responsible for setting a device to full power
> before probing, or it could rely on individual device drivers doing
> whatever they need.  It would be nicer if a common solution could be
> found that would work uniformly for all devices and buses.

The common solution is what it's always been:  drivers make no
assumptions about initial device state, and are ready to initialize
from scratch in their probe() routines.

But as Ben and others may point out, that's not always possible.
On PCs, video drivers often rely on proprietary BIOS setup; and many
other drivers use information passed from boot firmare through chip
registers.  So there will be a few exceptions to any such rule.


>	(As part
> of such a solution, buses could have a standard policy that devices
> with no driver should be left in a low-power state.)

I'd like to see that "left in low power state" become a common policy,
but suspect it'd be awkward as a "must do".  "Should do", fine.

Sometimes the boot firmware won't implement that policy.  (So Linux
would need device-specific code to do that; oops that's a driver!)
Also, sometimes it'd involve chip docs Linux develoeprs don't have.


> A related problem is faced by USB drivers in a boot kernel.  The
> current design relies on USB devices maintaining their state across a
> suspend/resume, even suspend to disk.

I don't know any particular way they'd "rely" on that.  Modulo any
recent bugs, the transitions from a USB suspend state are either
(a) resuming, or (b) disconnecting.  You imply (b) won't happen.


>	This makes things difficult
> when resuming from disk; the boot kernel has to realize that it
> shouldn't disturb the state of any USB devices.  At the moment this
> isn't handled very well.  For instance, it would be largely a matter
> of luck if you could do STD with the image stored in a swap partition
> on a USB storage device.

I'm told that boot-from-USB (or reboot) still needs some work.  :)

Also, ome of the suspend/resume scenarios that worked a few kernels ago
stopped working.  We'll need those to work again first before adding new
configurations.


> In fact, maybe it's a mistake to expect USB devices to maintain their
> state across STD.  After all, devices on the motherboard aren't
> expected to;

They're certainly _allowed_ to do so though.  Some are quite expected
to, like the RTC ... and on many platforms, there'll be some SRAM
(typically 16+ KB) maintaining state during suspend/resume transitions
even when DRAM goes unpowered.

(Of course, powercycling is another story entirely.  And it's very
easy lately to confuse STD with the powercycling version of swsusp
snapshot-resume.  Those are quite different.)


>	it's generally accepted that drivers will restore
> whatever state is necessary as part of their resume procedure.

If the USB stack has actually suspended that device, that's appropriate.

If its port has been power cycled for any reason (including even just
unplug/replug) then it's impossible to resume; so usbcore must then
disconnect() not resume().  It'll later re-enumerate that port.


> Why shouldn't USB devices behave the same way?

USB _devices_ don't know STD from Adam.  All they know is whether they're
still suspended or not ... and the answer is NO unless both (a) VBUS
connectivity from the root hub has powered the link the whole time, which
is easy with true STD but not snapshot-resume; and (b) nobody's reset their
port, e.g. by power cycling the root hub or by some software initiated reset.

So a true system _suspend_ state should already be doing that.
Even suspend-to-disk.

But the poweroff snapshot-resume thing isn't the same thing; USB devices 
can't maintain suspend states when VBUS power gets dropped.  Those get
disconnected ... just like happens on _any_ hotpluggable bus segment.

- Dave



> Alan Stern
>


---
After the 1906 San Francisco quake, the first Federal aid arrived
within two hours.


--===============95112262954001414==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============95112262954001414==--

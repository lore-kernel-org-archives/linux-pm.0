From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 08:28:07 -0700
Message-ID: <20050928152807.19B67E36F3@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
	<1127855345.4802.13.camel@localhost> <20050927220110.GB2381@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============35900153114896938=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050927220110.GB2381@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@ucw.cz, ncunningham@cyclades.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============35900153114896938==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > > > > Later on, when the system wakes up and the image is restored,
> > > > > drivers are asked to
> > > > > resume the devices.  The problem is that now the drivers think 
> > > > > the devices are in FREEZE when in fact they are really in SUSPEND.
> > > > > The difference is significant and it can cause errors in the
> > > > > resume procedure.
> > > > 
> > > > No; devices are in FREEZE if their driver was in kernel, and in some kind
> > > > of power up state when not. Drivers should just handle both.
> > > 
> > > For USB, that "some kind of power up state" will in fact be SUSPEND.
> > 
> > Excuse me taking a step back, but I think you guys might be solving a
> > problem that doesn't exist...

I see the problem as being the latest definition of FREEZE:

  FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
  scratch. That probably means ...

  SUSPEND -- like FREEZE, but also put hardware into low-power state.

Definitions like those are "probably" imprecise enough to be useless
to implementors.

And since drivers are free to put hardware into low power states any
time it's convenient to them, there is really no practical difference
between those two notions.

(This is different from earlier notions of FREEZE I remember being
discussed.  In particular the one that viewed it as just quiescing.)


> > How do USB drivers get into a suspend state?

There's driver state ... and there's device state.  For USB the two are
very cleanly separated, since drivers are bound to usb_interface objects,
while only usb_device objects (or root hubs) can have real power state.


> >	At suspend time, before the
> > atomic copy is made they have been told to FREEZE. At resume time, prior
> > to the atomic restore, they have been told to FREEZE. The state
>
> They have been told to freeze _if you have usb built in_, and not
> modular.

Pavel, there's no such "is it built in" logic I've seen anywhere in
the PM framework.  It may be appropriate to add some at some point;
but that'd notion would need to be decently thought through.


>	Imagine kernel with usb as a module, doing resume from kernel
> command line. usb will be in "just powered on" state.

Well, "from kernel command line" all but guarantees a reset has
been done, and so the USB devices will not be suspended.  Remember,
you may be typing that command line on a USB keyboard, which BIOS
had to re-initialize.  Linux and BIOS won't share USB device state.

Now if it's a real resume transition -- from suspend-to-RAM, or
something similar that doesn't load a new Linux kernel -- then
hardware can often maintain the USB suspend state while the
system is in its low power state.  The cost is normally 500 uA
per device, though some may consume a bit more.

- Dave


--===============35900153114896938==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============35900153114896938==--

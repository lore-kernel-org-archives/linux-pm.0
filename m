From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Tue, 8 May 2007 17:26:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705081701040.5281-100000@iolanthe.rowland.org>
References: <200705082159.20250.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705082159.20250.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 May 2007, Rafael J. Wysocki wrote:

> On Tuesday, 8 May 2007 16:56, Alan Stern wrote:
> > On Tue, 8 May 2007, Rafael J. Wysocki wrote:
> > 
> > > As far as I understand it, for S4 the platform provides a means for verifying
> > > if the hardware wasn't changed too much while the system was "sleeping" (via
> > > the NVS memory region).
> > 
> > Rereading p.20, it appears to go the other way: The system checks for
> > hardware changes when booting from Soft Off.
> 
> Nope.  That's clarified later on.  Please read Section 15, "Waking and
> Sleeping" (it's short ;-)), in particular 15.3.3.

You're right.  It says specifically that when booting from an S4 state,
the bootloader compares the signature in the NVS image with hardware
signature in the BIOS's FACS table.  (Although Figure 15-5 makes no 
mention of different pathways for S4 and S5.)

Does the Linux boot kernel actually do the comparison?

Chapter 15 doesn't seem to take into account the possibility that the
computer might be unplugged after entering S4.  It talks about the next 
wakeup being a wake from S4 -- although the actions of the BIOS are 
supposed to be the same when waking from S4 or booting from S5.  In either 
case the BIOS runs the POST and initializes the ACPI tables.  Only the 
actions of the bootloader are different.

So how is the bootloader supposed to know whether it is booting from S4 or
S5?  Does it just assume that the presence of a valid NVS image indicates
an S4 boot, even though it may really be booting from S5?

> > Sounds a lot like USB's power sessions...
> 
> Well, not exactly that.  The hardware signature in FACS only covers some
> "essential" hardware (I'm not sure what that is, probably depends on the
> platform design).

15.1.4.1 says:

	A change in hardware configuration is defined to be any change in
	the platform hardware that would cause the platform to fail when
	trying to restore the S4 context; this hardware is normally
	limited to boot devices.  For example, changing the graphics
	adapter or hard disk controller while in the S4 state should cause
	the hardware signature to change.  On the other hand, removing or
	adding a PC Card device from a PC Card slot should not cause the
	hardware signature to change.

Take it for what it's worth.


> > 	The boot kernel can't make much use of the state preserved by
> > 	ACPI because it doesn't have access to the image kernel's
> > 	records.  It needs to reinitialize ACPI no matter what.
> 
> To be precise, it usually needs to initialize ACPI to read the image (drivers
> use ACPI to some extent).  In principle we could make it behave as though
> ACPI were not compiled in and read the image while being in that state.
> Then, it could use the ACPI state information contained in the image
> (it would have to be pointed to by the image header, but that's easy).

In other words, make the boot kernel act as a bootloader.

Isn't this likely to cause problems?  There must be plenty of systems that
won't work properly without ACPI.  Certainly there are reported cases of
IRQ routing being wrong (and also cases where it is wrong only when ACPI
_is_ in use).


> I generally agree.
> 
> Moreover, it doesn't seem to be necessary to assume that the image should
> be created and saved *after* we've put devices into low power states and
> prepared ACPI for the power transition.  I think it's equally possible to
> create and save the image *before* the power transition is initiated.

Possible and desirable, both.

Okay, so the two of us are in agreement.  I don't know about anyone else, 
though...  :-)

Alan Stern

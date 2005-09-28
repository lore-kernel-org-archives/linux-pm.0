From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 12:17:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509281151140.4491-100000@iolanthe.rowland.org>
References: <1127877808.4802.74.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48196296500334013=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1127877808.4802.74.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============48196296500334013==
Content-Type: TEXT/PLAIN; charset=US-ASCII

[Replying to two people at once]

On Wed, 28 Sep 2005, Nigel Cunningham wrote:
On Wed, 28 Sep 2005, David Brownell wrote:

> > 	If the image does contain USB drivers and the boot kernel
> > 	did not meddle with the device states, then the devices
> > 	will be suspended even though the image thinks they are
> > 	frozen.
> 
> So a power off or reboot doesn't reset the USB devices?

> Those would reset them, yes ... or more to the point, disconnect
> them.  All the checkpoint/resume style PM scenarios should trigger
> disconnection for every USB device.  (And in fact they do, with
> the USB PM fixes upcoming for 2.6.15 ... that seems to have been
> broken in the past few releases.)

You need to state these things carefully.  A complete power-off does
reset/disconnect USB devices.  However, turning off your computer
might not do a complete power-off; it may well leave suspend current 
available.  If that's true, USB devices won't be disconnected.

Reboot is yet another hurdle.  If the BIOS takes control of a USB
controller before the OS can load, then all the devices attached to
it effectively get disconnected.  If the BIOS is smart enough not to
do that, and the boot kernel is smart enough not to initialize the
controllers, then the attached devices will remain safely suspended.


> > 	If the image does contain USB drivers and the boot kernel
> > 	did meddle with the device states, then the devices probably
> > 	will not be resumable by the image kernel.  They will have
> > 	to be rediscovered.
> 
> Even if frozen? They should end up in the same state. But then USB
> suspend/resume hasn't worked reliably for me, so I'm still in
> unload-usb-while-suspending mode.

> No ... the fact that there **WAS** a boot kernel implies a reset,
> hence disconnect.  The BIOS may have re-enumerated things and
> changed device state.  (And of course the USER may have switched
> cables around too...)

Like Dave says, the power level of the device isn't as important as the
state of the USB controller and the device's internal state.  If those
remain unchanged, we can recover the device no matter what its power
level is.

> > No.  The best answer is to
> > 
> > 	(A) tell the boot kernel that the impending freeze is for a
> > 	restore-from-disk, so that it can wipe out the state of any
> > 	devices it has changed, and
> > 
> > 	(B) tell the image kernel that it is resuming from disk, so
> > 	that it can know that the devices are really suspended even
> > 	though its internal records say they are frozen.
> 
> But if the drivers are loaded, we will tell them to freeze, so the state
> will be frozen.

I assume you mean "if the drivers are loaded in the boot kernel".  This
statement is misleading.  If the boot kernel is aware of the devices at
all then it has already reset the USB controller and the devices.  Hence
no matter what their power level is, they will not be resumable by the
image kernel.


> > Better than (A) would be to tell the boot kernel that it _is_ only a boot 
> > kernel, so that its drivers will know not to mess up the state of any 
> > devices.  This would have the side effect of making it impossible to 
> > reload an image from a USB drive, but that's pretty much unavoidable 
> > anyway.

> Actually, reloading an image from a USB drive should be easy;
> I don't understand the difficulty.  These comments seem to be
> circling around the fact that such "resume from swsusp" cases
> are not real PM resumes.

I should have said that it's not possible to load the image from a USB
device and still have USB devices be resumable by the image kernel.  If
the boot kernel initializes the USB controllers then it will destroy the
state preserved by the suspend.  If it doesn't initialize the controllers
then of course it can't restore the image from a USB drive.

> I would like to be able to get suspend to and resuming from usb going at
> some stage. No chance?

There's no way the boot kernel can preserve the state information,
because it doesn't know what that information is and so is forced to
destroy it during initialization.  There's no way, for example, for
the boot kernel to guarantee that the user hasn't swapped USB drives
while the system was asleep -- and the boot kernel will erase the
information the image kernel needs to detect such things.

> The problem with telling the kernel it is only a boot kernel is that we
> don't know that until we look and see if there's an image, which may
> involve running an initramfs/initrd first (encryption, eg).

Isn't there a command-line parameter that tells you whether or not to
try loading an image?  The problem is, what do you do if that
parameter is present but the image isn't.  Depending on how early you
learn this, you could decide not to be a boot kernel (i.e., be a
normal kernel) or you could force a reboot.

Alan Stern


--===============48196296500334013==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48196296500334013==--

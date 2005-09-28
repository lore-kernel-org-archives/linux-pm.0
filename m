From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 13:27:25 +1000
Message-ID: <1127877808.4802.74.camel@localhost>
References: <Pine.LNX.4.44L0.0509272236580.15378-100000@netrider.rowland.org>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99634981000197698=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509272236580.15378-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============99634981000197698==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alan.

On Wed, 2005-09-28 at 12:58, Alan Stern wrote:
> On Wed, 28 Sep 2005, Nigel Cunningham wrote:
> 
> > Yes, that's true. If the usb modules are loaded when suspending and not
> > loaded when resuming or vice versa, you'll get inconsistencies:
> > 
> > State at suspend	State at resume		Image state
> > 
> > Built in		Built in		Freeze->Freeze
> > Loaded modules	Unloaded modules	Undefined->Freeze
> > Unloaded modules	Loaded modules		Freeze->Undefined
> 
> This table is misleading.  Better to describe it like this:
> 
> 	If the image doesn't contain USB drivers, the device state
> 	doesn't matter.
> 
> 	If the image does contain USB drivers and the boot kernel
> 	did not meddle with the device states, then the devices
> 	will be suspended even though the image thinks they are
> 	frozen.

So a power off or reboot doesn't reset the USB devices?

> 	If the image does contain USB drivers and the boot kernel
> 	did meddle with the device states, then the devices probably
> 	will not be resumable by the image kernel.  They will have
> 	to be rediscovered.

Even if frozen? They should end up in the same state. But then USB
suspend/resume hasn't worked reliably for me, so I'm still in
unload-usb-while-suspending mode.

> > I guess there are three possible solutions:
> > 1) Leave things as they are and say it is the user's problem if they
> > make the state inconsistent.
> > 2) Keep knowledge of the device states across the atomic restore and use
> > that information in deciding what to do in device resume/powerup.
> > 3) Make device drivers handle the situation properly without knowledge
> > of what state the hardware is really in (or check the real state - where
> > possible - and rely on that in deciding what to do).
> > 
> > 2 seems to me to make for the most reliable solution.
> 
> No.  The best answer is to
> 
> 	(A) tell the boot kernel that the impending freeze is for a
> 	restore-from-disk, so that it can wipe out the state of any
> 	devices it has changed, and
> 
> 	(B) tell the image kernel that it is resuming from disk, so
> 	that it can know that the devices are really suspended even
> 	though its internal records say they are frozen.

But if the drivers are loaded, we will tell them to freeze, so the state
will be frozen.

> Better than (A) would be to tell the boot kernel that it _is_ only a boot 
> kernel, so that its drivers will know not to mess up the state of any 
> devices.  This would have the side effect of making it impossible to 
> reload an image from a USB drive, but that's pretty much unavoidable 
> anyway.

I would like to be able to get suspend to and resuming from usb going at
some stage. No chance?

The problem with telling the kernel it is only a boot kernel is that we
don't know that until we look and see if there's an image, which may
involve running an initramfs/initrd first (encryption, eg).

Regards,

Nigel



--===============99634981000197698==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99634981000197698==--

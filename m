From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 08:46:09 -0700
Message-ID: <20050928154609.5FBA2E36F2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509272236580.15378-100000@netrider.rowland.org>
	<1127877808.4802.74.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9313213406641303=="
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
To: stern@rowland.harvard.edu, ncunningham@cyclades.com
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

--===============9313213406641303==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > 	If the image doesn't contain USB drivers, the device state
> > 	doesn't matter.
> > 
> > 	If the image does contain USB drivers and the boot kernel
> > 	did not meddle with the device states, then the devices
> > 	will be suspended even though the image thinks they are
> > 	frozen.
>
> So a power off or reboot doesn't reset the USB devices?

Those would reset them, yes ... or more to the point, disconnect
them.  All the checkpoint/resume style PM scenarios should trigger
disconnection for every USB device.  (And in fact they do, with
the USB PM fixes upcoming for 2.6.15 ... that seems to have been
broken in the past few releases.)


> > 	If the image does contain USB drivers and the boot kernel
> > 	did meddle with the device states, then the devices probably
> > 	will not be resumable by the image kernel.  They will have
> > 	to be rediscovered.
>
> Even if frozen? They should end up in the same state.

No ... the fact that there **WAS** a boot kernel implies a reset,
hence disconnect.  The BIOS may have re-enumerated things and
changed device state.  (And of course the USER may have switched
cables around too...)


> > Better than (A) would be to tell the boot kernel that it _is_ only a boot 
> > kernel, so that its drivers will know not to mess up the state of any 
> > devices.  This would have the side effect of making it impossible to 
> > reload an image from a USB drive, but that's pretty much unavoidable 
> > anyway.

Actually, reloading an image from a USB drive should be easy;
I don't understand the difficulty.  These comments seem to be
circling around the fact that such "resume from swsusp" cases
are not real PM resumes.


> I would like to be able to get suspend to and resuming from usb going at
> some stage. No chance?

Have a look at the USB PM patches now in Greg's tree; I'll
be posting a note to this list about them soonish.

Briefly, status for me is that while I see resume from swsusp
snapshots working, there seems to be difficulty (a) getting
remote wakeup signals through ACPI after they wake the system
up, (b) often resuming from S1 or S3 in general.  None of those
issues appear to be from USB code.

- Dave


--===============9313213406641303==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============9313213406641303==--

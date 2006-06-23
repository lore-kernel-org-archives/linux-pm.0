From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 14:32:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606231425440.6478-100000@iolanthe.rowland.org>
References: <200606221648.10799.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606221648.10799.david-b@pacbell.net>
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
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Jun 2006, David Brownell wrote:

> On Thursday 22 June 2006 1:31 pm, Alan Stern wrote:
> > On Thu, 22 Jun 2006, David Brownell wrote:
> > =

> > > > 	 The PM core _should_ be
> > > > able to handle a device being added or removed while some parts of
> > > > the system are suspended or frozen, just so long as the actual pare=
nt is
> > > > still awake.  Uevents can safely be queued until userspace is unfro=
zen or =

> > > > otherwise able to process them.
> > > =

> > > Fixing that involves updating pm core locking, ISTR.  I've thought th=
at
> > > the root cause of the issue is that the list of devices to be suspend=
ed
> > > is created at the wrong time ... very early and globally scoped, not
> > > on-demand and privately scoped.
> > =

> > I believe this has been fixed for quite a while. =

> =

> That's been said, but nonetheless the last few times I've tried to do
> things like handling disconnect processing anything other than very
> late (after khubd got woken up again), it was still deadlocksville.
> Yes, this is _after_ folk have said "this has been fixed...".

Okay, I have tried it.  This patch

Index: usb-2.6/drivers/usb/core/hub.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- usb-2.6.orig/drivers/usb/core/hub.c
+++ usb-2.6/drivers/usb/core/hub.c
@@ -1779,7 +1779,14 @@ int usb_port_resume(struct usb_device *u
 #endif
 			status =3D 0;
 	} else
+{int i;
+for (i =3D 0; i < udev->maxchild; ++i) {
+ if (udev->children[i]) {
+  printk(KERN_INFO "Disconnecting child %d\n", i);
+  usb_disconnect(&udev->children[i]);
+}}
 		status =3D finish_port_resume(udev);
+}
 	if (status < 0)
 		dev_dbg(&udev->dev, "can't resume, status %d\n",
 			status);

causes all USB devices to be removed during an early stage of resume
processing.  I tried it with STD (since STR isn't usable on this machine).  =

The devices actually get removed twice: once during the "resume so we can
write out the memory image" phase and then once again during the actual =

final resume.

With a hub plugged in, it worked just fine.  With a USB flash disk plugged =

in the machine hung, but not because of anything wrong with the driver =

model or PM cores.  It was a bug in the SCSI core, requiring a 1-line fix.  =

With that fix in place, the test also worked with the mass-storage device.

Thus removing a device during suspend or resume processing should not be
any sort of problem.  Adding a device need not be a problem either,
provided we add the requirement that the parent not be suspended when the
child is added.

Alan Stern

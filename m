From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: s2ram slow (radeon) / failing (usb)
Date: Thu, 6 May 2010 14:40:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005061426160.1708-100000__17796.9569377185$1273171405$gmane$org@iolanthe.rowland.org>
References: <20100506194711.75979d22@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100506194711.75979d22@neptune.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Oliver Neukum <oneukum@suse.de>, Jiri Kosina <jkosina@suse.cz>, list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, jslaby@suse.cz
List-Id: linux-pm@vger.kernel.org

On Thu, 6 May 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:

> > Bruno, can you confirm that the hang occurs during one of those =

> > cancel_work_sync() calls?
> =

> No, it's not one of the cancel_work_sync() that hangs but it's the
> del_timer_sync() right before them that hangs!
> (del_timer_sync() also hangs if I put it last, so the cancel_work_sync()
> don't hang anything)
> =

> static void hid_cancel_delayed_stuff(struct usbhid_device *usbhid)
> {
> 	del_timer_sync(&usbhid->io_retry); /* this one never returns */
> 	cancel_work_sync(&usbhid->restart_work);
> 	cancel_work_sync(&usbhid->reset_work);
> }

Okay, I see what the problem is.  In usbhid_start() there's a bunch of
statements initializing parts of the usbhid structure.  When probing
fails those statements don't get executed, so the timer and workqueue
things aren't set up properly.

This patch should fix it.

Alan Stern



Index: usb-2.6/drivers/hid/usbhid/hid-core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- usb-2.6.orig/drivers/hid/usbhid/hid-core.c
+++ usb-2.6/drivers/hid/usbhid/hid-core.c
@@ -998,13 +998,6 @@ static int usbhid_start(struct hid_devic
 		}
 	}
 =

-	init_waitqueue_head(&usbhid->wait);
-	INIT_WORK(&usbhid->reset_work, hid_reset);
-	INIT_WORK(&usbhid->restart_work, __usbhid_restart_queues);
-	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
-
-	spin_lock_init(&usbhid->lock);
-
 	usbhid->urbctrl =3D usb_alloc_urb(0, GFP_KERNEL);
 	if (!usbhid->urbctrl) {
 		ret =3D -ENOMEM;
@@ -1180,6 +1173,12 @@ static int usbhid_probe(struct usb_inter
 	usbhid->intf =3D intf;
 	usbhid->ifnum =3D interface->desc.bInterfaceNumber;
 =

+	init_waitqueue_head(&usbhid->wait);
+	INIT_WORK(&usbhid->reset_work, hid_reset);
+	INIT_WORK(&usbhid->restart_work, __usbhid_restart_queues);
+	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
+	spin_lock_init(&usbhid->lock);
+
 	ret =3D hid_add_device(hid);
 	if (ret) {
 		if (ret !=3D -ENODEV)

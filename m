From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: s2ram slow (radeon) / failing (usb)
Date: Tue, 4 May 2010 10:37:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005041028300.9849__43282.5094707825$1272962356$gmane$org@pobox.suse.cz>
References: <20100503214642.67577f91@neptune.home>
	<20100503225735.6b5e2687@neptune.home>
	<20100503231154.486c27d6@neptune.home>
	<201005040842.35260.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005040842.35260.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-pm@lists.linux-foundation.org, list <linux-usb@vger.kernel.org>, USB@smtp1.linux-foundation.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 4 May 2010, Oliver Neukum wrote:

> > [  477.543304] usb 1-2.1: usb_autosuspend_device: cnt 1 -> 0
> > [  477.543316] usbhid 1-2.1:1.1: __pm_runtime_suspend()!
> > [  477.543326] usbhid 1-2.1:1.1: __pm_runtime_suspend() returns 0!
> > [  477.543380] usbcore: registered new interface driver usbhid
> > [  477.549457] usbhid: USB HID core driver
> > 
> > And suspend is freezing inside of hid_cancel_delayed_stuff(usbhid) call
> > from hid_suspend() in drivers/hid/usbhid/hid-core.c ...
> > 
> > Is it worth continuing iteration and adding further printk's down there?
> > Jiri, what's your opinion on this?
> 
> Ugh. That looks like a bug in usbhid that I introduced. A fix is not trivial.
> In short, I did not think the device could be undergoing a queued resumption
> while suspend() is being called. I wonder why this is happening.

Hmmm ... seems to me that in this case, the problem might be that there is 
a device hanging in the air, for which the parsing of report descriptor 
failed (interface .0002), but it's still somehow there on the bus.

It's a bit strange that we are not seeing 

	dev_err(&intf->dev, "can't add hid device: %d\n", ret);

message from usbhid_probe(), are we? That would mean, that we are 
returning ENODEV from the usb_driver->probe routine properly.

Bruno, could you, for testing purposes, check, whether the patch below 
changes the behavior you are seeing (and also check what the actual return 
value from device_add() was, see the added printk()).
Thanks.



 drivers/hid/hid-core.c        |    5 +++--
 drivers/hid/usbhid/hid-core.c |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2e2aa75..7186f9f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1770,10 +1770,11 @@ int hid_add_device(struct hid_device *hdev)
 		     hdev->vendor, hdev->product, atomic_inc_return(&id));
 
 	ret = device_add(&hdev->dev);
+	printk(KERN_DEBUG "HID: device_add() returned %d\n", ret);
 	if (!ret)
 		hdev->status |= HID_STAT_ADDED;
-
-	hid_debug_register(hdev, dev_name(&hdev->dev));
+	else
+		hid_debug_register(hdev, dev_name(&hdev->dev));
 
 	return ret;
 }
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 56d06cd..f33445a 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1181,8 +1181,8 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 
 	ret = hid_add_device(hid);
 	if (ret) {
-		if (ret != -ENODEV)
-			dev_err(&intf->dev, "can't add hid device: %d\n", ret);
+		dev_err(&intf->dev, "can't add hid device: %d\n", ret);
+		ret = -ENODEV;
 		goto err_free;
 	}
 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

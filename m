From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rft]autosuspend for btusb
Date: Fri, 22 Aug 2008 16:31:10 +0200
Message-ID: <1219415470.7591.472.camel__32443.606950301$1219416271$gmane$org@violet.holtmann.net>
References: <200808221520.19791.oliver@neukum.org>
	<1219412033.7591.464.camel@violet.holtmann.net>
	<200808221551.57225.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-UJLgsH0WZ69rdrQO3U2C"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808221551.57225.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--=-UJLgsH0WZ69rdrQO3U2C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Oliver,

> > > this patch against vanilla 2.6.27-rc4 implements full autosuspend for
> > > btusb. It should allow the HCI to be suspended during periods of inactivity
> > > while retaining full service if the device supports USB remote wakeup.
> > 
> > actually we do have two cases. An inactive device can be woken up by an
> > HCI Connection Request coming via the interrupt endpoint or if we have a
> > send_frame callback via the Bluetooth stack itself.
> 
> Yes, if send_frame triggers it, we wake using a work queue. A connection
> request will wake us via remote wakeup.
> 
> > What do we do if a device does not support remote wakeup?
> 
> Autosuspend on close, resume on open. I don't think we can do more.

sounds good to me. I wanna split the whole work into small patches so we
can have an easier review. I attached the first two of this series and
they should apply cleanly against 2.6.27-rc4, but keep in mind that you
need the usb_unlink_anchored_urbs() patch too.

> > > Please test and/or comment on the code.
> > > It works for me with a few glitches but still needs to be a bit polished.
> > 
> > Please explain the tx_in_flight stuff to me. It looks unneeded since we
> > anchor all TX URBs anyway.
> 
> The completion of an URB may happen after the autosuspend timeout passed.
> But we cannot use the pm counters as they are not accessible in interrupt.
> Hence we must maintain a counter ourselves.

Can we not just check the number of URBs in the anchor? I am against
just duplicating a counter, but then lets call it it what it is to make
it gets not misused. It is a purely a PM counter.

> > So can we just leave the ISOC interface stuff out of it and try to get
> 
> The isoc stuff should be handled already, but I haven't tested that.

I know, but I wanna get the basic logic clean and tested. The SCO part
comes after that. Even if I think it should be good already.

> > the case right where we have control and interrupt URBs only and maybe
> > bulk URBs in case we an ACL link up.
> > 
> > This reminds me that we should extend the notify() callback to inform
> > about sniff and active state changes. Since in theory when a connection
> > goes into sniff mode, we could suspend it.
> 
> We should definitely do that.

I will work on a patch for that one.

Regards

Marcel


--=-UJLgsH0WZ69rdrQO3U2C
Content-Disposition: attachment; filename=patch-btusb-001
Content-Type: text/plain; name=patch-btusb-001; charset=utf-8
Content-Transfer-Encoding: 7bit

[Bluetooth] Add fine grained mem_flags used to btusb driver

The URB submission routines need more fine grained control for the
mem_flags used by kmalloc(), usb_alloc_urb() and usb_submit_urb() to
better support different caller situations. Add a mem_flags parameter
and have the caller full control.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit 283407ed763e144f2343c980542a460dee98e98c
tree ea86d454c7e8b6243c8a717ac009bbde2a11beb0
parent 6a55617ed5d1aa62b850de2cf66f5ede2eef4825
author Marcel Holtmann <marcel@holtmann.org> Fri, 22 Aug 2008 16:23:47 +0200
committer Marcel Holtmann <marcel@holtmann.org> Fri, 22 Aug 2008 16:23:47 +0200

 drivers/bluetooth/btusb.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6a01068..9296df0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -227,7 +227,7 @@ static void btusb_intr_complete(struct urb *urb)
 	}
 }
 
-static int btusb_submit_intr_urb(struct hci_dev *hdev)
+static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -240,13 +240,13 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev)
 	if (!data->intr_ep)
 		return -ENODEV;
 
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	urb = usb_alloc_urb(0, mem_flags);
 	if (!urb)
 		return -ENOMEM;
 
 	size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
 
-	buf = kmalloc(size, GFP_ATOMIC);
+	buf = kmalloc(size, mem_flags);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
@@ -262,7 +262,7 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev)
 
 	usb_anchor_urb(urb, &data->intr_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, mem_flags);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -311,7 +311,7 @@ static void btusb_bulk_complete(struct urb *urb)
 	}
 }
 
-static int btusb_submit_bulk_urb(struct hci_dev *hdev)
+static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -324,13 +324,13 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev)
 	if (!data->bulk_rx_ep)
 		return -ENODEV;
 
-	urb = usb_alloc_urb(0, GFP_KERNEL);
+	urb = usb_alloc_urb(0, mem_flags);
 	if (!urb)
 		return -ENOMEM;
 
 	size = le16_to_cpu(data->bulk_rx_ep->wMaxPacketSize);
 
-	buf = kmalloc(size, GFP_KERNEL);
+	buf = kmalloc(size, mem_flags);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
@@ -345,7 +345,7 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev)
 
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
-	err = usb_submit_urb(urb, GFP_KERNEL);
+	err = usb_submit_urb(urb, mem_flags);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -423,7 +423,7 @@ static void inline __fill_isoc_descriptor(struct urb *urb, int len, int mtu)
 	urb->number_of_packets = i;
 }
 
-static int btusb_submit_isoc_urb(struct hci_dev *hdev)
+static int btusb_submit_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -436,14 +436,14 @@ static int btusb_submit_isoc_urb(struct hci_dev *hdev)
 	if (!data->isoc_rx_ep)
 		return -ENODEV;
 
-	urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_KERNEL);
+	urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, mem_flags);
 	if (!urb)
 		return -ENOMEM;
 
 	size = le16_to_cpu(data->isoc_rx_ep->wMaxPacketSize) *
 						BTUSB_MAX_ISOC_FRAMES;
 
-	buf = kmalloc(size, GFP_KERNEL);
+	buf = kmalloc(size, mem_flags);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
@@ -466,7 +466,7 @@ static int btusb_submit_isoc_urb(struct hci_dev *hdev)
 
 	usb_anchor_urb(urb, &data->isoc_anchor);
 
-	err = usb_submit_urb(urb, GFP_KERNEL);
+	err = usb_submit_urb(urb, mem_flags);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -514,7 +514,7 @@ static int btusb_open(struct hci_dev *hdev)
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		return 0;
 
-	err = btusb_submit_intr_urb(hdev);
+	err = btusb_submit_intr_urb(hdev, GFP_KERNEL);
 	if (err < 0) {
 		clear_bit(BTUSB_INTR_RUNNING, &hdev->flags);
 		clear_bit(HCI_RUNNING, &hdev->flags);
@@ -726,10 +726,10 @@ static void btusb_work(struct work_struct *work)
 
 	if (hdev->conn_hash.acl_num > 0) {
 		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
-			if (btusb_submit_bulk_urb(hdev) < 0)
+			if (btusb_submit_bulk_urb(hdev, GFP_KERNEL) < 0)
 				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 			else
-				btusb_submit_bulk_urb(hdev);
+				btusb_submit_bulk_urb(hdev, GFP_KERNEL);
 		}
 	} else {
 		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
@@ -746,10 +746,10 @@ static void btusb_work(struct work_struct *work)
 		}
 
 		if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
-			if (btusb_submit_isoc_urb(hdev) < 0)
+			if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
 				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 			else
-				btusb_submit_isoc_urb(hdev);
+				btusb_submit_isoc_urb(hdev, GFP_KERNEL);
 		}
 	} else {
 		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);

--=-UJLgsH0WZ69rdrQO3U2C
Content-Disposition: attachment; filename=patch-btusb-002
Content-Type: text/plain; name=patch-btusb-002; charset=utf-8
Content-Transfer-Encoding: 7bit

[Bluetooth] Handle bulk URBs in btusb driver from notify callback

With the addition of usb_unlink_anchored_urbs() it is possible to fully
control the bulk URBs from the notify callback. There is no need to
schedule work and so only do this for the isoc URBs.

Also cancel any scheduled work when closing down the interface.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit 3c7a240281e8269ba297d3805f90c65c726828f5
tree 4a345086275bc7625aef6848a9acf2f4db58af65
parent 283407ed763e144f2343c980542a460dee98e98c
author Marcel Holtmann <marcel@holtmann.org> Fri, 22 Aug 2008 16:24:45 +0200
committer Marcel Holtmann <marcel@holtmann.org> Fri, 22 Aug 2008 16:24:45 +0200

 drivers/bluetooth/btusb.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9296df0..0532569 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -532,6 +532,8 @@ static int btusb_close(struct hci_dev *hdev)
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
+	cancel_work_sync(&data->work);
+
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	usb_kill_anchored_urbs(&data->intr_anchor);
 
@@ -672,8 +674,19 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 
 	BT_DBG("%s evt %d", hdev->name, evt);
 
-	if (evt == HCI_NOTIFY_CONN_ADD || evt == HCI_NOTIFY_CONN_DEL)
-		schedule_work(&data->work);
+	if (hdev->conn_hash.acl_num > 0) {
+		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
+			if (btusb_submit_bulk_urb(hdev, GFP_ATOMIC) < 0)
+				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+			else
+				btusb_submit_bulk_urb(hdev, GFP_ATOMIC);
+		}
+	} else {
+		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+		usb_unlink_anchored_urbs(&data->bulk_anchor);
+	}
+
+	schedule_work(&data->work);
 }
 
 static int inline __set_isoc_interface(struct hci_dev *hdev, int altsetting)
@@ -724,18 +737,6 @@ static void btusb_work(struct work_struct *work)
 	struct btusb_data *data = container_of(work, struct btusb_data, work);
 	struct hci_dev *hdev = data->hdev;
 
-	if (hdev->conn_hash.acl_num > 0) {
-		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
-			if (btusb_submit_bulk_urb(hdev, GFP_KERNEL) < 0)
-				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-			else
-				btusb_submit_bulk_urb(hdev, GFP_KERNEL);
-		}
-	} else {
-		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-		usb_kill_anchored_urbs(&data->bulk_anchor);
-	}
-
 	if (hdev->conn_hash.sco_num > 0) {
 		if (data->isoc_altsetting != 2) {
 			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);

--=-UJLgsH0WZ69rdrQO3U2C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-UJLgsH0WZ69rdrQO3U2C--

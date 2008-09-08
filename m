From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Mon, 8 Sep 2008 23:45:21 +0200
Message-ID: <200809082345.22955.rjw__5152.95090522176$1220910185$gmane$org@sisk.pl>
References: <200808221520.19791.oliver@neukum.org>
	<200808280917.57020.oliver@neukum.org>
	<1220906968.11655.7.camel@californication>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1220906968.11655.7.camel@californication>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

On Monday, 8 of September 2008, Marcel Holtmann wrote:
> Hi Oliver,
> 
> > > I couldn't reproduce the breakage with suspend/resume support removed from
> > > usbhid.
> > > 
> > > Let's just say it's related to BT, since your patch evidently fixes the problem
> > > for me and I have just no reason to believe it's anything else than BT.
> >
> > Very good.
> > 
> > here it is again. You may need to cut the USB bits depending
> > on which tree you want to apply it to.
> 
> do we have a version that could be applied to 2.6.27-rc5, because the
> patch depends on unmerged USB stuff. I tend to leave this for 2.6.28 for
> now.

I've been using the one below recently.  It doesn't seem to depend on anything
unmerged.

Thanks,
Rafael


---
 drivers/bluetooth/btusb.c |  145 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 113 insertions(+), 32 deletions(-)

Index: linux-2.6/drivers/bluetooth/btusb.c
===================================================================
--- linux-2.6.orig/drivers/bluetooth/btusb.c
+++ linux-2.6/drivers/bluetooth/btusb.c
@@ -169,6 +169,7 @@ static struct usb_device_id blacklist_ta
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
+	struct usb_interface *acl;
 	struct usb_interface *isoc;
 
 	spinlock_t lock;
@@ -176,6 +177,7 @@ struct btusb_data {
 	unsigned long flags;
 
 	struct work_struct work;
+	struct work_struct waker;
 
 	struct usb_anchor tx_anchor;
 	struct usb_anchor intr_anchor;
@@ -189,6 +191,7 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *isoc_rx_ep;
 
 	int isoc_altsetting;
+	int susp_count;
 };
 
 static void btusb_intr_complete(struct urb *urb)
@@ -227,7 +230,7 @@ static void btusb_intr_complete(struct u
 	}
 }
 
-static int btusb_submit_intr_urb(struct hci_dev *hdev)
+static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -240,13 +243,13 @@ static int btusb_submit_intr_urb(struct 
 	if (!data->intr_ep)
 		return -ENODEV;
 
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	urb = usb_alloc_urb(0, gfp);
 	if (!urb)
 		return -ENOMEM;
 
 	size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
 
-	buf = kmalloc(size, GFP_ATOMIC);
+	buf = kmalloc(size, gfp);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
@@ -262,7 +265,7 @@ static int btusb_submit_intr_urb(struct 
 
 	usb_anchor_urb(urb, &data->intr_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -311,7 +314,7 @@ static void btusb_bulk_complete(struct u
 	}
 }
 
-static int btusb_submit_bulk_urb(struct hci_dev *hdev)
+static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -324,18 +327,19 @@ static int btusb_submit_bulk_urb(struct 
 	if (!data->bulk_rx_ep)
 		return -ENODEV;
 
-	urb = usb_alloc_urb(0, GFP_KERNEL);
+	urb = usb_alloc_urb(0, gfp);
 	if (!urb)
 		return -ENOMEM;
 
 	size = le16_to_cpu(data->bulk_rx_ep->wMaxPacketSize);
 
-	buf = kmalloc(size, GFP_KERNEL);
+	buf = kmalloc(size, gfp);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
 	}
 
+	usb_mark_last_busy(data->udev);
 	pipe = usb_rcvbulkpipe(data->udev, data->bulk_rx_ep->bEndpointAddress);
 
 	usb_fill_bulk_urb(urb, data->udev, pipe,
@@ -345,7 +349,7 @@ static int btusb_submit_bulk_urb(struct 
 
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
-	err = usb_submit_urb(urb, GFP_KERNEL);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -514,7 +518,7 @@ static int btusb_open(struct hci_dev *hd
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		return 0;
 
-	err = btusb_submit_intr_urb(hdev);
+	err = btusb_submit_intr_urb(hdev, GFP_KERNEL);
 	if (err < 0) {
 		clear_bit(BTUSB_INTR_RUNNING, &hdev->flags);
 		clear_bit(HCI_RUNNING, &hdev->flags);
@@ -523,6 +527,13 @@ static int btusb_open(struct hci_dev *hd
 	return err;
 }
 
+static void btusb_stop_traffic(struct btusb_data *data)
+{
+	usb_kill_anchored_urbs(&data->intr_anchor);
+	usb_kill_anchored_urbs(&data->bulk_anchor);
+	usb_kill_anchored_urbs(&data->isoc_anchor);
+}
+
 static int btusb_close(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hdev->driver_data;
@@ -532,14 +543,12 @@ static int btusb_close(struct hci_dev *h
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
-	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->intr_anchor);
+	flush_work(&data->work);
 
+	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->bulk_anchor);
-
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->intr_anchor);
+	btusb_stop_traffic(data);
 
 	return 0;
 }
@@ -672,8 +681,19 @@ static void btusb_notify(struct hci_dev 
 
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
@@ -724,18 +744,6 @@ static void btusb_work(struct work_struc
 	struct btusb_data *data = container_of(work, struct btusb_data, work);
 	struct hci_dev *hdev = data->hdev;
 
-	if (hdev->conn_hash.acl_num > 0) {
-		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
-			if (btusb_submit_bulk_urb(hdev) < 0)
-				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-			else
-				btusb_submit_bulk_urb(hdev);
-		}
-	} else {
-		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-		usb_kill_anchored_urbs(&data->bulk_anchor);
-	}
-
 	if (hdev->conn_hash.sco_num > 0) {
 		if (data->isoc_altsetting != 2) {
 			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
@@ -821,6 +829,7 @@ static int btusb_probe(struct usb_interf
 	}
 
 	data->udev = interface_to_usbdev(intf);
+	data->acl = intf;
 
 	spin_lock_init(&data->lock);
 
@@ -889,7 +898,7 @@ static int btusb_probe(struct usb_interf
 
 	if (data->isoc) {
 		err = usb_driver_claim_interface(&btusb_driver,
-							data->isoc, NULL);
+							data->isoc, data);
 		if (err < 0) {
 			hci_free_dev(hdev);
 			kfree(data);
@@ -921,20 +930,92 @@ static void btusb_disconnect(struct usb_
 
 	hdev = data->hdev;
 
-	if (data->isoc)
-		usb_driver_release_interface(&btusb_driver, data->isoc);
+	/* make sure we have a reference */
+	__hci_dev_hold(hdev);
 
-	usb_set_intfdata(intf, NULL);
+	usb_set_intfdata(data->acl, NULL);
+	if (data->isoc)
+		usb_set_intfdata(data->isoc, NULL);
 
+	/* unregister before releasing any interface */
 	hci_unregister_dev(hdev);
 
+	if (intf == data->isoc)
+		usb_driver_release_interface(&btusb_driver, data->acl);
+	else if (data->isoc)
+		usb_driver_release_interface(&btusb_driver, data->isoc);
+
+	/* release the reference */
+	__hci_dev_put(hdev);
 	hci_free_dev(hdev);
 }
 
+static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct btusb_data *data = usb_get_intfdata(intf);
+
+	BT_DBG("%s called\n", __func__);
+
+	if (data->susp_count++)
+		return 0;
+
+	cancel_work_sync(&data->work);
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+	return 0;
+}
+
+static int btusb_resume(struct usb_interface *intf)
+{
+	struct btusb_data *data = usb_get_intfdata(intf);
+	struct hci_dev *hdev = data->hdev;
+	int ret;
+
+	if (--data->susp_count)
+		return 0;
+	if (test_bit(HCI_RUNNING, &hdev->flags)) {
+		ret = btusb_submit_intr_urb(hdev, GFP_NOIO);
+		if (ret < 0) {
+			clear_bit(HCI_RUNNING, &hdev->flags);
+			return ret;
+		}
+	}
+
+	if (hdev->conn_hash.acl_num > 0) {
+		ret = btusb_submit_bulk_urb(hdev, GFP_NOIO);
+		if (ret < 0) {
+			clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+			return ret;
+		} else {
+			ret = btusb_submit_bulk_urb(hdev, GFP_NOIO);
+			if (ret < 0) {
+				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+				usb_kill_anchored_urbs(&data->bulk_anchor);
+				return ret;
+			}
+		}
+	}
+
+	if (data->isoc) {
+		if (test_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
+			ret = btusb_submit_isoc_urb(hdev);
+			if (ret < 0)
+				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+			else
+				btusb_submit_isoc_urb(hdev);
+		}
+	}
+
+	schedule_work(&data->work);
+	return 0;
+}
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
 	.disconnect	= btusb_disconnect,
+	.suspend	= btusb_suspend,
+	.resume		= btusb_resume,
 	.id_table	= btusb_table,
 };
 

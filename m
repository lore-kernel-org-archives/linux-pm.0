From: Oliver Neukum <oliver@neukum.org>
Subject: [rft]autosuspend for btusb
Date: Fri, 22 Aug 2008 15:20:18 +0200
Message-ID: <200808221520.19791.oliver__31454.1621752598$1219411390$gmane$org@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

this patch against vanilla 2.6.27-rc4 implements full autosuspend for
btusb. It should allow the HCI to be suspended during periods of inactivity
while retaining full service if the device supports USB remote wakeup.

Please test and/or comment on the code.
It works for me with a few glitches but still needs to be a bit polished.

	Regards
		Oliver

---

--- linux-2.6.27-rc4/drivers/usb/core/urb.c	2008-08-21 10:03:44.000000000 +0200
+++ linux-2.6.27-rc3/drivers/usb/core/urb.c	2008-08-20 17:21:24.000000000 +0200
@@ -601,15 +601,20 @@ EXPORT_SYMBOL_GPL(usb_kill_anchored_urbs
 void usb_unlink_anchored_urbs(struct usb_anchor *anchor)
 {
 	struct urb *victim;
+	unsigned long flags;
 
-	spin_lock_irq(&anchor->lock);
+	spin_lock_irqsave(&anchor->lock, flags);
 	while (!list_empty(&anchor->urb_list)) {
 		victim = list_entry(anchor->urb_list.prev, struct urb,
 				    anchor_list);
+		usb_get_urb(victim);
+		spin_unlock_irqrestore(&anchor->lock, flags);
 		/* this will unanchor the URB */
 		usb_unlink_urb(victim);
+		usb_put_urb(victim);
+		spin_lock_irqsave(&anchor->lock, flags);
 	}
-	spin_unlock_irq(&anchor->lock);
+	spin_unlock_irqrestore(&anchor->lock, flags);
 }
 EXPORT_SYMBOL_GPL(usb_unlink_anchored_urbs);
 
@@ -628,3 +633,47 @@ int usb_wait_anchor_empty_timeout(struct
 				  msecs_to_jiffies(timeout));
 }
 EXPORT_SYMBOL_GPL(usb_wait_anchor_empty_timeout);
+
+struct urb *usb_get_from_anchor(struct usb_anchor *anchor)
+{
+	struct urb *victim;
+	unsigned long flags;
+
+	spin_lock_irqsave(&anchor->lock, flags);
+	if (!list_empty(&anchor->urb_list)) {
+		victim = list_entry(anchor->urb_list.next, struct urb,
+				    anchor_list);
+		usb_get_urb(victim);
+		spin_unlock_irqrestore(&anchor->lock, flags);
+		usb_unanchor_urb(victim);
+	} else {
+		spin_unlock_irqrestore(&anchor->lock, flags);
+		victim = NULL;
+	}
+
+	return victim;
+}
+
+EXPORT_SYMBOL_GPL(usb_get_from_anchor);
+
+void usb_scuttle_anchored_urbs(struct usb_anchor *anchor)
+{
+	struct urb *victim;
+	unsigned long flags;
+
+	spin_lock_irqsave(&anchor->lock, flags);
+	while (!list_empty(&anchor->urb_list)) {
+		victim = list_entry(anchor->urb_list.prev, struct urb,
+				    anchor_list);
+		usb_get_urb(victim);
+		spin_unlock_irqrestore(&anchor->lock, flags);
+		/* this will unanchor the URB */
+		usb_unanchor_urb(victim);
+		usb_put_urb(victim);
+		spin_lock_irqsave(&anchor->lock, flags);
+	}
+	spin_unlock_irqrestore(&anchor->lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(usb_scuttle_anchored_urbs);
+
--- linux-2.6.27-rc4/include/linux/usb.h	2008-08-21 10:04:29.000000000 +0200
+++ linux-2.6.27-rc3/include/linux/usb.h	2008-08-20 17:09:57.000000000 +0200
@@ -1462,6 +1460,8 @@ extern void usb_anchor_urb(struct urb *u
 extern void usb_unanchor_urb(struct urb *urb);
 extern int usb_wait_anchor_empty_timeout(struct usb_anchor *anchor,
 					 unsigned int timeout);
+extern struct urb *usb_get_from_anchor(struct usb_anchor *anchor);
+extern void usb_scuttle_anchored_urbs(struct usb_anchor *anchor);
 
 /**
  * usb_urb_dir_in - check if an URB describes an IN transfer
--- linux-2.6.27-rc4/drivers/bluetooth/btusb.c	2008-08-21 10:04:11.000000000 +0200
+++ linux-2.6.27-rc3/drivers/bluetooth/btusb.c	2008-08-22 14:39:05.000000000 +0200
@@ -35,13 +35,13 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-//#define CONFIG_BT_HCIBTUSB_DEBUG
+#define CONFIG_BT_HCIBTUSB_DEBUG
 #ifndef CONFIG_BT_HCIBTUSB_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "0.3"
+#define VERSION "0.4"
 
 static int ignore_dga;
 static int ignore_csr;
@@ -165,10 +165,12 @@ static struct usb_device_id blacklist_ta
 #define BTUSB_INTR_RUNNING	0
 #define BTUSB_BULK_RUNNING	1
 #define BTUSB_ISOC_RUNNING	2
+#define BTUSB_SUSPENDING	3
 
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
+	struct usb_interface *acl;
 	struct usb_interface *isoc;
 
 	spinlock_t lock;
@@ -176,11 +178,15 @@ struct btusb_data {
 	unsigned long flags;
 
 	struct work_struct work;
+	struct work_struct waker;
 
 	struct usb_anchor tx_anchor;
 	struct usb_anchor intr_anchor;
 	struct usb_anchor bulk_anchor;
 	struct usb_anchor isoc_anchor;
+	struct usb_anchor deferred;
+	int tx_in_flight;
+	spinlock_t txlock;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
@@ -189,8 +195,26 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *isoc_rx_ep;
 
 	int isoc_altsetting;
+	int did_iso_resume:1;
+	int susp_count;
 };
 
+static int inc_tx(struct btusb_data *data)
+{
+	unsigned long flags;
+	int rv;
+
+	BT_DBG("entered");
+	spin_lock_irqsave(&data->txlock, flags);
+	rv = test_bit(BTUSB_SUSPENDING, &data->flags);
+	if (!rv)
+		data->tx_in_flight++;
+	spin_unlock_irqrestore(&data->txlock, flags);
+	BT_DBG("returning %d", rv);
+
+	return rv;
+}
+
 static void btusb_intr_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
@@ -217,6 +241,7 @@ static void btusb_intr_complete(struct u
 	if (!test_bit(BTUSB_INTR_RUNNING, &data->flags))
 		return;
 
+	usb_mark_last_busy(data->udev);
 	usb_anchor_urb(urb, &data->intr_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -227,7 +252,7 @@ static void btusb_intr_complete(struct u
 	}
 }
 
-static int btusb_submit_intr_urb(struct hci_dev *hdev)
+static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -240,13 +265,13 @@ static int btusb_submit_intr_urb(struct
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
@@ -262,7 +287,7 @@ static int btusb_submit_intr_urb(struct
 
 	usb_anchor_urb(urb, &data->intr_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -301,6 +326,7 @@ static void btusb_bulk_complete(struct u
 	if (!test_bit(BTUSB_BULK_RUNNING, &data->flags))
 		return;
 
+	usb_mark_last_busy(data->udev);
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -311,7 +337,7 @@ static void btusb_bulk_complete(struct u
 	}
 }
 
-static int btusb_submit_bulk_urb(struct hci_dev *hdev)
+static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -324,18 +350,19 @@ static int btusb_submit_bulk_urb(struct
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
@@ -345,7 +372,7 @@ static int btusb_submit_bulk_urb(struct
 
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
-	err = usb_submit_urb(urb, GFP_KERNEL);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -483,6 +510,33 @@ static void btusb_tx_complete(struct urb
 {
 	struct sk_buff *skb = urb->context;
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
+	struct btusb_data *data = hdev->driver_data;
+
+	BT_DBG("%s urb %p status %d count %d", hdev->name,
+					urb, urb->status, urb->actual_length);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		goto done;
+
+	if (!urb->status)
+		hdev->stat.byte_tx += urb->transfer_buffer_length;
+	else
+		hdev->stat.err_tx++;
+
+done:
+	spin_lock(&data->txlock);
+	data->tx_in_flight--;
+	spin_unlock(&data->txlock);
+
+	kfree(urb->setup_packet);
+
+	kfree_skb(skb);
+}
+
+static void btusb_isoc_tx_complete(struct urb *urb)
+{
+	struct sk_buff *skb = urb->context;
+	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
@@ -508,13 +562,19 @@ static int btusb_open(struct hci_dev *hd
 
 	BT_DBG("%s", hdev->name);
 
+	err = usb_autopm_get_interface(data->acl);
+	if (err < 0)
+		return err;
+	data->acl->needs_remote_wakeup = 1;
+	usb_autopm_put_interface(data->acl);
+
 	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		return 0;
 
-	err = btusb_submit_intr_urb(hdev);
+	err = btusb_submit_intr_urb(hdev, GFP_ATOMIC);
 	if (err < 0) {
 		clear_bit(BTUSB_INTR_RUNNING, &hdev->flags);
 		clear_bit(HCI_RUNNING, &hdev->flags);
@@ -523,24 +583,34 @@ static int btusb_open(struct hci_dev *hd
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
+	int err;
 
 	BT_DBG("%s", hdev->name);
 
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
-
+	btusb_stop_traffic(data);
+	err = usb_autopm_get_interface(data->acl);
+	if (!err) {
+		data->acl->needs_remote_wakeup = 0;
+		usb_autopm_put_interface(data->acl);
+	}
 	return 0;
 }
 
@@ -571,6 +641,7 @@ static int btusb_send_frame(struct sk_bu
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
+		BT_DBG("HCI_COMMAND_PKT");
 		urb = usb_alloc_urb(0, GFP_ATOMIC);
 		if (!urb)
 			return -ENOMEM;
@@ -596,6 +667,7 @@ static int btusb_send_frame(struct sk_bu
 		break;
 
 	case HCI_ACLDATA_PKT:
+		BT_DBG("HCI_ACLDATA_PKT");
 		if (!data->bulk_tx_ep || hdev->conn_hash.acl_num < 1)
 			return -ENODEV;
 
@@ -613,6 +685,7 @@ static int btusb_send_frame(struct sk_bu
 		break;
 
 	case HCI_SCODATA_PKT:
+		BT_DBG("HCI_SCODATA_PKT");
 		if (!data->isoc_tx_ep || hdev->conn_hash.sco_num < 1)
 			return -ENODEV;
 
@@ -626,7 +699,7 @@ static int btusb_send_frame(struct sk_bu
 		urb->dev      = data->udev;
 		urb->pipe     = pipe;
 		urb->context  = skb;
-		urb->complete = btusb_tx_complete;
+		urb->complete = btusb_isoc_tx_complete;
 		urb->interval = data->isoc_tx_ep->bInterval;
 
 		urb->transfer_flags  = URB_ISO_ASAP;
@@ -637,12 +710,21 @@ static int btusb_send_frame(struct sk_bu
 				le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
 
 		hdev->stat.sco_tx++;
-		break;
+		goto skip_waking;
 
 	default:
 		return -EILSEQ;
 	}
 
+	err = inc_tx(data);
+	if (err) {
+		printk(KERN_ERR"Autosuspension detected\n");
+		usb_anchor_urb(urb, &data->deferred);
+		schedule_work(&data->waker);
+		err = 0;
+		goto out;
+	}
+skip_waking:
 	usb_anchor_urb(urb, &data->tx_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -654,6 +736,7 @@ static int btusb_send_frame(struct sk_bu
 
 	usb_free_urb(urb);
 
+out:
 	return err;
 }
 
@@ -672,8 +755,19 @@ static void btusb_notify(struct hci_dev
 
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
@@ -723,20 +817,19 @@ static void btusb_work(struct work_struc
 {
 	struct btusb_data *data = container_of(work, struct btusb_data, work);
 	struct hci_dev *hdev = data->hdev;
-
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
+	int err;
 
 	if (hdev->conn_hash.sco_num > 0) {
+		if (!data->did_iso_resume) {
+			err = usb_autopm_get_interface(data->isoc);
+			if (!err) {
+				data->did_iso_resume = 1;
+			} else {
+				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+				usb_kill_anchored_urbs(&data->isoc_anchor);
+				return;
+			}
+		}
 		if (data->isoc_altsetting != 2) {
 			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 			usb_kill_anchored_urbs(&data->isoc_anchor);
@@ -756,9 +849,26 @@ static void btusb_work(struct work_struc
 		usb_kill_anchored_urbs(&data->isoc_anchor);
 
 		__set_isoc_interface(hdev, 0);
+		if (data->did_iso_resume) {
+			data->did_iso_resume = 0;
+			usb_autopm_put_interface(data->isoc);
+		}
 	}
 }
 
+static void btusb_waker(struct work_struct *work)
+{
+	struct btusb_data *data = container_of(work, struct btusb_data, waker);
+	int err;
+
+	BUG_ON(data == NULL);
+	BT_DBG("about to resume");
+	BUG_ON(data->acl == NULL);
+	err = usb_autopm_get_interface(data->acl);
+	if (!err)
+		usb_autopm_put_interface(data->acl);
+}
+
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -821,15 +931,19 @@ static int btusb_probe(struct usb_interf
 	}
 
 	data->udev = interface_to_usbdev(intf);
+	data->acl = intf;
 
 	spin_lock_init(&data->lock);
 
 	INIT_WORK(&data->work, btusb_work);
+	INIT_WORK(&data->waker, btusb_waker);
+	spin_lock_init(&data->txlock);
 
 	init_usb_anchor(&data->tx_anchor);
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
 	init_usb_anchor(&data->isoc_anchor);
+	init_usb_anchor(&data->deferred);
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -889,7 +1003,7 @@ static int btusb_probe(struct usb_interf
 
 	if (data->isoc) {
 		err = usb_driver_claim_interface(&btusb_driver,
-							data->isoc, NULL);
+							data->isoc, data);
 		if (err < 0) {
 			hci_free_dev(hdev);
 			kfree(data);
@@ -921,21 +1035,131 @@ static void btusb_disconnect(struct usb_
 
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
+	printk(KERN_ERR"%s called\n", __func__);
+
+	if (data->susp_count++)
+		return 0;
+	spin_lock_irq(&data->txlock);
+	if (!(interface_to_usbdev(intf)->auto_pm && data->tx_in_flight)) {
+		set_bit(BTUSB_SUSPENDING, &data->flags);
+		printk(KERN_ERR"%s accepting\n", __func__);
+	} else {
+		spin_unlock_irq(&data->txlock);
+		printk(KERN_ERR"%s rejecting, count %d\n", __func__, data->tx_in_flight);
+		return -EBUSY;
+	}
+	spin_unlock_irq(&data->txlock);
+	cancel_work_sync(&data->work);
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+	BT_DBG("flags: %ld", data->flags);
+	return 0;
+}
+
+static int play_deferred(struct btusb_data *data)
+{
+	struct urb *urb;
+	int err = 0;
+
+	while ((urb = usb_get_from_anchor(&data->deferred))) {
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (err < 0)
+			break;
+		else
+			data->tx_in_flight++;
+	}
+	usb_scuttle_anchored_urbs(&data->deferred);
+	return err;
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
+
+		spin_lock_irq(&data->txlock);
+		ret = play_deferred(data);
+		clear_bit(BTUSB_SUSPENDING, &data->flags);
+		spin_unlock_irq(&data->txlock);
+
+		if (ret < 0) {
+			clear_bit(HCI_RUNNING, &hdev->flags);
+			return ret;
+		}
+
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
+	.supports_autosuspend = 1,
 };
 
 static int __init btusb_init(void)

From: Pavel Machek <pavel@suse.cz>
Subject: Re: [rft]autosuspend for btusb
Date: Tue, 26 Aug 2008 11:56:47 +0200
Message-ID: <20080826095647.GA30913__43903.2463510104$1219745046$gmane$org@elf.ucw.cz>
References: <200808221520.19791.oliver@neukum.org>
	<200808221551.57225.oliver@neukum.org>
	<1219415470.7591.472.camel@violet.holtmann.net>
	<200808251243.47569.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200808251243.47569.oliver@neukum.org>
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
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon 2008-08-25 12:43:46, Oliver Neukum wrote:
> Am Freitag 22 August 2008 16:31:10 schrieb Marcel Holtmann:
> > > > Please explain the tx_in_flight stuff to me. It looks unneeded since we
> > > > anchor all TX URBs anyway.
> > > 
> > > The completion of an URB may happen after the autosuspend timeout passed.
> > > But we cannot use the pm counters as they are not accessible in interrupt.
> > > Hence we must maintain a counter ourselves.
> > 
> > Can we not just check the number of URBs in the anchor? I am against
> > just duplicating a counter, but then lets call it it what it is to make
> > it gets not misused. It is a purely a PM counter.
> > 
> 
> An excellent suggestion allowing major simplifications. This version works
> for me. It required an extension of the anchor API, so it obsoletes
> the split-up you've done. Therefore the whole thing comes as a big patch
> against rc4, easy to test.

I could not get it to apply over -rc4-git, usb seems to be changing
under us :-(. After manual fixup (conflict was in comment), I still
get

  LD      .tmp_vmlinux1
drivers/built-in.o: In function `btusb_suspend':
btusb.c:(.text+0x20a578): undefined reference to `usb_anchor_empty'
drivers/built-in.o: In function `btusb_resume':
btusb.c:(.text+0x20ade6): undefined reference to `usb_get_from_anchor'
btusb.c:(.text+0x20ae01): undefined reference to
`usb_scuttle_anchored_urbs'
make: *** [.tmp_vmlinux1] Error 1
40.09user 7.55system 47.97 (0m47.971s) elapsed 99.34%CPU
pavel@amd:/data/l/linux-good$

...probably the "already applied" patch it complained about was not so
applied after all.

...ok, I got it to apply, compile, resulting patch is attached.
									Pavel

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6a01068..62a9a5b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -35,13 +35,13 @@ #include <linux/usb.h>
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
@@ -165,10 +165,12 @@ #define BTUSB_MAX_ISOC_FRAMES	10
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
@@ -176,11 +178,13 @@ struct btusb_data {
 	unsigned long flags;
 
 	struct work_struct work;
+	struct work_struct waker;
 
 	struct usb_anchor tx_anchor;
 	struct usb_anchor intr_anchor;
 	struct usb_anchor bulk_anchor;
 	struct usb_anchor isoc_anchor;
+	struct usb_anchor deferred;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
@@ -189,6 +193,8 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *isoc_rx_ep;
 
 	int isoc_altsetting;
+	int did_iso_resume:1;
+	int susp_count;
 };
 
 static void btusb_intr_complete(struct urb *urb)
@@ -217,6 +223,7 @@ static void btusb_intr_complete(struct u
 	if (!test_bit(BTUSB_INTR_RUNNING, &data->flags))
 		return;
 
+	usb_mark_last_busy(data->udev);
 	usb_anchor_urb(urb, &data->intr_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -227,7 +234,7 @@ static void btusb_intr_complete(struct u
 	}
 }
 
-static int btusb_submit_intr_urb(struct hci_dev *hdev)
+static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -240,13 +247,13 @@ static int btusb_submit_intr_urb(struct 
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
@@ -262,7 +269,7 @@ static int btusb_submit_intr_urb(struct 
 
 	usb_anchor_urb(urb, &data->intr_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -301,6 +308,7 @@ static void btusb_bulk_complete(struct u
 	if (!test_bit(BTUSB_BULK_RUNNING, &data->flags))
 		return;
 
+	usb_mark_last_busy(data->udev);
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -311,7 +319,7 @@ static void btusb_bulk_complete(struct u
 	}
 }
 
-static int btusb_submit_bulk_urb(struct hci_dev *hdev)
+static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -324,18 +332,19 @@ static int btusb_submit_bulk_urb(struct 
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
@@ -345,7 +354,7 @@ static int btusb_submit_bulk_urb(struct 
 
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
-	err = usb_submit_urb(urb, GFP_KERNEL);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -508,13 +517,19 @@ static int btusb_open(struct hci_dev *hd
 
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
@@ -523,24 +538,34 @@ static int btusb_open(struct hci_dev *hd
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
 
@@ -562,7 +587,7 @@ static int btusb_send_frame(struct sk_bu
 	struct usb_ctrlrequest *dr;
 	struct urb *urb;
 	unsigned int pipe;
-	int err;
+	int err, susp;
 
 	BT_DBG("%s", hdev->name);
 
@@ -571,6 +596,7 @@ static int btusb_send_frame(struct sk_bu
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
+		BT_DBG("HCI_COMMAND_PKT");
 		urb = usb_alloc_urb(0, GFP_ATOMIC);
 		if (!urb)
 			return -ENOMEM;
@@ -596,6 +622,7 @@ static int btusb_send_frame(struct sk_bu
 		break;
 
 	case HCI_ACLDATA_PKT:
+		BT_DBG("HCI_ACLDATA_PKT");
 		if (!data->bulk_tx_ep || hdev->conn_hash.acl_num < 1)
 			return -ENODEV;
 
@@ -613,6 +640,7 @@ static int btusb_send_frame(struct sk_bu
 		break;
 
 	case HCI_SCODATA_PKT:
+		BT_DBG("HCI_SCODATA_PKT");
 		if (!data->isoc_tx_ep || hdev->conn_hash.sco_num < 1)
 			return -ENODEV;
 
@@ -643,17 +671,22 @@ static int btusb_send_frame(struct sk_bu
 		return -EILSEQ;
 	}
 
+	spin_lock(&data->lock);
+	susp = test_bit(BTUSB_SUSPENDING, &data->flags);
 	usb_anchor_urb(urb, &data->tx_anchor);
-
-	err = usb_submit_urb(urb, GFP_ATOMIC);
-	if (err < 0) {
-		BT_ERR("%s urb %p submission failed", hdev->name, urb);
-		kfree(urb->setup_packet);
-		usb_unanchor_urb(urb);
+	if (susp) {
+		schedule_work(&data->waker);
+		err = 0;
+	} else {
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (err < 0) {
+			BT_ERR("%s urb %p submission failed", hdev->name, urb);
+			kfree(urb->setup_packet);
+			usb_unanchor_urb(urb);
+		}
+		usb_free_urb(urb);
 	}
-
-	usb_free_urb(urb);
-
+	spin_unlock(&data->lock);
 	return err;
 }
 
@@ -672,8 +705,19 @@ static void btusb_notify(struct hci_dev 
 
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
@@ -723,20 +767,19 @@ static void btusb_work(struct work_struc
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
@@ -756,9 +799,26 @@ static void btusb_work(struct work_struc
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
@@ -821,15 +881,18 @@ static int btusb_probe(struct usb_interf
 	}
 
 	data->udev = interface_to_usbdev(intf);
+	data->acl = intf;
 
 	spin_lock_init(&data->lock);
 
 	INIT_WORK(&data->work, btusb_work);
+	INIT_WORK(&data->waker, btusb_waker);
 
 	init_usb_anchor(&data->tx_anchor);
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
 	init_usb_anchor(&data->isoc_anchor);
+	init_usb_anchor(&data->deferred);
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -889,7 +952,7 @@ static int btusb_probe(struct usb_interf
 
 	if (data->isoc) {
 		err = usb_driver_claim_interface(&btusb_driver,
-							data->isoc, NULL);
+							data->isoc, data);
 		if (err < 0) {
 			hci_free_dev(hdev);
 			kfree(data);
@@ -921,21 +984,128 @@ static void btusb_disconnect(struct usb_
 
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
+	spin_lock_irq(&data->lock);
+	if (	interface_to_usbdev(intf)->auto_pm &&
+		!usb_anchor_empty(&data->tx_anchor)) {
+		spin_unlock_irq(&data->lock);
+		return -EBUSY;
+	}
+
+	set_bit(BTUSB_SUSPENDING, &data->flags);
+	spin_unlock_irq(&data->lock);
+
+	cancel_work_sync(&data->work);
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+	return 0;
+}
+
+static int play_deferred(struct btusb_data *data)
+{
+	struct urb *urb;
+	int err = 0;
+
+	while ((urb = usb_get_from_anchor(&data->tx_anchor))) {
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (err < 0)
+			break;
+	}
+	usb_scuttle_anchored_urbs(&data->tx_anchor);
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
+		spin_lock_irq(&data->lock);
+		ret = play_deferred(data);
+		clear_bit(BTUSB_SUSPENDING, &data->flags);
+		spin_unlock_irq(&data->lock);
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
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 47111e8..0ceb312 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -633,3 +633,61 @@ int usb_wait_anchor_empty_timeout(struct
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
+int usb_anchor_empty(struct usb_anchor *anchor)
+{
+	unsigned long flags;
+	int rv;
+
+	spin_lock_irqsave(&anchor->lock, flags);
+	rv = list_empty(&anchor->urb_list);
+	spin_unlock_irqrestore(&anchor->lock, flags);
+
+	return rv;
+}
+
+EXPORT_SYMBOL_GPL(usb_anchor_empty);
+
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 94ac74a..4f09a57 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -112,8 +112,6 @@ enum usb_interface_condition {
  *	capability during autosuspend.
  * @needs_altsetting0: flag set when a set-interface request for altsetting 0
  *	has been deferred.
- * @needs_binding: flag set when the driver should be re-probed or unbound
- *	following a reset or suspend operation it doesn't support.
  * @dev: driver model's view of this device
  * @usb_dev: if an interface is bound to the USB major, this will point
  *	to the sysfs representation for that device.
@@ -1465,6 +1463,9 @@ extern void usb_anchor_urb(struct urb *u
 extern void usb_unanchor_urb(struct urb *urb);
 extern int usb_wait_anchor_empty_timeout(struct usb_anchor *anchor,
 					 unsigned int timeout);
+extern struct urb *usb_get_from_anchor(struct usb_anchor *anchor);
+extern void usb_scuttle_anchored_urbs(struct usb_anchor *anchor);
+extern int usb_anchor_empty(struct usb_anchor *anchor);
 
 /**
  * usb_urb_dir_in - check if an URB describes an IN transfer

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

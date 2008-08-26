From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Tue, 26 Aug 2008 11:36:04 +0200
Message-ID: <200808261136.05666.rjw__33688.9908802279$1219743413$gmane$org@sisk.pl>
References: <200808221520.19791.oliver@neukum.org>
	<BEF46EAA-4013-44BB-881F-F1740FE8BE6D@holtmann.org>
	<200808251550.46303.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808251550.46303.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

[Sorry for the delayed reply.]

On Monday, 25 of August 2008, Oliver Neukum wrote:
> Am Montag 25 August 2008 13:54:31 schrieb Marcel Holtmann:
> > Oliver, can you come up with a small test patch, that just kills all =
=A0
> > URB when suspend and submits the interrupt ones at resume. Such a =A0
> > patch might have to be merged for 2.6.27 if it fixes this problem.
> =

> Rafael,
> =

> this patch implemts suspend/resume for btusb and fixes a disconnect
> problem. Does it help you?

Yes, the patch appears to help.

I haven't had a single crash since I applied it.  I'm going to test it a bit
more today, though.

> ---

BTW, this change:

> --- linux-2.6.27-rc4/drivers/usb/core/urb.c	2008-08-21 10:03:44.000000000=
 +0200
> +++ linux-2.6.27-rc3/drivers/usb/core/urb.c	2008-08-22 17:25:49.000000000=
 +0200
> @@ -601,15 +601,20 @@ EXPORT_SYMBOL_GPL(usb_kill_anchored_urbs
>  void usb_unlink_anchored_urbs(struct usb_anchor *anchor)
>  {
>  	struct urb *victim;
> +	unsigned long flags;
>  =

> -	spin_lock_irq(&anchor->lock);
> +	spin_lock_irqsave(&anchor->lock, flags);
>  	while (!list_empty(&anchor->urb_list)) {
>  		victim =3D list_entry(anchor->urb_list.prev, struct urb,
>  				    anchor_list);
> +		usb_get_urb(victim);
> +		spin_unlock_irqrestore(&anchor->lock, flags);
>  		/* this will unanchor the URB */
>  		usb_unlink_urb(victim);
> +		usb_put_urb(victim);
> +		spin_lock_irqsave(&anchor->lock, flags);
>  	}
> -	spin_unlock_irq(&anchor->lock);
> +	spin_unlock_irqrestore(&anchor->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(usb_unlink_anchored_urbs);
>

is apparently already in the mainline.

Thanks,
Rafael


> --- linux-2.6.27-rc4/drivers/bluetooth/btusb.c.alt	2008-08-25 15:02:14.00=
0000000 +0200
> +++ linux-2.6.27-rc4/drivers/bluetooth/btusb.c	2008-08-25 15:44:25.000000=
000 +0200
> @@ -169,6 +169,7 @@ static struct usb_device_id blacklist_ta
>  struct btusb_data {
>  	struct hci_dev       *hdev;
>  	struct usb_device    *udev;
> +	struct usb_interface *acl;
>  	struct usb_interface *isoc;
>  =

>  	spinlock_t lock;
> @@ -176,6 +177,7 @@ struct btusb_data {
>  	unsigned long flags;
>  =

>  	struct work_struct work;
> +	struct work_struct waker;
>  =

>  	struct usb_anchor tx_anchor;
>  	struct usb_anchor intr_anchor;
> @@ -189,6 +191,7 @@ struct btusb_data {
>  	struct usb_endpoint_descriptor *isoc_rx_ep;
>  =

>  	int isoc_altsetting;
> +	int susp_count;
>  };
>  =

>  static void btusb_intr_complete(struct urb *urb)
> @@ -227,7 +230,7 @@ static void btusb_intr_complete(struct u
>  	}
>  }
>  =

> -static int btusb_submit_intr_urb(struct hci_dev *hdev)
> +static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t gfp)
>  {
>  	struct btusb_data *data =3D hdev->driver_data;
>  	struct urb *urb;
> @@ -240,13 +243,13 @@ static int btusb_submit_intr_urb(struct
>  	if (!data->intr_ep)
>  		return -ENODEV;
>  =

> -	urb =3D usb_alloc_urb(0, GFP_ATOMIC);
> +	urb =3D usb_alloc_urb(0, gfp);
>  	if (!urb)
>  		return -ENOMEM;
>  =

>  	size =3D le16_to_cpu(data->intr_ep->wMaxPacketSize);
>  =

> -	buf =3D kmalloc(size, GFP_ATOMIC);
> +	buf =3D kmalloc(size, gfp);
>  	if (!buf) {
>  		usb_free_urb(urb);
>  		return -ENOMEM;
> @@ -262,7 +265,7 @@ static int btusb_submit_intr_urb(struct
>  =

>  	usb_anchor_urb(urb, &data->intr_anchor);
>  =

> -	err =3D usb_submit_urb(urb, GFP_ATOMIC);
> +	err =3D usb_submit_urb(urb, gfp);
>  	if (err < 0) {
>  		BT_ERR("%s urb %p submission failed (%d)",
>  						hdev->name, urb, -err);
> @@ -311,7 +314,7 @@ static void btusb_bulk_complete(struct u
>  	}
>  }
>  =

> -static int btusb_submit_bulk_urb(struct hci_dev *hdev)
> +static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t gfp)
>  {
>  	struct btusb_data *data =3D hdev->driver_data;
>  	struct urb *urb;
> @@ -324,18 +327,19 @@ static int btusb_submit_bulk_urb(struct
>  	if (!data->bulk_rx_ep)
>  		return -ENODEV;
>  =

> -	urb =3D usb_alloc_urb(0, GFP_KERNEL);
> +	urb =3D usb_alloc_urb(0, gfp);
>  	if (!urb)
>  		return -ENOMEM;
>  =

>  	size =3D le16_to_cpu(data->bulk_rx_ep->wMaxPacketSize);
>  =

> -	buf =3D kmalloc(size, GFP_KERNEL);
> +	buf =3D kmalloc(size, gfp);
>  	if (!buf) {
>  		usb_free_urb(urb);
>  		return -ENOMEM;
>  	}
>  =

> +	usb_mark_last_busy(data->udev);
>  	pipe =3D usb_rcvbulkpipe(data->udev, data->bulk_rx_ep->bEndpointAddress=
);
>  =

>  	usb_fill_bulk_urb(urb, data->udev, pipe,
> @@ -345,7 +349,7 @@ static int btusb_submit_bulk_urb(struct
>  =

>  	usb_anchor_urb(urb, &data->bulk_anchor);
>  =

> -	err =3D usb_submit_urb(urb, GFP_KERNEL);
> +	err =3D usb_submit_urb(urb, gfp);
>  	if (err < 0) {
>  		BT_ERR("%s urb %p submission failed (%d)",
>  						hdev->name, urb, -err);
> @@ -514,7 +518,7 @@ static int btusb_open(struct hci_dev *hd
>  	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
>  		return 0;
>  =

> -	err =3D btusb_submit_intr_urb(hdev);
> +	err =3D btusb_submit_intr_urb(hdev, GFP_KERNEL);
>  	if (err < 0) {
>  		clear_bit(BTUSB_INTR_RUNNING, &hdev->flags);
>  		clear_bit(HCI_RUNNING, &hdev->flags);
> @@ -523,6 +527,13 @@ static int btusb_open(struct hci_dev *hd
>  	return err;
>  }
>  =

> +static void btusb_stop_traffic(struct btusb_data *data)
> +{
> +	usb_kill_anchored_urbs(&data->intr_anchor);
> +	usb_kill_anchored_urbs(&data->bulk_anchor);
> +	usb_kill_anchored_urbs(&data->isoc_anchor);
> +}
> +
>  static int btusb_close(struct hci_dev *hdev)
>  {
>  	struct btusb_data *data =3D hdev->driver_data;
> @@ -532,14 +543,12 @@ static int btusb_close(struct hci_dev *h
>  	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
>  		return 0;
>  =

> -	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> -	usb_kill_anchored_urbs(&data->intr_anchor);
> +	flush_work(&data->work);
>  =

> +	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>  	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> -	usb_kill_anchored_urbs(&data->bulk_anchor);
> -
>  	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> -	usb_kill_anchored_urbs(&data->intr_anchor);
> +	btusb_stop_traffic(data);
>  =

>  	return 0;
>  }
> @@ -672,8 +681,19 @@ static void btusb_notify(struct hci_dev
>  =

>  	BT_DBG("%s evt %d", hdev->name, evt);
>  =

> -	if (evt =3D=3D HCI_NOTIFY_CONN_ADD || evt =3D=3D HCI_NOTIFY_CONN_DEL)
> -		schedule_work(&data->work);
> +	if (hdev->conn_hash.acl_num > 0) {
> +		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
> +			if (btusb_submit_bulk_urb(hdev, GFP_ATOMIC) < 0)
> +				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> +			else
> +				btusb_submit_bulk_urb(hdev, GFP_ATOMIC);
> +		}
> +	} else {
> +		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> +		usb_unlink_anchored_urbs(&data->bulk_anchor);
> +	}
> +
> +	schedule_work(&data->work);
>  }
>  =

>  static int inline __set_isoc_interface(struct hci_dev *hdev, int altsett=
ing)
> @@ -724,18 +744,6 @@ static void btusb_work(struct work_struc
>  	struct btusb_data *data =3D container_of(work, struct btusb_data, work);
>  	struct hci_dev *hdev =3D data->hdev;
>  =

> -	if (hdev->conn_hash.acl_num > 0) {
> -		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
> -			if (btusb_submit_bulk_urb(hdev) < 0)
> -				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> -			else
> -				btusb_submit_bulk_urb(hdev);
> -		}
> -	} else {
> -		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> -		usb_kill_anchored_urbs(&data->bulk_anchor);
> -	}
> -
>  	if (hdev->conn_hash.sco_num > 0) {
>  		if (data->isoc_altsetting !=3D 2) {
>  			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> @@ -821,6 +829,7 @@ static int btusb_probe(struct usb_interf
>  	}
>  =

>  	data->udev =3D interface_to_usbdev(intf);
> +	data->acl =3D intf;
>  =

>  	spin_lock_init(&data->lock);
>  =

> @@ -889,7 +898,7 @@ static int btusb_probe(struct usb_interf
>  =

>  	if (data->isoc) {
>  		err =3D usb_driver_claim_interface(&btusb_driver,
> -							data->isoc, NULL);
> +							data->isoc, data);
>  		if (err < 0) {
>  			hci_free_dev(hdev);
>  			kfree(data);
> @@ -921,20 +930,92 @@ static void btusb_disconnect(struct usb_
>  =

>  	hdev =3D data->hdev;
>  =

> -	if (data->isoc)
> -		usb_driver_release_interface(&btusb_driver, data->isoc);
> +	/* make sure we have a reference */
> +	__hci_dev_hold(hdev);
>  =

> -	usb_set_intfdata(intf, NULL);
> +	usb_set_intfdata(data->acl, NULL);
> +	if (data->isoc)
> +		usb_set_intfdata(data->isoc, NULL);
>  =

> +	/* unregister before releasing any interface */
>  	hci_unregister_dev(hdev);
>  =

> +	if (intf =3D=3D data->isoc)
> +		usb_driver_release_interface(&btusb_driver, data->acl);
> +	else if (data->isoc)
> +		usb_driver_release_interface(&btusb_driver, data->isoc);
> +
> +	/* release the reference */
> +	__hci_dev_put(hdev);
>  	hci_free_dev(hdev);
>  }
>  =

> +static int btusb_suspend(struct usb_interface *intf, pm_message_t messag=
e)
> +{
> +	struct btusb_data *data =3D usb_get_intfdata(intf);
> +
> +	BT_DBG("%s called\n", __func__);
> +
> +	if (data->susp_count++)
> +		return 0;
> +
> +	cancel_work_sync(&data->work);
> +	btusb_stop_traffic(data);
> +	usb_kill_anchored_urbs(&data->tx_anchor);
> +	return 0;
> +}
> +
> +static int btusb_resume(struct usb_interface *intf)
> +{
> +	struct btusb_data *data =3D usb_get_intfdata(intf);
> +	struct hci_dev *hdev =3D data->hdev;
> +	int ret;
> +
> +	if (--data->susp_count)
> +		return 0;
> +	if (test_bit(HCI_RUNNING, &hdev->flags)) {
> +		ret =3D btusb_submit_intr_urb(hdev, GFP_NOIO);
> +		if (ret < 0) {
> +			clear_bit(HCI_RUNNING, &hdev->flags);
> +			return ret;
> +		}
> +	}
> +
> +	if (hdev->conn_hash.acl_num > 0) {
> +		ret =3D btusb_submit_bulk_urb(hdev, GFP_NOIO);
> +		if (ret < 0) {
> +			clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> +			return ret;
> +		} else {
> +			ret =3D btusb_submit_bulk_urb(hdev, GFP_NOIO);
> +			if (ret < 0) {
> +				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> +				usb_kill_anchored_urbs(&data->bulk_anchor);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	if (data->isoc) {
> +		if (test_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
> +			ret =3D btusb_submit_isoc_urb(hdev);
> +			if (ret < 0)
> +				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> +			else
> +				btusb_submit_isoc_urb(hdev);
> +		}
> +	}
> +
> +	schedule_work(&data->work);
> +	return 0;
> +}
> +
>  static struct usb_driver btusb_driver =3D {
>  	.name		=3D "btusb",
>  	.probe		=3D btusb_probe,
>  	.disconnect	=3D btusb_disconnect,
> +	.suspend	=3D btusb_suspend,
> +	.resume		=3D btusb_resume,
>  	.id_table	=3D btusb_table,
>  };
>  =

> =

> =

> =

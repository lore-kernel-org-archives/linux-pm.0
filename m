From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Tue, 17 Apr 2012 14:26:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204171423310.1163-100000@iolanthe.rowland.org>
References: <20120417175122.GM11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120417175122.GM11484-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Apr 2012, Andrey Rahmatullin wrote:

> > If you manage to reach the end of this list, you'll essentially be
> > doing a normal suspend (except for the PCI_UNKNOWN part).
> It works without changes #2..8. I'm attaching the resulting patch.

Wow.  Okay, I have boiled this down to a single patch.  You should 
try this both with and without unbinding ehci-hcd, and post the dmesg 
log output that it generates in the two cases.

Alan Stern



Index: usb-3.4/drivers/pci/pci-driver.c
===================================================================
--- usb-3.4.orig/drivers/pci/pci-driver.c
+++ usb-3.4/drivers/pci/pci-driver.c
@@ -713,6 +713,8 @@ static int pci_pm_suspend_noirq(struct d
 
 	if (!pm) {
 		pci_save_state(pci_dev);
+		pci_prepare_to_sleep(pci_dev);
+		pci_pm_set_unknown_state(pci_dev);
 		return 0;
 	}
 
Index: usb-3.4/drivers/pci/pci.c
===================================================================
--- usb-3.4.orig/drivers/pci/pci.c
+++ usb-3.4/drivers/pci/pci.c
@@ -1710,6 +1710,7 @@ pci_power_t pci_target_state(struct pci_
  */
 int pci_prepare_to_sleep(struct pci_dev *dev)
 {
+	pci_power_t cur_state = dev->current_state;
 	pci_power_t target_state = pci_target_state(dev);
 	int error;
 
@@ -1723,6 +1724,8 @@ int pci_prepare_to_sleep(struct pci_dev
 	if (error)
 		pci_enable_wake(dev, target_state, false);
 
+	dev_info(&dev->dev, "cur %d target %d error %d\n", cur_state,
+			target_state, error);
 	return error;
 }
 
Index: usb-3.4/drivers/usb/core/hcd-pci.c
===================================================================
--- usb-3.4.orig/drivers/usb/core/hcd-pci.c
+++ usb-3.4/drivers/usb/core/hcd-pci.c
@@ -433,6 +433,7 @@ static int suspend_common(struct device
 	 * low power state during suspend_noirq, if the hardware allows.
 	 */
 	pci_disable_device(pci_dev);
+	pci_dev->current_state = PCI_UNKNOWN;
 	return retval;
 }
 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: power_state: remove it from usb
Date: Thu, 21 Feb 2008 14:01:45 +0100
Message-ID: <20080221130145.GA3789@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


power_state is scheduled for removal, and it is used only write-only
by USB. Remove it.

Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 801b6f1..eeb8115 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -794,8 +794,6 @@ static int usb_suspend_device(struct usb
 
  done:
 	dev_vdbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
-	if (status == 0)
-		udev->dev.power.power_state.event = msg.event;
 	return status;
 }
 
@@ -826,7 +824,6 @@ static int usb_resume_device(struct usb_
 	dev_vdbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
 	if (status == 0) {
 		udev->autoresume_disabled = 0;
-		udev->dev.power.power_state.event = PM_EVENT_ON;
 	}
 	return status;
 }
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 84760dd..739407b 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -73,7 +73,6 @@ int usb_hcd_pci_probe(struct pci_dev *de
 	if (pci_enable_device(dev) < 0)
 		return -ENODEV;
 	dev->current_state = PCI_D0;
-	dev->dev.power.power_state = PMSG_ON;
 
 	if (!dev->irq) {
 		dev_err(&dev->dev,
@@ -302,8 +301,6 @@ int usb_hcd_pci_suspend(struct pci_dev *
 
 done:
 	if (retval == 0) {
-		dev->dev.power.power_state = PMSG_SUSPEND;
-
 #ifdef CONFIG_PPC_PMAC
 		/* Disable ASIC clocks for USB */
 		if (machine_is(powermac)) {
@@ -406,8 +403,6 @@ #endif
 	pci_set_master(dev);
 	pci_restore_state(dev);
 
-	dev->dev.power.power_state = PMSG_ON;
-
 	clear_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 
 	if (hcd->driver->resume) {
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 2375194..1bf8ccb 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -114,13 +114,11 @@ static inline int is_usb_device_driver(s
 static inline void mark_active(struct usb_interface *f)
 {
 	f->is_active = 1;
-	f->dev.power.power_state.event = PM_EVENT_ON;
 }
 
 static inline void mark_quiesced(struct usb_interface *f)
 {
 	f->is_active = 0;
-	f->dev.power.power_state.event = PM_EVENT_SUSPEND;
 }
 
 static inline int is_active(const struct usb_interface *f)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

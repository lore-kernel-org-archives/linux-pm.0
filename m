From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] USB: implement non-tree resume ordering
 constraints for PCI host controllers
Date: Mon, 1 Feb 2010 16:00:28 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002011531490.1368-100000__3711.16290702975$1265058090$gmane$org@iolanthe.rowland.org>
References: <201001252226.29289.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001252226.29289.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Jan 2010, Rafael J. Wysocki wrote:

> On Monday 25 January 2010, Alan Stern wrote:
> > On Mon, 25 Jan 2010, Rafael J. Wysocki wrote:
> > 
> > > > I intend to write this code, but merging it will be a little tricky.  
> > > > You'll have to coordinate with Greg KH.
> > > 
> > > OK, I don't think that's a big deal.  I can defer patch 7/8 until that code has
> > > been merged.
> > 
> > You may have to delay 6/8 as well, since the controllers are PCI
> > devices.  Writing the new code shouldn't take too long, though.
> 
> No problem with that.
> 
> Alternatively, if Greg agrees, I can add your patches modifying this into this
> series.  Greg?

The patch is below.  It does indeed prevent unwanted disconnects during 
system resume.  However I don't know whether it will apply cleanly to 
anybody's tree but my own.  :-)

Alan Stern


------------------------------------------------------------------------

This patch (as1331) adds non-tree ordering constraints needed for
proper resume of PCI USB host controllers from hibernation.  The main
issue is that non-high-speed devices must not be resumed before the
high-speed root hub, because it is the ehci_bus_resume() routine which
takes care of handing the device connection over to the companion
controller.  If the device resume is attempted before the handover
then the device won't be found and it will be treated as though it had
disconnected.

The patch adds a new field to the usb_bus structure; for each
full/low-speed bus this field will contain a pointer to the companion
high-speed bus (if one exists).  It is used during normal device
resume; if the hs_companion pointer isn't NULL then we wait for the
root-hub device on the hs_companion bus.

A secondary issue is that an EHCI controlller shouldn't be resumed
before any of its companions.  On some machines I have observed
handovers failing if the companion controller is reinitialized after
the handover.  Thus, the EHCI resume routine must wait for the
companion controllers to be resumed.

The patch also fixes a small bug in usb_hcd_pci_probe(); an error path
jumps to the wrong label, causing a memory leak.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/include/linux/usb.h
===================================================================
--- usb-2.6.orig/include/linux/usb.h
+++ usb-2.6/include/linux/usb.h
@@ -336,6 +336,7 @@ struct usb_bus {
 
 	struct usb_devmap devmap;	/* device address allocation map */
 	struct usb_device *root_hub;	/* Root hub */
+	struct usb_bus *hs_companion;	/* Companion EHCI bus, if any */
 	struct list_head bus_list;	/* list of busses */
 
 	int bandwidth_allocated;	/* on this bus: how much of the time
Index: usb-2.6/drivers/usb/core/driver.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/driver.c
+++ usb-2.6/drivers/usb/core/driver.c
@@ -1039,6 +1039,14 @@ static int usb_resume_device(struct usb_
 		goto done;
 	}
 
+	/* Non-root devices on a full/low-speed bus must wait for their
+	 * companion high-speed root hub, in case a handoff is needed.
+	 */
+	if (!(msg.event & PM_EVENT_AUTO) && udev->parent &&
+			udev->bus->hs_companion)
+		device_pm_wait_for_dev(&udev->dev,
+				&udev->bus->hs_companion->root_hub->dev);
+
 	if (udev->quirks & USB_QUIRK_RESET_RESUME)
 		udev->reset_resume = 1;
 
Index: usb-2.6/drivers/usb/core/hcd-pci.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/hcd-pci.c
+++ usb-2.6/drivers/usb/core/hcd-pci.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/usb.h>
 
 #include <asm/io.h>
@@ -37,6 +38,112 @@
 
 /* PCI-based HCs are common, but plenty of non-PCI HCs are used too */
 
+/* Coordinate handoffs between EHCI and companion controllers
+ * during system resume
+ */
+
+static DEFINE_MUTEX(companions_mutex);
+
+#define CL_UHCI		PCI_CLASS_SERIAL_USB_UHCI
+#define CL_OHCI		PCI_CLASS_SERIAL_USB_OHCI
+#define CL_EHCI		PCI_CLASS_SERIAL_USB_EHCI
+
+enum companion_action {
+	SET_HS_COMPANION, CLEAR_HS_COMPANION, WAIT_FOR_COMPANIONS
+};
+
+static void companion_common(struct pci_dev *pdev, struct usb_hcd *hcd,
+		enum companion_action action)
+{
+	struct pci_dev		*companion;
+	struct usb_hcd		*companion_hcd;
+	unsigned int		slot = PCI_SLOT(pdev->devfn);
+
+	/* Iterate through other PCI functions in the same slot.
+	 * If pdev is OHCI or UHCI then we are looking for EHCI, and
+	 * vice versa.
+	 */
+	companion = NULL;
+	for (;;) {
+		companion = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, companion);
+		if (!companion)
+			break;
+		if (companion->bus != pdev->bus ||
+				PCI_SLOT(companion->devfn) != slot)
+			continue;
+
+		companion_hcd = pci_get_drvdata(companion);
+		if (!companion_hcd)
+			continue;
+
+		/* For SET_HS_COMPANION, store a pointer to the EHCI bus in
+		 * the OHCI/UHCI companion bus structure.
+		 * For CLEAR_HS_COMPANION, clear the pointer to the EHCI bus
+		 * in the OHCI/UHCI companion bus structure.
+		 * For WAIT_FOR_COMPANIONS, wait until the OHCI/UHCI
+		 * companion controllers have fully resumed.
+		 */
+
+		if ((pdev->class == CL_OHCI || pdev->class == CL_UHCI) &&
+				companion->class == CL_EHCI) {
+			/* action must be SET_HS_COMPANION */
+			dev_dbg(&companion->dev, "HS companion for %s\n",
+					dev_name(&pdev->dev));
+			hcd->self.hs_companion = &companion_hcd->self;
+
+		} else if (pdev->class == CL_EHCI &&
+				(companion->class == CL_OHCI ||
+				companion->class == CL_UHCI)) {
+			switch (action) {
+			case SET_HS_COMPANION:
+				dev_dbg(&pdev->dev, "HS companion for %s\n",
+						dev_name(&companion->dev));
+				companion_hcd->self.hs_companion = &hcd->self;
+				break;
+			case CLEAR_HS_COMPANION:
+				companion_hcd->self.hs_companion = NULL;
+				break;
+			case WAIT_FOR_COMPANIONS:
+				device_pm_wait_for_dev(&pdev->dev,
+						&companion->dev);
+				break;
+			}
+		}
+	}
+}
+
+static void set_hs_companion(struct pci_dev *pdev, struct usb_hcd *hcd)
+{
+	mutex_lock(&companions_mutex);
+	dev_set_drvdata(&pdev->dev, hcd);
+	companion_common(pdev, hcd, SET_HS_COMPANION);
+	mutex_unlock(&companions_mutex);
+}
+
+static void clear_hs_companion(struct pci_dev *pdev, struct usb_hcd *hcd)
+{
+	mutex_lock(&companions_mutex);
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	/* If pdev is OHCI or UHCI, just clear its hs_companion pointer */
+	if (pdev->class == CL_OHCI || pdev->class == CL_UHCI)
+		hcd->self.hs_companion = NULL;
+
+	/* Otherwise search for companion buses and clear their pointers */
+	else
+		companion_common(pdev, hcd, CLEAR_HS_COMPANION);
+	mutex_unlock(&companions_mutex);
+}
+
+static void wait_for_companions(struct pci_dev *pdev, struct usb_hcd *hcd)
+{
+	/* Only EHCI controllers need to wait.
+	 * No locking is needed because a controller cannot be resumed
+	 * while one of its companions is getting unbound.
+	 */
+	if (pdev->class == CL_EHCI)
+		companion_common(pdev, hcd, WAIT_FOR_COMPANIONS);
+}
 
 /*-------------------------------------------------------------------------*/
 
@@ -123,7 +230,7 @@ int usb_hcd_pci_probe(struct pci_dev *de
 		if (region == PCI_ROM_RESOURCE) {
 			dev_dbg(&dev->dev, "no i/o regions available\n");
 			retval = -EBUSY;
-			goto err1;
+			goto err2;
 		}
 	}
 
@@ -132,6 +239,7 @@ int usb_hcd_pci_probe(struct pci_dev *de
 	retval = usb_add_hcd(hcd, dev->irq, IRQF_DISABLED | IRQF_SHARED);
 	if (retval != 0)
 		goto err4;
+	set_hs_companion(dev, hcd);
 	return retval;
 
  err4:
@@ -142,6 +250,7 @@ int usb_hcd_pci_probe(struct pci_dev *de
 	} else
 		release_region(hcd->rsrc_start, hcd->rsrc_len);
  err2:
+	clear_hs_companion(dev, hcd);
 	usb_put_hcd(hcd);
  err1:
 	pci_disable_device(dev);
@@ -180,6 +289,7 @@ void usb_hcd_pci_remove(struct pci_dev *
 	} else {
 		release_region(hcd->rsrc_start, hcd->rsrc_len);
 	}
+	clear_hs_companion(dev, hcd);
 	usb_put_hcd(hcd);
 	pci_disable_device(dev);
 }
@@ -344,6 +454,11 @@ static int resume_common(struct device *
 	clear_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 
 	if (hcd->driver->pci_resume) {
+		/* This call should be made only during system resume,
+		 * not during runtime resume.
+		 */
+		wait_for_companions(pci_dev, hcd);
+
 		retval = hcd->driver->pci_resume(hcd, hibernated);
 		if (retval) {
 			dev_err(dev, "PCI post-resume error %d!\n", retval);

From: David Brownell <david-b@pacbell.net>
Subject: [patch/rft 2.6.17-rc5-git 5/6] PM_EVENT_PRETHAW,
	handle for USB
Date: Mon, 5 Jun 2006 09:38:42 -0700
Message-ID: <200606050938.42562.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_S4FhETO37E7yGLe"
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_S4FhETO37E7yGLe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This teaches several USB host controller drivers to treat PRETHAW as a
chip reset since the controller, and all devices connected to it, are no
longer in states compatible with how the snapshotted suspend() left them.
---
 drivers/usb/core/hcd-pci.c   |    2 +-
 drivers/usb/core/usb.c       |    2 +-
 drivers/usb/host/ehci-pci.c  |    6 ++++++
 drivers/usb/host/ohci-pci.c  |    5 +++++
 drivers/usb/host/sl811-hcd.c |    9 +++++++--
 drivers/usb/host/uhci-hcd.c  |    4 ++++
 6 files changed, 24 insertions(+), 4 deletions(-)


--Boundary-00=_S4FhETO37E7yGLe
Content-Type: text/x-diff;
  charset="us-ascii";
  name="prethaw-usb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prethaw-usb.patch"

This teaches several USB host controller drivers to treat PRETHAW as a
chip reset since the controller, and all devices connected to it, are no
longer in states compatible with how the snapshotted suspend() left them.

---
 drivers/usb/core/hcd-pci.c   |    2 +-
 drivers/usb/core/usb.c       |    2 +-
 drivers/usb/host/ehci-pci.c  |    6 ++++++
 drivers/usb/host/ohci-pci.c  |    5 +++++
 drivers/usb/host/sl811-hcd.c |    9 +++++++--
 drivers/usb/host/uhci-hcd.c  |    4 ++++
 6 files changed, 24 insertions(+), 4 deletions(-)

Index: g26/drivers/usb/core/hcd-pci.c
===================================================================
--- g26.orig/drivers/usb/core/hcd-pci.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/usb/core/hcd-pci.c	2006-06-02 18:11:28.000000000 -0700
@@ -282,7 +282,7 @@ int usb_hcd_pci_suspend (struct pci_dev 
 			(void) usb_hcd_pci_resume (dev);
 		}
 
-	} else {
+	} else if (hcd->state != HC_STATE_HALT) {
 		dev_dbg (hcd->self.controller, "hcd state %d; not suspended\n",
 			hcd->state);
 		WARN_ON(1);
Index: g26/drivers/usb/core/usb.c
===================================================================
--- g26.orig/drivers/usb/core/usb.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/usb/core/usb.c	2006-06-02 18:11:28.000000000 -0700
@@ -1005,7 +1005,7 @@ static int usb_generic_suspend(struct de
 	 * But those semantics are useless, so we equate the two (sigh).
 	 */
 	if (dev->driver == &usb_generic_driver) {
-		if (dev->power.power_state.event == message.event)
+		if (dev->power.power_state.event != PM_EVENT_ON)
 			return 0;
 		/* we need to rule out bogus requests through sysfs */
 		status = device_for_each_child(dev, NULL, verify_suspended);
Index: g26/drivers/usb/host/sl811-hcd.c
===================================================================
--- g26.orig/drivers/usb/host/sl811-hcd.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/usb/host/sl811-hcd.c	2006-06-02 18:11:28.000000000 -0700
@@ -1780,10 +1780,15 @@ sl811h_suspend(struct platform_device *d
 	struct sl811	*sl811 = hcd_to_sl811(hcd);
 	int		retval = 0;
 
-	if (state.event == PM_EVENT_FREEZE)
+	switch (state.event) {
+	case PM_EVENT_FREEZE:
 		retval = sl811h_bus_suspend(hcd);
-	else if (state.event == PM_EVENT_SUSPEND)
+		break;
+	case PM_EVENT_SUSPEND:
+	case PM_EVENT_PRETHAW:		/* explicitly discard hw state */
 		port_power(sl811, 0);
+		break;
+	}
 	if (retval == 0)
 		dev->dev.power.power_state = state;
 	return retval;
Index: g26/drivers/usb/host/ehci-pci.c
===================================================================
--- g26.orig/drivers/usb/host/ehci-pci.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/usb/host/ehci-pci.c	2006-06-02 18:11:28.000000000 -0700
@@ -229,6 +229,12 @@ static int ehci_pci_suspend(struct usb_h
 	writel (0, &ehci->regs->intr_enable);
 	(void)readl(&ehci->regs->intr_enable);
 
+	/* make sure snapshot being resumed re-enumerates everything */
+	if (message.event == PM_EVENT_PRETHAW) {
+		ehci_halt(ehci);
+		ehci_reset(ehci);
+	}
+
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
  bail:
 	spin_unlock_irqrestore (&ehci->lock, flags);
Index: g26/drivers/usb/host/ohci-pci.c
===================================================================
--- g26.orig/drivers/usb/host/ohci-pci.c	2006-06-02 18:11:22.000000000 -0700
+++ g26/drivers/usb/host/ohci-pci.c	2006-06-02 18:11:28.000000000 -0700
@@ -135,6 +135,11 @@ static int ohci_pci_suspend (struct usb_
 	}
 	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
 	(void)ohci_readl(ohci, &ohci->regs->intrdisable);
+
+	/* make sure snapshot being resumed re-enumerates everything */
+	if (message.event == PM_EVENT_PRETHAW)
+		ohci_usb_reset(ohci);
+
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
  bail:
 	spin_unlock_irqrestore (&ohci->lock, flags);
Index: g26/drivers/usb/host/uhci-hcd.c
===================================================================
--- g26.orig/drivers/usb/host/uhci-hcd.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/usb/host/uhci-hcd.c	2006-06-02 18:11:28.000000000 -0700
@@ -731,6 +731,10 @@ static int uhci_suspend(struct usb_hcd *
 
 	/* FIXME: Enable non-PME# remote wakeup? */
 
+	/* make sure snapshot being resumed re-enumerates everything */
+	if (message.event == PM_EVENT_PRETHAW)
+		hc_died(uhci);
+
 done:
 	spin_unlock_irq(&uhci->lock);
 	return rc;

--Boundary-00=_S4FhETO37E7yGLe
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_S4FhETO37E7yGLe--

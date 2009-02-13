From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/1] USB/PCI: Fix resume breakage of controllers
	behind cardbus bridges
Date: Fri, 13 Feb 2009 23:41:12 +0100
Message-ID: <200902132341.13241.rjw__37859.7448849634$1234565149$gmane$org@sisk.pl>
References: <200902132340.15427.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902132340.15427.rjw@sisk.pl>
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
To: Greg KH <gregkh@suse.de>
Cc: Miles Lane <miles.lane@gmail.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If a USB PCI controller is behind a cardbus bridge, we are trying to
restore its configuration registers too early, before the cardbus
bridge is operational.  To fix this, call pci_restore_state() from
usb_hcd_pci_resume() and remove usb_hcd_pci_resume_early() which is
no longer necessary (the configuration spaces of USB controllers that
are not behind cardbus bridges will be restored by the PCI PM core
with interrupts disabled anyway).

This patch fixes the regression from 2.6.28 tracked as
http://bugzilla.kernel.org/show_bug.cgi?id=12659

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Miles Lane <miles.lane@gmail.com>
---
 drivers/usb/core/hcd-pci.c  |   15 ++-------------
 drivers/usb/core/hcd.h      |    1 -
 drivers/usb/host/ehci-pci.c |    1 -
 drivers/usb/host/ohci-pci.c |    1 -
 drivers/usb/host/uhci-hcd.c |    1 -
 5 files changed, 2 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/hcd-pci.c
+++ linux-2.6/drivers/usb/core/hcd-pci.c
@@ -298,19 +298,6 @@ int usb_hcd_pci_suspend(struct pci_dev *
 EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend);
 
 /**
- * usb_hcd_pci_resume_early - resume a PCI-based HCD before IRQs are enabled
- * @dev: USB Host Controller being resumed
- *
- * Store this function in the HCD's struct pci_driver as .resume_early.
- */
-int usb_hcd_pci_resume_early(struct pci_dev *dev)
-{
-	pci_restore_state(dev);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(usb_hcd_pci_resume_early);
-
-/**
  * usb_hcd_pci_resume - power management resume of a PCI-based HCD
  * @dev: USB Host Controller being resumed
  *
@@ -333,6 +320,8 @@ int usb_hcd_pci_resume(struct pci_dev *d
 	}
 #endif
 
+	pci_restore_state(dev);
+
 	hcd = pci_get_drvdata(dev);
 	if (hcd->state != HC_STATE_SUSPENDED) {
 		dev_dbg(hcd->self.controller,
Index: linux-2.6/drivers/usb/core/hcd.h
===================================================================
--- linux-2.6.orig/drivers/usb/core/hcd.h
+++ linux-2.6/drivers/usb/core/hcd.h
@@ -257,7 +257,6 @@ extern void usb_hcd_pci_remove(struct pc
 
 #ifdef CONFIG_PM
 extern int usb_hcd_pci_suspend(struct pci_dev *dev, pm_message_t msg);
-extern int usb_hcd_pci_resume_early(struct pci_dev *dev);
 extern int usb_hcd_pci_resume(struct pci_dev *dev);
 #endif /* CONFIG_PM */
 
Index: linux-2.6/drivers/usb/host/ehci-pci.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ehci-pci.c
+++ linux-2.6/drivers/usb/host/ehci-pci.c
@@ -432,7 +432,6 @@ static struct pci_driver ehci_pci_driver
 
 #ifdef	CONFIG_PM
 	.suspend =	usb_hcd_pci_suspend,
-	.resume_early =	usb_hcd_pci_resume_early,
 	.resume =	usb_hcd_pci_resume,
 #endif
 	.shutdown = 	usb_hcd_pci_shutdown,
Index: linux-2.6/drivers/usb/host/ohci-pci.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ohci-pci.c
+++ linux-2.6/drivers/usb/host/ohci-pci.c
@@ -487,7 +487,6 @@ static struct pci_driver ohci_pci_driver
 
 #ifdef	CONFIG_PM
 	.suspend =	usb_hcd_pci_suspend,
-	.resume_early =	usb_hcd_pci_resume_early,
 	.resume =	usb_hcd_pci_resume,
 #endif
 
Index: linux-2.6/drivers/usb/host/uhci-hcd.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/uhci-hcd.c
+++ linux-2.6/drivers/usb/host/uhci-hcd.c
@@ -942,7 +942,6 @@ static struct pci_driver uhci_pci_driver
 
 #ifdef	CONFIG_PM
 	.suspend =	usb_hcd_pci_suspend,
-	.resume_early =	usb_hcd_pci_resume_early,
 	.resume =	usb_hcd_pci_resume,
 #endif	/* PM */
 };

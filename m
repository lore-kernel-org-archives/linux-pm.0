From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc6 4/7] USB uses pci_choose_state()
Date: Thu, 20 Mar 2008 14:15:07 -0700
Message-ID: <200803201415.07957.david-b__1600.38307444683$1206049085$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201408.33466.david-b@pacbell.net>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Given a preceding patch that makes pci_choose_state() behave sanely,
use it to select the appropriate PCI_Dx state to use when suspending
a host controller.

USB hosts may now use states like PCI_D1 and PCI_D2, where appropriate.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/core/hcd-pci.c |   25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

--- g26.orig/drivers/usb/core/hcd-pci.c	2008-02-24 02:02:45.000000000 -0800
+++ g26/drivers/usb/core/hcd-pci.c	2008-02-24 02:08:08.000000000 -0800
@@ -224,18 +224,6 @@ int usb_hcd_pci_suspend(struct pci_dev *
 	}
 	synchronize_irq(dev->irq);
 
-	/* FIXME until the generic PM interfaces change a lot more, this
-	 * can't use PCI D1 and D2 states.  For example, the confusion
-	 * between messages and states will need to vanish, and messages
-	 * will need to provide a target system state again.
-	 *
-	 * It'll be important to learn characteristics of the target state,
-	 * especially on embedded hardware where the HCD will often be in
-	 * charge of an external VBUS power supply and one or more clocks.
-	 * Some target system states will leave them active; others won't.
-	 * (With PCI, that's often handled by platform BIOS code.)
-	 */
-
 	/* even when the PCI layer rejects some of the PCI calls
 	 * below, HCs can try global suspend and reduce DMA traffic.
 	 * PM-sensitive HCDs may already have done this.
@@ -248,6 +236,7 @@ int usb_hcd_pci_suspend(struct pci_dev *
 	 * low power state, if the hardware allows.
 	 */
 	if (hcd->state == HC_STATE_SUSPENDED) {
+		pci_power_t		d_state;
 
 		/* no DMA or IRQs except when HC is active */
 		if (dev->current_state == PCI_D0) {
@@ -265,27 +254,29 @@ int usb_hcd_pci_suspend(struct pci_dev *
 			dev_dbg(hcd->self.controller, "--> PCI D0/legacy\n");
 			goto done;
 		}
+		d_state = pci_choose_state(dev, message);
 
-		/* NOTE:  dev->current_state becomes nonzero only here, and
-		 * only for devices that support PCI PM.  Also, exiting
+		/* NOTE:  dev->current_state becomes nonzero only here, using
+		 * D3hot unless the platform chooses D2 or D1.  Also, exiting
 		 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
 		 * some device state (e.g. as part of clock reinit).
 		 */
-		retval = pci_set_power_state(dev, PCI_D3hot);
+		retval = pci_set_power_state(dev, d_state);
 		suspend_report_result(pci_set_power_state, retval);
 		if (retval == 0) {
 			int wake = device_can_wakeup(&hcd->self.root_hub->dev);
 
 			wake = wake && device_may_wakeup(hcd->self.controller);
 
-			dev_dbg(hcd->self.controller, "--> PCI D3%s\n",
+			dev_dbg(hcd->self.controller, "--> PCI D%d%s\n",
+					d_state,
 					wake ? "/wakeup" : "");
 
 			/* Ignore these return values.  We rely on pci code to
 			 * reject requests the hardware can't implement, rather
 			 * than coding the same thing.
 			 */
-			(void) pci_enable_wake(dev, PCI_D3hot, wake);
+			(void) pci_enable_wake(dev, d_state, wake);
 			(void) pci_enable_wake(dev, PCI_D3cold, wake);
 		} else {
 			dev_dbg(&dev->dev, "PCI D3 suspend fail, %d\n",

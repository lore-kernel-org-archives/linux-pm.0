From: Alan Stern <stern@rowland.harvard.edu>
Subject: USB suspend and resume for PCI host controllers
Date: Mon, 8 Dec 2008 17:13:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812081705020.2434-100000__23616.3410045721$1228774563$gmane$org@iolanthe.rowland.org>
References: <200812062236.44111.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812062236.44111.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael:

Here's the current version of my patch.  All of the PCI stuff has been 
moved to the suspend_late and resume_early routines.

Now maybe that's not the right thing to do, or at least not until some 
further fixes have been added.  All I can tell you is that this looks 
right to me, but it doesn't work.  When I tried it, all the I/O and 
MMIO accesses after resume_early returned nothing but 0xffffffff.

Here's a sample extracted from the log:

[  472.248029] ehci_hcd 0000:00:1d.7: resume from previous PCI D3: 0
[  472.248139] ehci_hcd 0000:00:1d.7: restoring config space at offset 0xf (was 0x400, writing 0x0)
[  472.248283] ehci_hcd 0000:00:1d.7: restoring config space at offset 0xd (was 0x50, writing 0x0)
[  472.248430] ehci_hcd 0000:00:1d.7: restoring config space at offset 0xb (was 0x52478086, writing 0x0)
[  472.248591] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x2 (was 0xc032002, writing 0x0)
[  472.248735] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x1 (was 0x2900000, writing 0x0)
[  472.248878] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x0 (was 0x24cd8086, writing 0x0)
[  472.249037] ehci_hcd 0000:00:1d.7: enabling device (0000 -> 0002)
[  472.249136] ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 23 (level, low) -> IRQ 23
[  472.249237] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[  472.264026] ohci_hcd 0000:01:00.0: resume from previous PCI D3: 0
[  472.264130] ohci_hcd 0000:01:00.0: restoring config space at offset 0xf (was 0x2a01010b, writing 0x0)
[  472.264275] ohci_hcd 0000:01:00.0: restoring config space at offset 0xd (was 0x40, writing 0x0)
[  472.264418] ohci_hcd 0000:01:00.0: restoring config space at offset 0xb (was 0x351033, writing 0x0)
[  472.264571] ohci_hcd 0000:01:00.0: restoring config space at offset 0x4 (was 0xff8fd000, writing 0x0)
[  472.264713] ohci_hcd 0000:01:00.0: restoring config space at offset 0x3 (was 0x802008, writing 0x0)
[  472.264855] ohci_hcd 0000:01:00.0: restoring config space at offset 0x2 (was 0xc031043, writing 0x0)
[  472.264997] ohci_hcd 0000:01:00.0: restoring config space at offset 0x1 (was 0x2100000, writing 0x0)
[  472.265139] ohci_hcd 0000:01:00.0: restoring config space at offset 0x0 (was 0x351033, writing 0x0)
[  472.265289] ohci_hcd 0000:01:00.0: enabling device (0000 -> 0002)
[  472.265385] ohci_hcd 0000:01:00.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  472.265484] ohci_hcd 0000:01:00.0: setting latency timer to 64
...
[  472.350778] ehci_hcd 0000:00:1d.7: lost power, restarting
[  472.350869] usb usb6: root hub lost power or was reset
[  472.350964] ehci_hcd 0000:00:1d.7: reset command ffffffff park=3 ithresh=63 LReset IAAD Async Periodic period=?? R
[  472.351120] ehci_hcd 0000:00:1d.7: debug port 1 IN USE
[  472.351216] ehci_hcd 0000:00:1d.7: cache line size of 128 is not supported
[  472.352143] ohci_hcd 0000:01:00.0: BIOS/SMM active, control ffffffff
[  472.352237] ohci_hcd 0000:01:00.0: USB HC TakeOver from BIOS/SMM
[  480.352022] ohci_hcd 0000:01:00.0: USB HC takeover failed!  (BIOS/SMM bug)
[  480.368072] ohci_hcd 0000:01:00.0: USB HC reset timed out!
[  480.368165] ohci_hcd 0000:01:00.0: can't restart, -1
[  480.368253] usb usb9: root hub lost power or was reset
[  480.368343] ohci_hcd 0000:01:00.0: already suspended

Alan Stern



Index: usb-2.6/drivers/usb/core/hcd.h
===================================================================
--- usb-2.6.orig/drivers/usb/core/hcd.h
+++ usb-2.6/drivers/usb/core/hcd.h
@@ -256,7 +256,9 @@ extern int usb_hcd_pci_probe(struct pci_
 extern void usb_hcd_pci_remove(struct pci_dev *dev);
 
 #ifdef CONFIG_PM
-extern int usb_hcd_pci_suspend(struct pci_dev *dev, pm_message_t state);
+extern int usb_hcd_pci_suspend(struct pci_dev *dev, pm_message_t msg);
+extern int usb_hcd_pci_suspend_late(struct pci_dev *dev, pm_message_t msg);
+extern int usb_hcd_pci_resume_early(struct pci_dev *dev);
 extern int usb_hcd_pci_resume(struct pci_dev *dev);
 #endif /* CONFIG_PM */
 
Index: usb-2.6/drivers/usb/core/hcd-pci.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/hcd-pci.c
+++ usb-2.6/drivers/usb/core/hcd-pci.c
@@ -191,17 +191,15 @@ EXPORT_SYMBOL_GPL(usb_hcd_pci_remove);
 /**
  * usb_hcd_pci_suspend - power management suspend of a PCI-based HCD
  * @dev: USB Host Controller being suspended
- * @message: semantics in flux
+ * @message: Power Management message describing this state transition
  *
- * Store this function in the HCD's struct pci_driver as suspend().
+ * Store this function in the HCD's struct pci_driver as .suspend.
  */
 int usb_hcd_pci_suspend(struct pci_dev *dev, pm_message_t message)
 {
-	struct usb_hcd		*hcd;
+	struct usb_hcd		*hcd = pci_get_drvdata(dev);
 	int			retval = 0;
-	int			has_pci_pm;
 
-	hcd = pci_get_drvdata(dev);
 
 	/* Root hub suspend should have stopped all downstream traffic,
 	 * and all bus master traffic.  And done so for both the interface
@@ -212,96 +210,86 @@ int usb_hcd_pci_suspend(struct pci_dev *
 	 * otherwise the swsusp will save (and restore) garbage state.
 	 */
 	if (!(hcd->state == HC_STATE_SUSPENDED ||
-			hcd->state == HC_STATE_HALT))
-		return -EBUSY;
+			hcd->state == HC_STATE_HALT)) {
+		dev_warn(&dev->dev, "Root hub is not suspended\n");
+		retval = -EBUSY;
 
-	if (hcd->driver->pci_suspend) {
+	} else if (hcd->driver->pci_suspend) {
 		retval = hcd->driver->pci_suspend(hcd, message);
 		suspend_report_result(hcd->driver->pci_suspend, retval);
-		if (retval)
-			goto done;
 	}
-	synchronize_irq(dev->irq);
 
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
+	if (retval == 0)
+		synchronize_irq(dev->irq);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend);
+
+/**
+ * usb_hcd_pci_suspend_late - suspend a PCI-based HCD after IRQs are disabled
+ * @dev: USB Host Controller being suspended
+ * @message: Power Management message describing this state transition
+ *
+ * Store this function in the HCD's struct pci_driver as .suspend_late.
+ */
+int usb_hcd_pci_suspend_late(struct pci_dev *dev, pm_message_t message)
+{
+	int			retval = 0;
+	int			has_pci_pm;
+	struct usb_hcd		*hcd = pci_get_drvdata(dev);
+	int			wake;
+
+	/* We might already be suspended (runtime PM -- not yet written) */
+	if (dev->current_state != PCI_D0)
+		goto done;
+
+	/* Don't change state if we don't need to */
+	if (message.event == PM_EVENT_FREEZE ||
+			message.event == PM_EVENT_PRETHAW) {
+		dev_dbg(&dev->dev, "--> no state change\n");
+		goto done;
+	}
 
-	/* even when the PCI layer rejects some of the PCI calls
-	 * below, HCs can try global suspend and reduce DMA traffic.
-	 * PM-sensitive HCDs may already have done this.
-	 */
 	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!has_pci_pm) {
+		dev_dbg(&dev->dev, "--> PCI D0/legacy\n");
+		goto done;
+	}
+
+	/* Ignore these return values.  We rely on pci code to
+	 * reject requests the hardware can't implement, rather
+	 * than coding the same thing.
+	 */
+	wake = (hcd->state == HC_STATE_SUSPENDED &&
+			device_may_wakeup(&dev->dev));
+	(void) pci_enable_wake(dev, PCI_D3hot, wake);
+	(void) pci_enable_wake(dev, PCI_D3cold, wake);
 
 	/* Downstream ports from this root hub should already be quiesced, so
 	 * there will be no DMA activity.  Now we can shut down the upstream
 	 * link (except maybe for PME# resume signaling) and enter some PCI
 	 * low power state, if the hardware allows.
 	 */
-	if (hcd->state == HC_STATE_SUSPENDED) {
-
-		/* no DMA or IRQs except when HC is active */
-		if (dev->current_state == PCI_D0) {
-			pci_save_state(dev);
-			pci_disable_device(dev);
-		}
-
-		if (message.event == PM_EVENT_FREEZE ||
-				message.event == PM_EVENT_PRETHAW) {
-			dev_dbg(hcd->self.controller, "--> no state change\n");
-			goto done;
-		}
-
-		if (!has_pci_pm) {
-			dev_dbg(hcd->self.controller, "--> PCI D0/legacy\n");
-			goto done;
-		}
+	pci_disable_device(dev);
 
-		/* NOTE:  dev->current_state becomes nonzero only here, and
-		 * only for devices that support PCI PM.  Also, exiting
-		 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
-		 * some device state (e.g. as part of clock reinit).
-		 */
-		retval = pci_set_power_state(dev, PCI_D3hot);
-		suspend_report_result(pci_set_power_state, retval);
-		if (retval == 0) {
-			int wake = device_can_wakeup(&hcd->self.root_hub->dev);
-
-			wake = wake && device_may_wakeup(hcd->self.controller);
-
-			dev_dbg(hcd->self.controller, "--> PCI D3%s\n",
-					wake ? "/wakeup" : "");
-
-			/* Ignore these return values.  We rely on pci code to
-			 * reject requests the hardware can't implement, rather
-			 * than coding the same thing.
-			 */
-			(void) pci_enable_wake(dev, PCI_D3hot, wake);
-			(void) pci_enable_wake(dev, PCI_D3cold, wake);
-		} else {
-			dev_dbg(&dev->dev, "PCI D3 suspend fail, %d\n",
-					retval);
-			(void) usb_hcd_pci_resume(dev);
-		}
-
-	} else if (hcd->state != HC_STATE_HALT) {
-		dev_dbg(hcd->self.controller, "hcd state %d; not suspended\n",
-			hcd->state);
-		WARN_ON(1);
-		retval = -EINVAL;
+	/* NOTE:  dev->current_state becomes nonzero only here, and
+	 * only for devices that support PCI PM.  Also, exiting
+	 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
+	 * some device state (e.g. as part of clock reinit).
+	 */
+	retval = pci_set_power_state(dev, PCI_D3hot);
+	suspend_report_result(pci_set_power_state, retval);
+	if (retval == 0) {
+		dev_dbg(hcd->self.controller, "--> PCI D3%s\n",
+				wake ? "/wakeup" : "");
+	} else {
+		dev_dbg(&dev->dev, "PCI D3 suspend fail, %d\n", retval);
+		(void) usb_hcd_pci_resume(dev);
 	}
 
-done:
-	if (retval == 0) {
+ done:
 #ifdef CONFIG_PPC_PMAC
+	if (retval == 0) {
 		/* Disable ASIC clocks for USB */
 		if (machine_is(powermac)) {
 			struct device_node	*of_node;
@@ -311,30 +299,23 @@ done:
 				pmac_call_feature(PMAC_FTR_USB_ENABLE,
 							of_node, 0, 0);
 		}
-#endif
 	}
+#endif
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend);
+EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend_late);
 
 /**
- * usb_hcd_pci_resume - power management resume of a PCI-based HCD
+ * usb_hcd_pci_resume_early - resume a PCI-based HCD before IRQs are enabled
  * @dev: USB Host Controller being resumed
  *
- * Store this function in the HCD's struct pci_driver as resume().
+ * Store this function in the HCD's struct pci_driver as .resume_early.
  */
-int usb_hcd_pci_resume(struct pci_dev *dev)
+int usb_hcd_pci_resume_early(struct pci_dev *dev)
 {
-	struct usb_hcd		*hcd;
-	int			retval;
-
-	hcd = pci_get_drvdata(dev);
-	if (hcd->state != HC_STATE_SUSPENDED) {
-		dev_dbg(hcd->self.controller,
-				"can't resume, not suspended!\n");
-		return 0;
-	}
+	int		retval = 0;
+	pci_power_t	state = dev->current_state;
 
 #ifdef CONFIG_PPC_PMAC
 	/* Reenable ASIC clocks for USB */
@@ -352,7 +333,7 @@ int usb_hcd_pci_resume(struct pci_dev *d
 	 * calls "standby", "suspend to RAM", and so on).  There are also
 	 * dirty cases when swsusp fakes a suspend in "shutdown" mode.
 	 */
-	if (dev->current_state != PCI_D0) {
+	if (state != PCI_D0) {
 #ifdef	DEBUG
 		int	pci_pm;
 		u16	pmcr;
@@ -364,8 +345,7 @@ int usb_hcd_pci_resume(struct pci_dev *d
 			/* Clean case:  power to USB and to HC registers was
 			 * maintained; remote wakeup is easy.
 			 */
-			dev_dbg(hcd->self.controller, "resume from PCI D%d\n",
-					pmcr);
+			dev_dbg(&dev->dev, "resume from PCI D%d\n", pmcr);
 		} else {
 			/* Clean:  HC lost Vcc power, D0 uninitialized
 			 *   + Vaux may have preserved port and transceiver
@@ -376,33 +356,56 @@ int usb_hcd_pci_resume(struct pci_dev *d
 			 *   + after BIOS init
 			 *   + after Linux init (HCD statically linked)
 			 */
-			dev_dbg(hcd->self.controller,
-				"PCI D0, from previous PCI D%d\n",
-				dev->current_state);
+			dev_dbg(&dev->dev, "resume from previous PCI D%d\n",
+					state);
 		}
 #endif
-		/* yes, ignore these results too... */
-		(void) pci_enable_wake(dev, dev->current_state, 0);
-		(void) pci_enable_wake(dev, PCI_D3cold, 0);
+
+		retval = pci_set_power_state(dev, PCI_D0);
 	} else {
 		/* Same basic cases: clean (powered/not), dirty */
-		dev_dbg(hcd->self.controller, "PCI legacy resume\n");
+		dev_dbg(&dev->dev, "PCI legacy resume\n");
 	}
 
-	/* NOTE:  the PCI API itself is asymmetric here.  We don't need to
-	 * pci_set_power_state(PCI_D0) since that's part of re-enabling;
-	 * but that won't re-enable bus mastering.  Yet pci_disable_device()
-	 * explicitly disables bus mastering...
-	 */
-	retval = pci_enable_device(dev);
 	if (retval < 0) {
-		dev_err(hcd->self.controller,
-			"can't re-enable after resume, %d!\n", retval);
+		dev_err(&dev->dev, "can't resume: %d\n", retval);
 		return retval;
 	}
-	pci_set_master(dev);
+
 	pci_restore_state(dev);
 
+	/* yes, ignore these results too... */
+	(void) pci_enable_wake(dev, PCI_D3hot, 0);
+	(void) pci_enable_wake(dev, PCI_D3cold, 0);
+
+	retval = pci_enable_device(dev);
+	if (retval >= 0)
+		pci_set_master(dev);
+	else
+		dev_err(&dev->dev, "can't re-enable after resume, %d!\n",
+				retval);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(usb_hcd_pci_resume_early);
+
+/**
+ * usb_hcd_pci_resume - power management resume of a PCI-based HCD
+ * @dev: USB Host Controller being resumed
+ *
+ * Store this function in the HCD's struct pci_driver as .resume.
+ */
+int usb_hcd_pci_resume(struct pci_dev *dev)
+{
+	struct usb_hcd		*hcd;
+	int			retval = 0;
+
+	hcd = pci_get_drvdata(dev);
+	if (hcd->state != HC_STATE_SUSPENDED) {
+		dev_dbg(hcd->self.controller,
+				"can't resume, not suspended!\n");
+		return 0;
+	}
+
 	clear_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 
 	if (hcd->driver->pci_resume) {
@@ -413,7 +416,6 @@ int usb_hcd_pci_resume(struct pci_dev *d
 			usb_hc_died(hcd);
 		}
 	}
-
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_hcd_pci_resume);
Index: usb-2.6/drivers/usb/host/ehci-pci.c
===================================================================
--- usb-2.6.orig/drivers/usb/host/ehci-pci.c
+++ usb-2.6/drivers/usb/host/ehci-pci.c
@@ -428,6 +428,8 @@ static struct pci_driver ehci_pci_driver
 
 #ifdef	CONFIG_PM
 	.suspend =	usb_hcd_pci_suspend,
+	.suspend_late =	usb_hcd_pci_suspend_late,
+	.resume_early =	usb_hcd_pci_resume_early,
 	.resume =	usb_hcd_pci_resume,
 #endif
 	.shutdown = 	usb_hcd_pci_shutdown,
Index: usb-2.6/drivers/usb/host/ohci-pci.c
===================================================================
--- usb-2.6.orig/drivers/usb/host/ohci-pci.c
+++ usb-2.6/drivers/usb/host/ohci-pci.c
@@ -487,6 +487,8 @@ static struct pci_driver ohci_pci_driver
 
 #ifdef	CONFIG_PM
 	.suspend =	usb_hcd_pci_suspend,
+	.suspend_late =	usb_hcd_pci_suspend_late,
+	.resume_early =	usb_hcd_pci_resume_early,
 	.resume =	usb_hcd_pci_resume,
 #endif
 
Index: usb-2.6/drivers/usb/host/uhci-hcd.c
===================================================================
--- usb-2.6.orig/drivers/usb/host/uhci-hcd.c
+++ usb-2.6/drivers/usb/host/uhci-hcd.c
@@ -942,6 +942,8 @@ static struct pci_driver uhci_pci_driver
 
 #ifdef	CONFIG_PM
 	.suspend =	usb_hcd_pci_suspend,
+	.suspend_late =	usb_hcd_pci_suspend_late,
+	.resume_early =	usb_hcd_pci_resume_early,
 	.resume =	usb_hcd_pci_resume,
 #endif	/* PM */
 };

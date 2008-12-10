From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB suspend and resume for PCI host controllers
Date: Wed, 10 Dec 2008 17:11:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812101709260.2082-100000__12166.8336251334$1228947355$gmane$org@iolanthe.rowland.org>
References: <200812102203.35218.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812102203.35218.rjw@sisk.pl>
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

On Wed, 10 Dec 2008, Rafael J. Wysocki wrote:

> > > Well, it looks like you forgot to actually call pci_save_power_state(). :-)
> > 
> > I didn't forget it -- in my tree there is no such function!  :-)
> 
> That should have been pci_save_state(). [Note to self: don't send email when
> you're too tired.]

Yes, adding pci_save_state() fixed the problem.  Here is the new patch;  
it seems to work.  Anything else need to be changed?

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
-
-	hcd = pci_get_drvdata(dev);
+	int			wake, w;
 
 	/* Root hub suspend should have stopped all downstream traffic,
 	 * and all bus master traffic.  And done so for both the interface
@@ -212,8 +210,15 @@ int usb_hcd_pci_suspend(struct pci_dev *
 	 * otherwise the swsusp will save (and restore) garbage state.
 	 */
 	if (!(hcd->state == HC_STATE_SUSPENDED ||
-			hcd->state == HC_STATE_HALT))
-		return -EBUSY;
+			hcd->state == HC_STATE_HALT)) {
+		dev_warn(&dev->dev, "Root hub is not suspended\n");
+		retval = -EBUSY;
+		goto done;
+	}
+
+	/* We might already be suspended (runtime PM -- not yet written) */
+	if (dev->current_state != PCI_D0)
+		goto done;
 
 	if (hcd->driver->pci_suspend) {
 		retval = hcd->driver->pci_suspend(hcd, message);
@@ -221,49 +226,60 @@ int usb_hcd_pci_suspend(struct pci_dev *
 		if (retval)
 			goto done;
 	}
+
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
+	/* Don't fail on error to enable wakeup.  We rely on pci code
+	 * to reject requests the hardware can't implement, rather
+	 * than coding the same thing.
 	 */
-
-	/* even when the PCI layer rejects some of the PCI calls
-	 * below, HCs can try global suspend and reduce DMA traffic.
-	 * PM-sensitive HCDs may already have done this.
-	 */
-	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	wake = (hcd->state == HC_STATE_SUSPENDED &&
+			device_may_wakeup(&dev->dev));
+	w = pci_wake_from_d3(dev, wake);
+	if (w < 0)
+		wake = w;
+	dev_dbg(&dev->dev, "wakeup: %d\n", wake);
 
 	/* Downstream ports from this root hub should already be quiesced, so
 	 * there will be no DMA activity.  Now we can shut down the upstream
 	 * link (except maybe for PME# resume signaling) and enter some PCI
 	 * low power state, if the hardware allows.
 	 */
-	if (hcd->state == HC_STATE_SUSPENDED) {
+	pci_disable_device(dev);
+ done:
+	return retval;
+}
+EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend);
 
-		/* no DMA or IRQs except when HC is active */
-		if (dev->current_state == PCI_D0) {
-			pci_save_state(dev);
-			pci_disable_device(dev);
-		}
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
 
-		if (message.event == PM_EVENT_FREEZE ||
-				message.event == PM_EVENT_PRETHAW) {
-			dev_dbg(hcd->self.controller, "--> no state change\n");
-			goto done;
-		}
+	/* We might already be suspended (runtime PM -- not yet written) */
+	if (dev->current_state != PCI_D0)
+		goto done;
+
+	pci_save_state(dev);
+
+	/* Don't change state if we don't need to */
+	if (message.event == PM_EVENT_FREEZE ||
+			message.event == PM_EVENT_PRETHAW) {
+		dev_dbg(&dev->dev, "--> no state change\n");
+		goto done;
+	}
 
-		if (!has_pci_pm) {
-			dev_dbg(hcd->self.controller, "--> PCI D0/legacy\n");
-			goto done;
-		}
+	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!has_pci_pm) {
+		dev_dbg(&dev->dev, "--> PCI D0 legacy\n");
+	} else {
 
 		/* NOTE:  dev->current_state becomes nonzero only here, and
 		 * only for devices that support PCI PM.  Also, exiting
@@ -273,35 +289,16 @@ int usb_hcd_pci_suspend(struct pci_dev *
 		retval = pci_set_power_state(dev, PCI_D3hot);
 		suspend_report_result(pci_set_power_state, retval);
 		if (retval == 0) {
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
+			dev_dbg(&dev->dev, "--> PCI D3\n");
 		} else {
 			dev_dbg(&dev->dev, "PCI D3 suspend fail, %d\n",
 					retval);
-			(void) usb_hcd_pci_resume(dev);
+			pci_restore_state(dev);
 		}
-
-	} else if (hcd->state != HC_STATE_HALT) {
-		dev_dbg(hcd->self.controller, "hcd state %d; not suspended\n",
-			hcd->state);
-		WARN_ON(1);
-		retval = -EINVAL;
 	}
 
-done:
-	if (retval == 0) {
 #ifdef CONFIG_PPC_PMAC
+	if (retval == 0) {
 		/* Disable ASIC clocks for USB */
 		if (machine_is(powermac)) {
 			struct device_node	*of_node;
@@ -311,30 +308,24 @@ done:
 				pmac_call_feature(PMAC_FTR_USB_ENABLE,
 							of_node, 0, 0);
 		}
-#endif
 	}
+#endif
 
+ done:
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
@@ -352,7 +343,7 @@ int usb_hcd_pci_resume(struct pci_dev *d
 	 * calls "standby", "suspend to RAM", and so on).  There are also
 	 * dirty cases when swsusp fakes a suspend in "shutdown" mode.
 	 */
-	if (dev->current_state != PCI_D0) {
+	if (state != PCI_D0) {
 #ifdef	DEBUG
 		int	pci_pm;
 		u16	pmcr;
@@ -364,8 +355,7 @@ int usb_hcd_pci_resume(struct pci_dev *d
 			/* Clean case:  power to USB and to HC registers was
 			 * maintained; remote wakeup is easy.
 			 */
-			dev_dbg(hcd->self.controller, "resume from PCI D%d\n",
-					pmcr);
+			dev_dbg(&dev->dev, "resume from PCI D%d\n", pmcr);
 		} else {
 			/* Clean:  HC lost Vcc power, D0 uninitialized
 			 *   + Vaux may have preserved port and transceiver
@@ -376,32 +366,55 @@ int usb_hcd_pci_resume(struct pci_dev *d
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
+	}
+
+	if (retval < 0)
+		dev_err(&dev->dev, "can't resume: %d\n", retval);
+	else
+		pci_restore_state(dev);
+
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
+	int			retval;
+
+	hcd = pci_get_drvdata(dev);
+	if (hcd->state != HC_STATE_SUSPENDED) {
+		dev_dbg(hcd->self.controller,
+				"can't resume, not suspended!\n");
+		return 0;
 	}
 
-	/* NOTE:  the PCI API itself is asymmetric here.  We don't need to
-	 * pci_set_power_state(PCI_D0) since that's part of re-enabling;
-	 * but that won't re-enable bus mastering.  Yet pci_disable_device()
-	 * explicitly disables bus mastering...
-	 */
 	retval = pci_enable_device(dev);
 	if (retval < 0) {
-		dev_err(hcd->self.controller,
-			"can't re-enable after resume, %d!\n", retval);
+		dev_err(&dev->dev, "can't re-enable after resume, %d!\n",
+				retval);
 		return retval;
 	}
+
 	pci_set_master(dev);
-	pci_restore_state(dev);
+
+	/* yes, ignore this result too... */
+	(void) pci_wake_from_d3(dev, 0);
 
 	clear_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 
@@ -413,7 +426,6 @@ int usb_hcd_pci_resume(struct pci_dev *d
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

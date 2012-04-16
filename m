From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Mon, 16 Apr 2012 16:07:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204161558220.1408-100000@iolanthe.rowland.org>
References: <20120413224336.GA5585@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120413224336.GA5585@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 14 Apr 2012, Andrey Rahmatullin wrote:

> On Fri, Apr 13, 2012 at 10:10:30AM -0400, Alan Stern wrote:
> > Second, if you do
> > 
> > 	echo 0 >/sys/bus/usb/devices/usb1/bConfigurationValue
> > 	echo 0 >/sys/bus/usb/devices/usb2/bConfigurationValue
> > 
> > before suspending (using a vanilla kernel and no script), does it 
> > change the behavior?  I expect it won't, but we should check just to be 
> > thorough.
> No, it still locks up.

Okay.

This is my next attempt to make the driver-bound and driver-unbound
suspend paths as similar as possible.  Apply this to a vanilla kernel;  
it is based on 3.4-rc2 plus a few unrelated changes.  See what happens
when you suspend without unbinding ehci-hcd -- and be sure to include
"no_console_suspend" on the boot command line beforehand.

These changes will prevent the driver from working after resume 
(assuming the computer survives that long).  That's all right; all I 
care about is whether the computer _does_ resume.

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
@@ -1348,6 +1348,7 @@ void pci_disable_enabled_device(struct p
 	if (pci_is_enabled(dev))
 		do_pci_disable_device(dev);
 }
+EXPORT_SYMBOL(pci_disable_enabled_device);
 
 /**
  * pci_disable_device - Disable PCI device after use
@@ -1710,6 +1711,7 @@ pci_power_t pci_target_state(struct pci_
  */
 int pci_prepare_to_sleep(struct pci_dev *dev)
 {
+	pci_power_t cur_state = dev->current_state;
 	pci_power_t target_state = pci_target_state(dev);
 	int error;
 
@@ -1723,6 +1725,8 @@ int pci_prepare_to_sleep(struct pci_dev
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
@@ -381,6 +381,8 @@ static int check_root_hub_suspended(stru
 }
 
 #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
+extern void pci_disable_enabled_device(struct pci_dev *);
+
 static int suspend_common(struct device *dev, bool do_wakeup)
 {
 	struct pci_dev		*pci_dev = to_pci_dev(dev);
@@ -427,12 +429,17 @@ static int suspend_common(struct device
 	if (!hcd->msix_enabled)
 		synchronize_irq(pci_dev->irq);
 
+	free_irq(hcd->irq, hcd);
+	iounmap(hcd->regs);
+	pci_disable_device(pci_dev);
+
 	/* Downstream ports from this root hub should already be quiesced, so
 	 * there will be no DMA activity.  Now we can shut down the upstream
 	 * link (except maybe for PME# resume signaling).  We'll enter a
 	 * low power state during suspend_noirq, if the hardware allows.
 	 */
-	pci_disable_device(pci_dev);
+	pci_disable_enabled_device(pci_dev);
+	pci_dev->current_state = PCI_UNKNOWN;
 	return retval;
 }
 
Index: usb-3.4/drivers/usb/host/ehci-pci.c
===================================================================
--- usb-3.4.orig/drivers/usb/host/ehci-pci.c
+++ usb-3.4/drivers/usb/host/ehci-pci.c
@@ -342,7 +342,6 @@ static int ehci_pci_suspend(struct usb_h
 	 * mark HW unaccessible.  The PM and USB cores make sure that
 	 * the root hub is either suspended or stopped.
 	 */
-	ehci_prepare_ports_for_controller_suspend(ehci, do_wakeup);
 	spin_lock_irqsave (&ehci->lock, flags);
 	ehci_writel(ehci, 0, &ehci->regs->intr_enable);
 	(void)ehci_readl(ehci, &ehci->regs->intr_enable);
@@ -350,6 +349,9 @@ static int ehci_pci_suspend(struct usb_h
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	spin_unlock_irqrestore (&ehci->lock, flags);
 
+	ehci_silence_controller(ehci);
+	ehci_reset(ehci);
+
 	// could save FLADJ in case of Vaux power loss
 	// ... we'd only use it to handle clock skew
 

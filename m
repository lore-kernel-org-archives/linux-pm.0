From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 16:23:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204181616430.1149-100000@iolanthe.rowland.org>
References: <1334769632.28106.46.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334769632.28106.46.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Apr 2012, Steven Rostedt wrote:

> On Wed, 2012-04-18 at 23:10 +0600, Andrey Rahmatullin wrote:
> > On Wed, Apr 18, 2012 at 12:41:10PM -0400, Alan Stern wrote:
> > > Here's the situation.  When the script unbinds ehci-hcd, 
> > > pci_device_remove() sets the current state to PCI_UNKNOWN.  The patch 
> > > to hcd-pci.c does the same thing before the suspend_noirq phase begins, 
> > > i.e., before pci_prepare_to_sleep() is called.
> > > 
> > > In pci_raw_set_power_state(), there's a "switch" statement that depends
> > > on dev->current_state.  If the current state is PCI_D0 then the new
> > > state in pmcsr is set to PCI_D3; if the current state is PCI_UNKNOWN
> > > then the state in pmcsr is left unchanged.  After that, the value in
> > > pmcsr is written to the controller.
> > > 
> > > This means that when ehci-hcd is unbound or the patch is installed, the
> > > controller stays in D0.  That's why we see those "Refused to change
> > > power state" messages, since D0 is not what the target state was
> > > supposed to be.  When ehci-hcd remains bound and the patch isn't
> > > installed, the controller is put into D3.
> > > 
> > > And then finally, the computer crashes during the final stage of 
> > > suspend if either controller is in D3.  Clearly this is a bug in the 
> > > firmware, not in the kernel.

> Is there a way to detect this chipset or something, to add a workaround
> for it?

Yes, there are ways to work around this.  At the moment I'm not sure 
what would be best; we can ask Rafael.  One big remaining puzzle: Why 
are the EHCI controllers the only devices that cause a crash when left 
in D3 during suspend?  We may never know...

In the meantime, just to be certain of the diagnosis, here's a
different patch for you guys to try.  This will test the ehci-hcd
unbound path (i.e., use it with the script).  The patch removes the
line that sets the dev->current_state to PCI_UNKNOWN when the driver is
unbound.  Thus current_state will remain equal to PCI_D0, so
pci_prepare_to_sleep should put the controllers into D3, which we
expect will cause a crash.

Please try this both with and without pm_test set to "platform", and 
post the debugging dmesg output from whichever cases the computer 
survives.

Alan Stern



Index: usb-3.4/drivers/pci/pci-driver.c
===================================================================
--- usb-3.4.orig/drivers/pci/pci-driver.c
+++ usb-3.4/drivers/pci/pci-driver.c
@@ -394,8 +394,8 @@ static int pci_device_remove(struct devi
 	 * If the device is still on, set the power state as "unknown",
 	 * since it might change by the next time we load the driver.
 	 */
-	if (pci_dev->current_state == PCI_D0)
-		pci_dev->current_state = PCI_UNKNOWN;
+//	if (pci_dev->current_state == PCI_D0)
+//		pci_dev->current_state = PCI_UNKNOWN;
 
 	/*
 	 * We would love to complain here if pci_dev->is_enabled is set, that
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
 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

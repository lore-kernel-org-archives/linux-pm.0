From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Tue, 15 Mar 2005 16:48:19 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503151636290.711-100000@ida.rowland.org>
References: <20050314022308.GD6008@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============011891944103603169=="
In-Reply-To: <20050314022308.GD6008-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============011891944103603169==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 14 Mar 2005, Bernard Blackham wrote:

> Not happy yet. Passing D0 to uhci suspend's method is the cause of
> the issue (it doesn't handle it particularly well), and D0 is also
> passed when PMSG_FREEZE is sent. So while it works for entering S3,
> it fails in the same way when preparing for the atomic copy in S4.
> 
> Hacking around the issue by always using D3hot should return it back
> to the pre-drivermodel behaviour and mostly works. However at least
> one person has reported that even doing this, uhci_hcd alone
> suspends fine, but if both uhci_hcd and ehci_hcd are loaded, USB is
> dead on resume until reloading both modules. I'm still digging
> deeper and may need to enlist the help of linux-usb-devel...

It turns out there are a few problems in the hcd-pci.c suspend and resume
routines; mostly that the resume routine doesn't do the reverse of what
the suspend routine does.  One particularly bad symptom is that when
"resuming" from D0 it does pci_restore_state() even though
pci_save_state() was never called.  That's why my controller ended up
unconfigured.

One other point: Suspend calls free_irq() and resume calls request_irq().  
This doesn't seem necessary to me since the common IRQ handler will reject
interrupts occuring while the controller is suspended.  Also it's asking
for trouble if the driver is unloaded before the controller is resumed,
since the remove routine will call free_irq() again on its own.  I've
#ifdef'ed out those calls below, but this deserves closer attention.

Another thing deserving closer attention is the various error pathways and
what state they end up leaving the hardware and the data structures in.  
The patch below doesn't address this.

Anyway, here are the changes I made.  Now things are working better again.  
Bernard, does this help you?

Alan Stern



===== drivers/usb/core/hcd-pci.c 1.76 vs edited =====
--- 1.76/drivers/usb/core/hcd-pci.c	2005-03-11 02:15:12 -05:00
+++ edited/drivers/usb/core/hcd-pci.c	2005-03-15 16:26:14 -05:00
@@ -256,7 +256,9 @@
 		if (!dev->current_state) {
 			pci_save_state (dev);
 			pci_disable_device (dev);
+#if 0
 			free_irq (hcd->irq, hcd);
+#endif
 		}
 
 		if (!has_pci_pm) {
@@ -294,7 +296,6 @@
 		break;
 	}
 
-	/* update power_state **ONLY** to make sysfs happier */
 	if (retval == 0)
 		dev->dev.power.power_state = state;
 	return retval;
@@ -328,22 +329,38 @@
 
 	hcd->state = USB_STATE_RESUMING;
 
-	if (has_pci_pm)
-		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = PMSG_ON;
-	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
-				hcd->driver->description, hcd);
-	if (retval < 0) {
-		dev_err (hcd->self.controller,
-			"can't restore IRQ after resume!\n");
-		return retval;
-	}
-	hcd->saw_irq = 0;
-	pci_restore_state (dev);
+	if (dev->current_state > PCI_D0) {
+		if (has_pci_pm) {
 #ifdef	CONFIG_USB_SUSPEND
-	pci_enable_wake (dev, dev->current_state, 0);
-	pci_enable_wake (dev, 4, 0);
+			pci_enable_wake (dev, dev->current_state, 0);
+			pci_enable_wake (dev, 4, 0);
+#endif
+			retval = pci_set_power_state (dev, PCI_D0);
+			if (retval < 0) {
+				dev_dbg (&dev->dev, "PCI resume fail, %d\n",
+						retval);
+				return retval;
+			}
+		}
+		dev->dev.power.power_state = PMSG_ON;
+#if 0
+		retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
+				hcd->irq_descr, hcd);
+		if (retval < 0) {
+			dev_err (hcd->self.controller,
+				"can't restore IRQ after resume!\n");
+			return retval;
+		}
 #endif
+		hcd->saw_irq = 0;
+		retval = pci_enable_device (dev);
+		if (retval < 0) {
+			dev_err (hcd->self.controller,
+				"can't enable device after resume!\n");
+			return retval;
+		}
+		pci_restore_state (dev);
+	}
 
 	retval = hcd->driver->resume (hcd);
 	if (!HCD_IS_RUNNING (hcd->state)) {
@@ -357,5 +374,3 @@
 EXPORT_SYMBOL (usb_hcd_pci_resume);
 
 #endif	/* CONFIG_PM */
-
-


--===============011891944103603169==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============011891944103603169==--

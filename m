From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Wed, 16 Mar 2005 10:45:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503161024360.1040-100000@ida.rowland.org>
References: <20050316030448.GA8588@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============086258113905862466=="
In-Reply-To: <20050316030448.GA8588-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
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

--===============086258113905862466==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 16 Mar 2005, Bernard Blackham wrote:

> > Bernard, does this help you?
> 
> Somewhat. I had to tweak the patches for the new driver model
> (specifically, change "power_state = state" to "power_state.event =
> msg.event"), and I'm still using the patch to remove the
> PCI_CAP_ID_PM check from pci_choose_state.

The power_state.event change shouldn't affect the code's functioning.  
Neither should the PCI_CAP_ID_PM check provided it still ends up deciding 
to "suspend" to D0.

> Suspend and resume into both S3, and suspend-to-disk (where
> PMSG_FREEZE and PMSG_ON are used), are fine if there are no devices
> plugged in. If there are devices plugged in, it's not so good.
> (Using a boring USB mouse for testing here). They'll suspend and
> resume the first time, suspend a second time, then fail on resume -
> I get a stream of messages:
> 
> Mar 16 10:07:30 amidala kernel: uhci_hcd 0000:00:1d.1: suspend_hc
> Mar 16 10:07:30 amidala kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
> Mar 16 10:07:31 amidala kernel: uhci_hcd 0000:00:1d.1: host controller process error, something bad happened!
> Mar 16 10:07:31 amidala kernel: uhci_hcd 0000:00:1d.1: host controller halted, very bad!
> Mar 16 10:07:31 amidala kernel: usb 3-1: gpilotd timed out on ep0in
> Mar 16 10:07:33 amidala kernel: uhci_hcd 0000:00:1d.1: suspend_hc
> Mar 16 10:07:33 amidala kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
> Mar 16 10:07:33 amidala kernel: uhci_hcd 0000:00:1d.1: host controller process error, something bad happened!
> Mar 16 10:07:33 amidala kernel: uhci_hcd 0000:00:1d.1: host controller halted, very bad!
> Mar 16 10:07:35 amidala kernel: uhci_hcd 0000:00:1d.1: suspend_hc
> Mar 16 10:07:35 amidala kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
> Mar 16 10:07:36 amidala kernel: uhci_hcd 0000:00:1d.1: host controller process error, something bad happened!

The repeating over-and-over results from the uhci-hcd driver's lack of
proper error handling; it's perfectly happy restarting a controller that
has died.  There's not much to do about it at the moment except prevent
the condition that triggered it initially.  Those "process error"s are
bad; they should never happen.

> I haven't tried David's patch yet - the only differences are it
> seems to use a slightly different order, and also calls
> pci_set_master. I'll give that a spin later today combined with and
> without yours to see what works reliably.

The missing pci_set_master in my patch probably explains the errors you 
got.

David's patch doesn't make all the necessary changes that my patch does.  
In particular it doesn't avoid doing pci_restore_state when there was no
prior pci_save_state, so it will continue to exhibit some of the problems
we were seeing before.


On Tue, 15 Mar 2005, Pavel Machek wrote:

> Be carefull with free_irq() / request_irq(). For some reason I needed
> to add them to b44 driver. I'm not sure what is going on, perhaps we 
> are not saving interrupt controller state right?

On Tue, 15 Mar 2005, David Brownell wrote:

> Those request/free calls moved up out of PPC-specific code; Ben can
> comment on why at least some of the Apple hardware needed it.  The 
> free_irq() should be safe, since it should be a NOP if there's no  
> handler associated with that cookie.

It's safe to remove the "#if 0 ... #endif" pairs that my patch leaves
around free_irq and request_irq.  Note however that the original code was 
passing an incorrect label to request_irq!  My fault; I didn't realize 
this code path existed when I changed the label earlier.

Below is a new version of my patch with the IRQ handling reinstated and
the missing pci_set_master included.  I'll do some more testing and get
back to you...

Alan Stern



===== drivers/usb/core/hcd-pci.c 1.76 vs edited =====
--- 1.76/drivers/usb/core/hcd-pci.c	2005-03-11 02:15:12 -05:00
+++ edited/drivers/usb/core/hcd-pci.c	2005-03-16 10:43:50 -05:00
@@ -294,7 +294,6 @@
 		break;
 	}
 
-	/* update power_state **ONLY** to make sysfs happier */
 	if (retval == 0)
 		dev->dev.power.power_state = state;
 	return retval;
@@ -328,22 +327,37 @@
 
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
 #endif
+			retval = pci_set_power_state (dev, PCI_D0);
+			if (retval < 0) {
+				dev_dbg (&dev->dev, "PCI resume fail, %d\n",
+						retval);
+				return retval;
+			}
+		}
+		dev->dev.power.power_state = PMSG_ON;
+		retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
+				hcd->irq_descr, hcd);
+		if (retval < 0) {
+			dev_err (hcd->self.controller,
+				"can't restore IRQ after resume!\n");
+			return retval;
+		}
+		hcd->saw_irq = 0;
+		retval = pci_enable_device (dev);
+		if (retval < 0) {
+			dev_err (hcd->self.controller,
+				"can't enable device after resume!\n");
+			return retval;
+		}
+		pci_set_master (dev);
+		pci_restore_state (dev);
+	}
 
 	retval = hcd->driver->resume (hcd);
 	if (!HCD_IS_RUNNING (hcd->state)) {
@@ -357,5 +371,3 @@
 EXPORT_SYMBOL (usb_hcd_pci_resume);
 
 #endif	/* CONFIG_PM */
-
-


--===============086258113905862466==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============086258113905862466==--

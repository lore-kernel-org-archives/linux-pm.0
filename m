From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Tue, 15 Mar 2005 14:11:54 -0800
Message-ID: <200503151411.54748.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503151636290.711-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q21NCjiJMyTUyPU"
In-Reply-To: <Pine.LNX.4.44L0.0503151636290.711-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_q21NCjiJMyTUyPU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 15 March 2005 1:48 pm, Alan Stern wrote:

> It turns out there are a few problems in the hcd-pci.c suspend and resume
> routines; mostly that the resume routine doesn't do the reverse of what
> the suspend routine does.  One particularly bad symptom is that when
> "resuming" from D0 it does pci_restore_state() even though
> pci_save_state() was never called.  That's why my controller ended up
> unconfigured.

I noticed that a while back, and had a patch for it.  Didn't seem to
matter on anything I tested; sorry, I should have posted the patch
just for comments, in case it mattered on other hardware!  Attached;
applies to current code with some fuzz, not guaranteed to behave.


> One other point: Suspend calls free_irq() and resume calls request_irq().  
> This doesn't seem necessary to me since the common IRQ handler will reject
> interrupts occuring while the controller is suspended.  Also it's asking
> for trouble if the driver is unloaded before the controller is resumed,
> since the remove routine will call free_irq() again on its own.  I've
> #ifdef'ed out those calls below, but this deserves closer attention.

Those request/free calls moved up out of PPC-specific code; Ben can
comment on why at least some of the Apple hardware needed it.  The
free_irq() should be safe, since it should be a NOP if there's no
handler associated with that cookie.


> Another thing deserving closer attention is the various error pathways and
> what state they end up leaving the hardware and the data structures in.  

As always!  My rule of thumb is that if there aren't three lines of
fault handling code for every "productive" line, it's likely there's
something wrong in a fault path.  That's not always accurate, but it's
surprisingly close on stable codebases.

- Dave


--Boundary-00=_q21NCjiJMyTUyPU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hcd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hcd.patch"

--- 1.50/drivers/usb/core/hcd-pci.c	Sun Nov  7 05:06:51 2004
+++ edited/drivers/usb/core/hcd-pci.c	Wed Nov 10 09:55:10 2004
@@ -407,9 +407,9 @@
 
 	hcd->state = USB_STATE_RESUMING;
 
-	if (has_pci_pm)
-		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = 0;
+	pci_enable_device (dev);
+	pci_restore_state (dev);
+	pci_set_master (dev);
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->description, hcd);
 	if (retval < 0) {
@@ -418,7 +418,9 @@
 		return retval;
 	}
 	hcd->saw_irq = 0;
-	pci_restore_state (dev);
+	if (has_pci_pm)
+		pci_set_power_state (dev, 0);
+	dev->dev.power.power_state = 0;
 #ifdef	CONFIG_USB_SUSPEND
 	pci_enable_wake (dev, dev->current_state, 0);
 	pci_enable_wake (dev, 4, 0);

--Boundary-00=_q21NCjiJMyTUyPU
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_q21NCjiJMyTUyPU--

From: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Thu, 17 Mar 2005 09:10:13 +0800
Message-ID: <20050317011013.GD10545@blackham.com.au>
References: <20050316165239.GA10545@blackham.com.au>
	<Pine.LNX.4.44L0.0503161336500.1040-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0503161336500.1040-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 16, 2005 at 01:44:00PM -0500, Alan Stern wrote:
> > Needed an extra patch to compile, attached.
> 
> I didn't get your attachment.

D'oh. For real this time.

> >  However, it still doesn't survive more than one suspend/resume
> >  with devices plugged in. On the second resume, USB is dead, and
> >  it enters the same suspend_hc/wakeup_hc loop. I traced this
> >  back to the hcd never really being resumed, as the pci power
> >  state never changes from D0 as pci_set_power_state is never
> >  called here. The attached patch also addresses this - I'm not
> >  sure if it's the right way, but it works(ish):
> 
> Can _you_ elaborate on "never really being resumed"?  Since the
> state never changes from D0 much of the code in
> usb_hcd_pci_suspend never runs, as you said above.  In fact about
> the only thing that does happen is the call to
> hcd->driver->suspend.  However the reverse call to
> hcd->driver->resume does get made in usb_hcd_pci_resume even
> though the state upon entry is D0.

I meant specifically in the resume path, there's an if statement to
check if the pci power state is > D0, and only acts if that's the
case. Hopefully the first hunk of the patch attached makes this more
clear. None of the code inside that if statement was being called.

Bernard

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alan-usb-fixes-2-fixes.diff"

Index: linux/drivers/usb/core/hcd-pci.c
===================================================================
--- linux.orig/drivers/usb/core/hcd-pci.c	2005-03-16 23:49:50.000000000 +0800
+++ linux/drivers/usb/core/hcd-pci.c	2005-03-17 00:28:10.000000000 +0800
@@ -396,7 +396,7 @@
 
 	hcd->state = USB_STATE_RESUMING;
 
-	if (dev->current_state > PCI_D0) {
+	if (dev->dev.power.power_state.event != EVENT_ON) {
 		if (has_pci_pm) {
 #ifdef	CONFIG_USB_SUSPEND
 			pci_enable_wake (dev, dev->current_state, 0);
@@ -411,7 +411,7 @@
 		}
 		dev->dev.power.power_state = PMSG_ON;
 		retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
-				hcd->irq_descr, hcd);
+				hcd->driver->description, hcd);
 		if (retval < 0) {
 			dev_err (hcd->self.controller,
 				"can't restore IRQ after resume!\n");

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--eJnRUKwClWJh1Khz--

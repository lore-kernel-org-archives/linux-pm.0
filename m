From: Alan Stern <stern@rowland.harvard.edu>
Subject: [Bug 8498], [Bug 8510], and Re: Can't s2ram 22-rc2
Date: Mon, 21 May 2007 10:51:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705211040330.4496-100000__5463.93525223738$1179759183$gmane$org@iolanthe.rowland.org>
References: <20070519164504.GA10675@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070519164504.GA10675@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Borzenkov <arvidjaar@mail.ru>, Soeren Sonnenburg <kernel@nn7.de>, Avuton Olrich <avuton@gmail.com>, Greg KH <greg@kroah.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Sat, 19 May 2007, Greg KH wrote:

> On Sat, May 19, 2007 at 11:16:44AM -0400, Alan Stern wrote:
> > Greg:
> > 
> > The patch in $SUBJECT (already in your development tree) fixes a problem
> > with system suspend in 2.6.22-rc1, as described in
> > 
> > 	http://bugzilla.kernel.org/show_bug.cgi?id=8498
> > 
> > (For people on the PM development list, it's worth pointing out that all
> > the patch does is make a particular kernel thread freezable.)
> > 
> > Can you please expedite getting it sent up to Linus?
> 
> Will do, I have a number of USB bugfixes to go to Linus, just been
> traveling too much.  Next week I'll be able to get to it...


On Sun, 20 May 2007, Andrey Borzenkov wrote:

> No. Unfortunately. Here is dmesg with patch and USB_DEBUG
> 
> swsusp: Marking nosave pages: 000000000009f000 - 0000000000100000
> swsusp: Basic memory bitmaps created
> Stopping tasks ... done.
> Shrinking memory... done (61536 pages freed)
> Freed 246144 kbytes in 1.99 seconds (123.69 MB/s)
> Suspending console(s)
> hub 1-0:1.0: hub_suspend
> ohci_hcd 0000:00:02.0: suspend root hub
> usb usb1: usb suspend
> usb usb1: usb resume
> usb usb1: finish resume
> hub 1-0:1.0: hub_resume
> ohci_hcd 0000:00:02.0: wakeup root hub
> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> pnp: Device 00:09 disabled.
> Trying to free already-free IRQ 11
> ACPI: PCI interrupt for device 0000:00:06.0 disabled
> ACPI: Unable to derive IRQ for device 0000:00:04.0
> pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x230 [usbcore]() returns -16
> suspend_device(): pci_device_suspend+0x0/0x70() returns -16
> Could not suspend device 0000:00:02.0: error -16


On Mon, 21 May 2007, Rafael J. Wysocki wrote:

> > pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x170() returns -16
> > suspend_device(): pci_device_suspend+0x0/0x60() returns -16
> > Could not suspend device 0000:00:1d.0: error -16
> > 
> > 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)
> > 
> > lspci/dmesg are in this mail:
> > http://marc.info/?l=linux-kernel&m=117973679209855&w=2
> 
> Well, I think Alan should have a look at this too.


It turns out that the patch I originally wrote to fix this is in
conflict with one of Raphael's patches (make freezeable workqueues
singlethread) already added to 2.6.22-rc2.  So here's an updated
version for that kernel.

Andrey, Soeren, and Avuton: Please try this patch with 2.6.22-rc2 or 
later and see if it fixes your problems.

Greg, if this works then I'll send it in the proper form for a patch, 
and you can use it to replace

	usb-make-the-autosuspend-workqueue-thread-freezable.patch

Alan Stern


Index: 2.6.22-rc2/drivers/usb/core/usb.c
===================================================================
--- 2.6.22-rc2.orig/drivers/usb/core/usb.c
+++ 2.6.22-rc2/drivers/usb/core/usb.c
@@ -205,7 +205,7 @@ struct device_type usb_device_type = {
 
 static int ksuspend_usb_init(void)
 {
-	ksuspend_usb_wq = create_singlethread_workqueue("ksuspend_usbd");
+	ksuspend_usb_wq = create_freezeable_workqueue("ksuspend_usbd");
 	if (!ksuspend_usb_wq)
 		return -ENOMEM;
 	return 0;

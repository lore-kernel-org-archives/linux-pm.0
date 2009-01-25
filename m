From: <gregkh@suse.de>
Subject: patch
	usb-don-t-enable-wakeup-by-default-for-pci-host-controllers.patch
	added to gregkh-2.6 tree
Date: Sat, 24 Jan 2009 16:29:23 -0800
Message-ID: <12328433631861__38131.8057458431$1232843659$gmane$org@kroah.org>
References: <Pine.LNX.4.44L0.0901131133430.2667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901131133430.2667-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu, david-b@pacbell.net, gregkh@suse.de, greg@kroah.com, linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org, rjw@sisk.pl, stable@kernel.org
List-Id: linux-pm@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    Subject: USB: don't enable wakeup by default for PCI host controllers

to my gregkh-2.6 tree.  Its filename is

    usb-don-t-enable-wakeup-by-default-for-pci-host-controllers.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From stern@rowland.harvard.edu  Sat Jan 24 16:19:17 2009
From: Alan Stern <stern@rowland.harvard.edu>
Date: Tue, 13 Jan 2009 11:35:54 -0500 (EST)
Subject: USB: don't enable wakeup by default for PCI host controllers
To: Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, USB list <linux-usb@vger.kernel.org>,  Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Message-ID: <Pine.LNX.4.44L0.0901131133430.2667-100000@iolanthe.rowland.org>


This patch (as1199) changes the initial wakeup settings for PCI USB
host controllers.  The controllers are marked as capable of waking the
system, but wakeup is not enabled by default.

It turns out that enabling wakeup for USB host controllers has a lot
of bad consequences.  As the simplest example, if a USB mouse or
keyboard is unplugged immediately after the computer is put to sleep,
the unplug will cause the system to wake back up again!  We are better
off marking them as wakeup-capable and leaving wakeup disabled.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Rafael J. Wysocki <rjw@sisk.pl>
CC: David Brownell <david-b@pacbell.net>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/hcd-pci.c  |    1 -
 drivers/usb/host/ehci-pci.c |    2 +-
 drivers/usb/host/ohci-hcd.c |    8 +++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -128,7 +128,6 @@ int usb_hcd_pci_probe(struct pci_dev *de
 	}
 
 	pci_set_master(dev);
-	device_set_wakeup_enable(&dev->dev, 1);
 
 	retval = usb_add_hcd(hcd, dev->irq, IRQF_DISABLED | IRQF_SHARED);
 	if (retval != 0)
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -230,7 +230,7 @@ static int ehci_pci_setup(struct usb_hcd
 		pci_read_config_word(pdev, 0x62, &port_wake);
 		if (port_wake & 0x0001) {
 			dev_warn(&pdev->dev, "Enabling legacy PCI PM\n");
-			device_init_wakeup(&pdev->dev, 1);
+			device_set_wakeup_capable(&pdev->dev, 1);
 		}
 	}
 
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -593,12 +593,10 @@ static int ohci_run (struct ohci_hcd *oh
 	 * to be checked in case boot firmware (BIOS/SMM/...) has set up
 	 * wakeup in a way the bus isn't aware of (e.g., legacy PCI PM).
 	 * If the bus glue detected wakeup capability then it should
-	 * already be enabled.  Either way, if wakeup should be enabled
-	 * but isn't, we'll enable it now.
+	 * already be enabled; if so we'll just enable it again.
 	 */
-	if ((ohci->hc_control & OHCI_CTRL_RWC) != 0
-			&& !device_can_wakeup(hcd->self.controller))
-		device_init_wakeup(hcd->self.controller, 1);
+	if ((ohci->hc_control & OHCI_CTRL_RWC) != 0)
+		device_set_wakeup_capable(hcd->self.controller, 1);
 
 	switch (ohci->hc_control & OHCI_CTRL_HCFS) {
 	case OHCI_USB_OPER:


Patches currently in gregkh-2.6 which might be from stern@rowland.harvard.edu are

usb.current/usb-don-t-enable-wakeup-by-default-for-pci-host-controllers.patch
usb.current/usb-fix-char-device-disconnect-handling.patch
usb.current/usb-fix-suspend-resume-of-pci-usb-controllers.patch
usb.current/usb-fix-toggle-mismatch-in-disable_endpoint-paths.patch
driver-core.current/klist.c-bit-0-in-pointer-can-t-be-used-as-flag.patch

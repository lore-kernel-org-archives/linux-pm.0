From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.14-rc1-mm1: usb breaks suspend
Date: Mon, 17 Oct 2005 21:01:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510172048290.30056-100000@netrider.rowland.org>
References: <200510172311.35500.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============43075710283720681=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510172311.35500.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============43075710283720681==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 17 Oct 2005, Rafael J. Wysocki wrote:

> Hi,
> 
> On Monday, 17 of October 2005 20:54, Alan Stern wrote:
> > On Mon, 17 Oct 2005, Pavel Machek wrote:
> > 
> > > Hi!
> > > 
> > > In -mm, usb breaks suspend to disk. Compiled without
> > > CONFIG_USB_SUSPEND, it just plainly fails; iwth USB_SUSPEND, it
> > > actually tries to suspend USB, but it fails and machine refuses to
> > > suspend. Is it known or is it worth debugging?
> > 
> > More details please.
> 
> Fails for me too on x86-64, with the following messages:
> 
> Stopping tasks: ========================|
> Freeing memory... done (14642 pages freed)
> Suspending device card0-0
> Suspending device 2-2:1.0
> Suspending device 2-2
> Suspending device 3-0:1.0
> hub 3-0:1.0: no suspend?
> Suspending device usb3
> Could not suspend device usb3: error -16
> Some devices failed to suspend
> Restarting tasks... done
> 
> where the USB-related info returned by the kernel is this:
> 
> ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 11 (level, low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> ohci_hcd 0000:00:02.0: OHCI Host Controller
> ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
> ohci_hcd 0000:00:02.0: irq 11, io mem 0xfebfb000
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS1] -> GSI 11 (level, low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:02.1 to 64
> ohci_hcd 0000:00:02.1: OHCI Host Controller
> ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
> ohci_hcd 0000:00:02.1: irq 11, io mem 0xfebfc000
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 5
> usb 2-2: new low speed USB device using ohci_hcd and address 2
> PCI: setting IRQ 5 as level-triggered
> ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 5 (level, low) -> IRQ 5
> PCI: Setting latency timer of device 0000:00:02.2 to 64
> ehci_hcd 0000:00:02.2: EHCI Host Controller
> ehci_hcd 0000:00:02.2: debug port 1
> ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
> ehci_hcd 0000:00:02.2: irq 5, io mem 0xfebfdc00
> PCI: cache line size of 64 is not supported by device 0000:00:02.2
> ehci_hcd 0000:00:02.2: park 0
> ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
> usb 2-2: device descriptor read/all, error -110
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 6 ports detected
> ohci_hcd 0000:00:02.1: wakeup
> usb 2-2: new low speed USB device using ohci_hcd and address 4
> usbcore: registered new driver hiddev
> input: Logitech USB Receiver//class/input_dev as input3
> input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:02.1-2
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> 
> Greetings,
> Rafael

Weird.

I can't tell what happened.  But I can tell you that USB development
goes on in Greg K-H's tree.  The current version is available as a patch
based on 2.6.14-rc4:

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-all-2.6.14-rc4.patch

On top of that you should apply the patch for uhci-hcd that I mentioned 
before.  With this combination I have had no problem suspending three 
different machines.  Sometimes they even wake up, too!  :-)

Be warned: That particular kernel has a bug which sometimes causes 
"modprobe ehci-hcd" to hang.  In case this happens to you, I've included a 
patch below with a temporary workaround.  Untested, but it should work.

Alan Stern



--- a/drivers/usb/host/ehci-pci.c	Thu Oct 13 17:04:13 2005
+++ b/drivers/usb/host/ehci-pci.c	Mon Oct 17 20:57:21 2005
@@ -66,6 +66,7 @@
 	u32			temp;
 	unsigned		count = 256/4;
 
+	spin_lock_init (&ehci->lock);
 	ehci->caps = hcd->regs;
 	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
 	dbg_hcs_params(ehci, "reset");


--===============43075710283720681==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============43075710283720681==--

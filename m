From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Mon, 23 Apr 2012 16:11:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204231554210.1612-100000@iolanthe.rowland.org>
References: <1335205839.28106.108.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335205839.28106.108.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 23 Apr 2012, Steven Rostedt wrote:

> On Mon, 2012-04-23 at 12:29 -0400, Alan Stern wrote:
> > On Sun, 22 Apr 2012, Andrey Rahmatullin wrote:
> > 
> > > > All right.  Maybe you posted this information earlier in the thread, 
> > > > but it's easier to ask again than try to find it.  What output do you 
> > > > get from "lspci -nv -s 1a.0"?
> > > 00:1a.0 0c03: 8086:1c2d (rev 05) (prog-if 20 [EHCI])
> > >         Subsystem: 1043:1147
> > >         Flags: bus master, medium devsel, latency 0, IRQ 16
> > >         Memory at dfe08000 (32-bit, non-prefetchable) [size=1K]
> > >         Capabilities: [50] Power Management version 2
> > >         Capabilities: [58] Debug port: BAR=1 offset=00a0
> > >         Capabilities: [98] PCI Advanced Features
> > >         Kernel driver in use: ehci_hcd
> > 
> > Steve, what about you?  Do you get the same thing?
> > 
> 
> 00:1a.0 0c03: 8086:1c2d (rev 05) (prog-if 20 [EHCI])
> 	Subsystem: 1043:1157
> 	Flags: bus master, medium devsel, latency 0, IRQ 16
> 	Memory at dfc08000 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [58] Debug port: BAR=1 offset=00a0
> 	Capabilities: [98] PCI Advanced Features
> 	Kernel driver in use: ehci_hcd
> 
> Almost, the Subsystem is 1157 instead of 1147. But the rest looks alike.

I don't have a very clear idea of how specific this needs to be.  There 
have been other bug reports of problems related to suspend that were 
fixed by the same script you were using, but the symptoms weren't the 
same.  For example, see Bugzilla #42728.

Anyway, this patch is reasonably close to being a final version, and it
should work on both machines.  You should be able to suspend and resume
with no problems, without using the script.

Alan Stern




Index: usb-3.4/include/linux/usb/hcd.h
===================================================================
--- usb-3.4.orig/include/linux/usb/hcd.h
+++ usb-3.4/include/linux/usb/hcd.h
@@ -126,6 +126,8 @@ struct usb_hcd {
 	unsigned		wireless:1;	/* Wireless USB HCD */
 	unsigned		authorized_default:1;
 	unsigned		has_tt:1;	/* Integrated TT in root hub */
+	unsigned		broken_pci_sleep:1;	/* Don't put the
+			controller in PCI-D3 for system sleep */
 
 	unsigned int		irq;		/* irq allocated */
 	void __iomem		*regs;		/* device memory/io */
Index: usb-3.4/drivers/usb/core/hcd-pci.c
===================================================================
--- usb-3.4.orig/drivers/usb/core/hcd-pci.c
+++ usb-3.4/drivers/usb/core/hcd-pci.c
@@ -493,6 +493,15 @@ static int hcd_pci_suspend_noirq(struct
 
 	pci_save_state(pci_dev);
 
+	/*
+	 * Some systems crash if an EHCI controller is in D3 during
+	 * a sleep transition.  We have to leave such controllers in D0.
+	 */
+	if (hcd->broken_pci_sleep) {
+		dev_dbg(dev, "Staying in PCI D0\n");
+		return retval;
+	}
+
 	/* If the root hub is dead rather than suspended, disallow remote
 	 * wakeup.  usb_hc_died() should ensure that both hosts are marked as
 	 * dying, so we only need to check the primary roothub.
Index: usb-3.4/drivers/usb/host/ehci-pci.c
===================================================================
--- usb-3.4.orig/drivers/usb/host/ehci-pci.c
+++ usb-3.4/drivers/usb/host/ehci-pci.c
@@ -144,6 +144,13 @@ static int ehci_pci_setup(struct usb_hcd
 			hcd->has_tt = 1;
 			tdi_reset(ehci);
 		}
+		if (pdev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK) {
+			/* EHCI #1 or #2 on 6 Series/C200 Series chipset */
+			if (pdev->device == 0x1c26 || pdev->device == 0x1c2d) {
+				ehci_info(ehci, "broken D3 during system sleep on ASUS\n");
+				hcd->broken_pci_sleep = 1;
+			}
+		}
 		break;
 	case PCI_VENDOR_ID_TDI:
 		if (pdev->device == PCI_DEVICE_ID_TDI_EHCI) {

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 11 Apr 2012 15:12:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204111429510.1351-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1204111324100.1351-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204111324100.1351-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Apr 2012, Alan Stern wrote:

> On Wed, 11 Apr 2012, Steven Rostedt wrote:

> > I'm willing to test fixes, as the issue still exists for my laptop if I
> > remove the script.
> 
> It would be great if we had something to try out.  So far I'm not aware
> of any suggestions from anybody as to the underlying cause of the
> problem or how to fix it.
> 
> Ideas welcome.

All right, here are some ideas.  As far as I can tell, there's only a
handful of differences in the EHCI hardware state between a normal
suspend and a suspend in which ehci-hcd has been removed or unbound.

There are several differences in the controller registers that I
seriously doubt will have any effect.  These are things like the
ASYNCLISTADDR register, which contains the address of the start of the
async schedule when the driver is present and 0 when the driver is not 
present.  These registers are ignored when the controller isn't 
actively running.

There's also the port status & control register for port 1.  When the
driver is present, this register indicate that the port is enabled
(it's connected to the built-in "rate-matching" hub), whereas without
the driver the port is disabled.  We could test whether disabling the
port makes any difference, but I hope it doesn't -- disabling the port
has the effect of logically disconnecting everything that was connected
to the controller.

Finally there's one more thing: the CONFIGFLAG register.  Without the
driver this register contains 0, and the driver sets it to 1.  For the
Intel chipset you're using this shouldn't do anything, because this bit
controls port routing between the EHCI controller and the companion
controller, and your chipset has no companion controller.  I haven't
looked at the datasheet for Intel's Cougar Point chipset, and it's
possible they have repurposed this register.

If so, setting the value back to 0 before suspending (or never setting 
it to 1 in the first place) might be important.  You can test this 
easily enough.  In drivers/usb/host/ehci-pci.c:ehci_pci_suspend(), add 
a line saying

	ehci_writel(ehci, 0, &ehci->regs->configured_flag);

just before the spin_lock_irqrestore.  This will invalidate the
driver's criterion for determining whether or not the controller's
state got messed up during the suspend; we can worry about that later.


There are other differences, at the PCI level, that might also be 
significant.  When the driver is not present, the PCI core calls 
pci_disable_enabled_device.  But when the driver is loaded, instead 
it calls pci_disable_device and pci_prepare_to_sleep.

You can try getting rid of the call to pci_prepare_to_sleep in 
drivers/usb/core/hcd-pci.c:hcd_pci_suspend_noirq.  This will prevent 
the controller from being put into D3hot and might interfere with 
wakeup detection.

I don't know how sigificant the difference is between
pci_disable_device and pci_disable_enabled_device.  Probably not very, 
since all it involves is whether or not to disable bus-mastering on the 
controller.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

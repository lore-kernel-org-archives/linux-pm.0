From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 11 Apr 2012 16:43:55 -0400
Message-ID: <1334177035.23924.299.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204111429510.1351-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204111429510.1351-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-04-11 at 15:12 -0400, Alan Stern wrote:

> If so, setting the value back to 0 before suspending (or never setting 
> it to 1 in the first place) might be important.  You can test this 
> easily enough.  In drivers/usb/host/ehci-pci.c:ehci_pci_suspend(), add 
> a line saying
> 
> 	ehci_writel(ehci, 0, &ehci->regs->configured_flag);
> 
> just before the spin_lock_irqrestore.  This will invalidate the
> driver's criterion for determining whether or not the controller's
> state got messed up during the suspend; we can worry about that later.

I just tried the above, and it made no difference. Note, I don't even
get to suspend. It locks up in suspend, so I haven't even tried a resume
yet.

> 
> 
> There are other differences, at the PCI level, that might also be 
> significant.  When the driver is not present, the PCI core calls 
> pci_disable_enabled_device.  But when the driver is loaded, instead 
> it calls pci_disable_device and pci_prepare_to_sleep.
> 
> You can try getting rid of the call to pci_prepare_to_sleep in 
> drivers/usb/core/hcd-pci.c:hcd_pci_suspend_noirq.  This will prevent 
> the controller from being put into D3hot and might interfere with 
> wakeup detection.
> 

What do I do with the retval? -EIO, 0, or other?

-- Steve

> I don't know how sigificant the difference is between
> pci_disable_device and pci_disable_enabled_device.  Probably not very, 
> since all it involves is whether or not to disable bus-mastering on the 
> controller.
> 
> Alan Stern


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

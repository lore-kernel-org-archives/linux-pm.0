From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 17:30:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204181729400.1149-100000@iolanthe.rowland.org>
References: <20120418212301.GW11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418212301.GW11484-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 19 Apr 2012, Andrey Rahmatullin wrote:

> On Wed, Apr 18, 2012 at 04:23:20PM -0400, Alan Stern wrote:
> > In the meantime, just to be certain of the diagnosis, here's a
> > different patch for you guys to try.  This will test the ehci-hcd
> > unbound path (i.e., use it with the script).  The patch removes the
> > line that sets the dev->current_state to PCI_UNKNOWN when the driver is
> > unbound.  Thus current_state will remain equal to PCI_D0, so
> > pci_prepare_to_sleep should put the controllers into D3, which we
> > expect will cause a crash.
> > 
> > Please try this both with and without pm_test set to "platform", and 
> > post the debugging dmesg output from whichever cases the computer 
> > survives.
> With "platform":
> 
> ehci_hcd 0000:00:1d.0: wake-up capability enabled by ACPI
> ehci_hcd 0000:00:1d.0: cur 0 target 3 error 0
> ehci_hcd 0000:00:1a.0: wake-up capability enabled by ACPI
> ehci_hcd 0000:00:1a.0: cur 0 target 3 error 0
> 
> With "none" it locks up.

Good, this confirms that the patch really does cause the unbound device 
to be put into D3.

Tomorrow we can try to figure out the appropriate workaround.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 13:20:32 -0400
Message-ID: <1334769632.28106.46.camel@gandalf.stny.rr.com>
References: <20120418152455.GT11484@belkar.wrar.name>
	 <Pine.LNX.4.44L0.1204181228380.1149-100000@iolanthe.rowland.org>
	 <20120418171002.GU11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418171002.GU11484-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-04-18 at 23:10 +0600, Andrey Rahmatullin wrote:
> On Wed, Apr 18, 2012 at 12:41:10PM -0400, Alan Stern wrote:
> > Here's the situation.  When the script unbinds ehci-hcd, 
> > pci_device_remove() sets the current state to PCI_UNKNOWN.  The patch 
> > to hcd-pci.c does the same thing before the suspend_noirq phase begins, 
> > i.e., before pci_prepare_to_sleep() is called.
> > 
> > In pci_raw_set_power_state(), there's a "switch" statement that depends
> > on dev->current_state.  If the current state is PCI_D0 then the new
> > state in pmcsr is set to PCI_D3; if the current state is PCI_UNKNOWN
> > then the state in pmcsr is left unchanged.  After that, the value in
> > pmcsr is written to the controller.
> > 
> > This means that when ehci-hcd is unbound or the patch is installed, the
> > controller stays in D0.  That's why we see those "Refused to change
> > power state" messages, since D0 is not what the target state was
> > supposed to be.  When ehci-hcd remains bound and the patch isn't
> > installed, the controller is put into D3.
> > 
> > And then finally, the computer crashes during the final stage of 
> > suspend if either controller is in D3.  Clearly this is a bug in the 
> > firmware, not in the kernel.
> > 
> > Have you guys checked to see if any BIOS updates are available?
> I've just updated to 219 and it still hangs.

I only see 213 on their website.

Alan,

Is there a way to detect this chipset or something, to add a workaround
for it?

As it works for Windows, I wonder what their workaround was.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

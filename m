From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 10:51:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204181048340.1548-100000@iolanthe.rowland.org>
References: <20120417195218.GP11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120417195218.GP11484-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Apr 2012, Andrey Rahmatullin wrote:

> On Tue, Apr 17, 2012 at 03:20:32PM -0400, Alan Stern wrote:
> > > Unbound:
> > > 
> > > pci 0000:00:1d.0: wake-up capability enabled by ACPI
> > > pci 0000:00:1d.0: Refused to change power state, currently in D0
> > > pci 0000:00:1d.0: cur 5 target 3 error 0
> > > pci 0000:00:1a.0: wake-up capability enabled by ACPI
> > > pci 0000:00:1a.0: Refused to change power state, currently in D0
> > > pci 0000:00:1a.0: cur 5 target 3 error 0
> > > 
> > > Bound:
> > > 
> > > ehci_hcd 0000:00:1d.0: wake-up capability enabled by ACPI
> > > ehci_hcd 0000:00:1d.0: Refused to change power state, currently in D0
> > > ehci_hcd 0000:00:1d.0: cur 5 target 3 error 0
> > > ehci_hcd 0000:00:1a.0: wake-up capability enabled by ACPI
> > > ehci_hcd 0000:00:1a.0: Refused to change power state, currently in D0
> > > ehci_hcd 0000:00:1a.0: cur 5 target 3 error 0
> > 
> > Very good.  The two behaviors are the same.
> > 
> > Now if you modify the patch by removing the change to hcd-pci.c, which 
> > will leave the EHCI code exactly the same as in the vanilla kernel, and 
> > set the pm_test value to "platform", what does the dmesg log show in 
> > the two cases?
> The same for the unbound state. For the bound state, it still locks up.

That's odd.  Didn't you say earlier that after "echo platform 
>/sys/power/pm_test", the bound case worked?  Or was that just Steve?

And come to think of it, we haven't heard anything from Steve recently.

Steve?  Does the last patch fix the problem on your machine too?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

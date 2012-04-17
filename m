From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Tue, 17 Apr 2012 15:20:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204171513230.1163-100000@iolanthe.rowland.org>
References: <20120417185149.GO11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120417185149.GO11484-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Apr 2012, Andrey Rahmatullin wrote:

> > Wow.  Okay, I have boiled this down to a single patch.  You should 
> > try this both with and without unbinding ehci-hcd, and post the dmesg 
> > log output that it generates in the two cases.
> 
> Unbound:
> 
> pci 0000:00:1d.0: wake-up capability enabled by ACPI
> pci 0000:00:1d.0: Refused to change power state, currently in D0
> pci 0000:00:1d.0: cur 5 target 3 error 0
> pci 0000:00:1a.0: wake-up capability enabled by ACPI
> pci 0000:00:1a.0: Refused to change power state, currently in D0
> pci 0000:00:1a.0: cur 5 target 3 error 0
> 
> Bound:
> 
> ehci_hcd 0000:00:1d.0: wake-up capability enabled by ACPI
> ehci_hcd 0000:00:1d.0: Refused to change power state, currently in D0
> ehci_hcd 0000:00:1d.0: cur 5 target 3 error 0
> ehci_hcd 0000:00:1a.0: wake-up capability enabled by ACPI
> ehci_hcd 0000:00:1a.0: Refused to change power state, currently in D0
> ehci_hcd 0000:00:1a.0: cur 5 target 3 error 0

Very good.  The two behaviors are the same.

Now if you modify the patch by removing the change to hcd-pci.c, which 
will leave the EHCI code exactly the same as in the vanilla kernel, and 
set the pm_test value to "platform", what does the dmesg log show in 
the two cases?

Steven reported that the power state does get set to D3hot; he did not
get the "Refused to change power state" lines.

I have a strong feeling that your computer crashes during suspend 
whenever the EHCI controllers are in a low-power state.  We'll see.

Alan Stern


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

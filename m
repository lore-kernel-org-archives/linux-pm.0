From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 16:25:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204181623310.1149-100000@iolanthe.rowland.org>
References: <20120418174610.GA10142@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418174610.GA10142-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Apr 2012, Mark Brown wrote:

> On Wed, Apr 18, 2012 at 01:24:07PM -0400, Steven Rostedt wrote:
> 
> > Hmm, if the system is going down into suspend, what's the purpose of
> > putting the individual devices into low-power states. The entire system
> > will become a low-power state once it hits suspend, wont it?
> 
> Embedded platforms tend to rely on drivers doing this, either because
> the system suspend just suspends a portion of the system or because
> suspending the core on the system relies on the devices having being
> quiesced (or a combination of both).

Right.  One reasonable workaround might be simply to avoid putting PCI 
devices into D3 before suspend if the system uses ACPI.  But I don't 
know if that would interfere with the wakeup mechanism.

On the whole, it seems like a better idea to treat this particular 
chipset specially.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

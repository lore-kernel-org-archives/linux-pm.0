From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 13:19:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204181317550.1149-100000@iolanthe.rowland.org>
References: <1334768847.28106.45.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334768847.28106.45.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Apr 2012, Steven Rostedt wrote:

> On Wed, 2012-04-18 at 12:41 -0400, Alan Stern wrote:
> 
> > And then finally, the computer crashes during the final stage of 
> > suspend if either controller is in D3.  Clearly this is a bug in the 
> > firmware, not in the kernel.
> > 
> > Have you guys checked to see if any BIOS updates are available?
> > 
> 
> Looks to be a new bios available. I've never had the guts to update a
> bios on a laptop before. I guess I should try now ;-)
> 
> http://support.asus.com/download.aspx?SLanguage=en&p=3&s=343&m=U56E&os=&hashedid=6KBv9FLOCOczEXLJ
> 
> What do you think Windows does for this?

I have no idea.  I don't even know how to find out.

Maybe Windows doesn't bother putting the individual devices into
low-power states before suspending the entire system.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

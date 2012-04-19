From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 12:05:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204191204550.2070-100000@iolanthe.rowland.org>
References: <20120419154453.GZ11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120419154453.GZ11484-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 19 Apr 2012, Andrey Rahmatullin wrote:

> On Thu, Apr 19, 2012 at 09:43:45AM -0400, Alan Stern wrote:
> > But before going any farther, I'd like to test if USB wakeup works.  
> > So after booting with this patch, make sure that the power/wakeup file
> > says "enabled" in the sysfs path for each controller as well as the
> > usb1, usb2, 1-2, and 2-2 paths under /sys/bus/usb/devices/.
> Should I change them if they say "disabled"?

Yes, write "enabled" to them.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 12:09:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204121203530.1496-100000@iolanthe.rowland.org>
References: <20120412153750.GA12852@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120412153750.GA12852-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Apr 2012, Andrey Rahmatullin wrote:

> > Here's a diagnostic patch that will give us a little more information.  
> > Keep the previous change (so that pci_prepare_to_sleep gets called 
> > whether ehci-hcd is bound or not) and let's see what it says.  Try 
> > doing it both with and without ehci-hcd bound.  Running this with "echo 
> > devices >/sys/power/pm_test" ought to be good enough.
> I don't see that line with ehci_hcd both bound and unbound and both in
> 'devices' test and in a real S3.

You mean the new dev_info message did not appear at all?  Is
pci_prepare_to_sleep getting called properly?  Or does the routine exit
early because target_state is equal to PCI_POWER_ERROR?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

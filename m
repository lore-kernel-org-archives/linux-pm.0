From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 17:27:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204181724570.1149-100000@iolanthe.rowland.org>
References: <1334782932.28106.52.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334782932.28106.52.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Apr 2012, Steven Rostedt wrote:

> On Wed, 2012-04-18 at 16:23 -0400, Alan Stern wrote:
> 
> > In the meantime, just to be certain of the diagnosis, here's a
> > different patch for you guys to try.  This will test the ehci-hcd
> > unbound path (i.e., use it with the script).  The patch removes the
> > line that sets the dev->current_state to PCI_UNKNOWN when the driver is
> > unbound.  Thus current_state will remain equal to PCI_D0, so
> > pci_prepare_to_sleep should put the controllers into D3, which we
> > expect will cause a crash.
> 
> Confirmed. The suspend locked up even with the script.

Okay, now I'm certain that this is the problem.

> > Please try this both with and without pm_test set to "platform", and 
> > post the debugging dmesg output from whichever cases the computer 
> > survives.
> > 
> 
> Below is the dmesg output after running with pm_test set to "platform".

The part you included didn't show the suspend itself.  It looks like a 
bunch of stuff following the resume.  But I guess it doesn't much 
matter, since we now know what needs to be fixed.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

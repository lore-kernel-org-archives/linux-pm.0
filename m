From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 11:42:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204131138120.1163-100000@iolanthe.rowland.org>
References: <1334330949.23924.360.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334330949.23924.360.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Apr 2012, Steven Rostedt wrote:

> On Fri, 2012-04-13 at 10:10 -0400, Alan Stern wrote:
> > On Thu, 12 Apr 2012, Alan Stern wrote:
> > 
> > > Tomorrow I'll look through the code more carefully; with those changes
> > > there really is very little difference between the two cases.  Things
> > > like mmio mappings and IRQs requested; they shouldn't cause a crash.
> > 
> > Let's start with some basic information.  First, before suspending,
> > what shows up in /sys/kernel/debug/usb/devices?
> 
> Attached (after gzipping it).

Okay, you've got Bluetooth device and a USB webcam, in addition to the 
internal "rate-matching" hub on each EHCI bus.

> > Second, if you do
> > 
> > 	echo 0 >/sys/bus/usb/devices/usb1/bConfigurationValue
> 
> This never returned. I did the echo, and the command locked up.
> 
> (process 3077)
> 
> cat /proc/3077/wchan 
> usb_disconnect

I just did the same thing here, with the same result.  I'm trying to
track it down now.  It may take a while...

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

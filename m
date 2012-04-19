From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 14:30:59 -0400
Message-ID: <1334860259.28106.68.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204191411360.1154-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204191411360.1154-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-04-19 at 14:13 -0400, Alan Stern wrote:

> > Mine applied to pci_finish_runtime_suspend not pci_prepare_to_sleep :-p
> > I'm using 3.2.5.
> 
> Whoops!  That'll do it.  The names say it all: one routine is used for
> runtime PM and the other is used for system sleep.  The two functions
> are very similar, so naturally "patch" got confused.

Yep, after making the fix, it suspends fine.

But after setting all the power/wakeup to enabled, mine didn't wake up
when putting in a usb device. I had no lights either (unlike Andrey).

I've just set CONFIG_USB_DEBUG and I'm recompiling.

-- Steve

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 15:35:47 -0400
Message-ID: <1334259347.23924.345.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204121504550.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204121504550.1496-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-04-12 at 15:11 -0400, Alan Stern wrote:

> > # dmesg | grep target
> > [ 8829.427534] atl1c 0000:04:00.0: target 3 wakeup 0 error 0
> > [ 8829.443524] xhci_hcd 0000:03:00.0: target 3 wakeup 1 error 0
> > [ 8829.459506] iwlwifi 0000:02:00.0: target 3 wakeup 0 error 0
> > [ 8829.459560] pci 0000:00:1f.3: target 0 wakeup 0 error 0
> > [ 8829.459607] pci 0000:00:1f.0: target 0 wakeup 0 error 0
> > [ 8829.475458] ehci_hcd 0000:00:1d.0: target 3 wakeup 1 error 0
> > [ 8829.491433] ehci_hcd 0000:00:1a.0: target 3 wakeup 1 error 0
> > [ 8829.507416] pci 0000:00:16.0: target 3 wakeup 0 error 0
> 
> The entries above are left over from the earlier test.


Yep I knew that. I just figured to post the full dmesg grep instead of
trimming it. ;-)

> 
> > [ 9419.750158] atl1c 0000:04:00.0: target 3 wakeup 0 error 0
> > [ 9419.766134] pci 0000:03:00.0: target 3 wakeup 1 error 0
> > [ 9419.782126] iwlwifi 0000:02:00.0: target 3 wakeup 0 error 0
> > [ 9419.782181] pci 0000:00:1f.3: target 0 wakeup 0 error 0
> > [ 9419.782230] pci 0000:00:1f.0: target 0 wakeup 0 error 0
> > [ 9419.798087] pci 0000:00:1d.0: target 3 wakeup 1 error 0
> > [ 9419.814064] pci 0000:00:1a.0: target 3 wakeup 1 error 0
> > [ 9419.830031] pci 0000:00:16.0: target 3 wakeup 0 error 0
> 
> Evidently the script unbinds xhci-hcd too.  Did you check to make
> sure it is unrelated to the suspend problem?

The script I found on the internet disables both. I just changed it to
only disable ehci and did a full suspend, and it still works:

[13538.700577] atl1c 0000:04:00.0: target 3 wakeup 0 error 0
[13538.716565] xhci_hcd 0000:03:00.0: target 3 wakeup 1 error 0
[13538.732542] iwlwifi 0000:02:00.0: target 3 wakeup 0 error 0
[13538.732596] pci 0000:00:1f.3: target 0 wakeup 0 error 0
[13538.732644] pci 0000:00:1f.0: target 0 wakeup 0 error 0
[13538.748503] pci 0000:00:1d.0: target 3 wakeup 1 error 0
[13538.764481] pci 0000:00:1a.0: target 3 wakeup 1 error 0
[13538.780448] pci 0000:00:16.0: target 3 wakeup 0 error 0

> 
> Anyway, this shows that the EHCI controllers are being set to the same 
> power state with the same wakeup settings in both cases.  And yet one 
> hangs the computer while the other doesn't.
> 
> Here's another rather drastic test you can do.  In 
> drivers/usb/host/ehci-pci.c:ehci_pci_suspend(), call ehci_reset(ehci) 
> just before the final return statement.  That should leave the hardware 
> in exactly the same state as if ehci-hcd had been unbound.

Want me to remove previous updates before doing so? I can keep the
dev_log, but what about the other change you asked about.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

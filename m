From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Sat, 21 Apr 2012 13:26:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204211324560.475-100000@netrider.rowland.org>
References: <20120421083751.GA4570@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120421083751.GA4570-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 21 Apr 2012, Andrey Rahmatullin wrote:

> On Fri, Apr 20, 2012 at 08:42:03PM -0400, Alan Stern wrote:
> > > > I'd like to see the dmesg log for the complete suspend/resume cycle 
> > > > (naturally you'll have to resume the system by hand after plugging in 
> > > > the USB device).  Make sure that CONFIG_USB_DEBUG is enabled.
> > > Attached.
> > 
> > It looks quite normal.  Evidently USB wakeup does _not_ work on your 
> > system when the controller isn't in D3 -- and the system crashes during 
> > suspend if the controller _is_ in D3!
> > 
> > (Does anybody know if USB wakeup works on these machines under
> > Windows?)
> Out of the box it doesn't work and "Allow this device to wake up the
> computer" checkboxes on both root hubs are unchecked and grayed out.

Ha!  It seems that nobody knows how to make it work.

> > What about runtime wakeup?  You can test it easily enough.  Write 
> > "auto" to the power/control attribute for the two controllers.  This 
> > should cause the controllers (or at least one of them) to go into 
> > runtime suspend.  Does it then wake up when you plug in a USB device?
> I wrote 'auto' to both power/control, both power/runtime_status became
> 'suspended', I plugged in a device, one of power/runtime_status became
> 'active'.

Okay, that's good.  I assume the device you plugged in then functioned
properly?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

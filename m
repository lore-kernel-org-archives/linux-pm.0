From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 14:07:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204191404460.1154-100000@iolanthe.rowland.org>
References: <20120419163055.GB11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120419163055.GB11484-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 19 Apr 2012, Andrey Rahmatullin wrote:

> On Thu, Apr 19, 2012 at 09:43:45AM -0400, Alan Stern wrote:
> > Below is a patch that will prevent any PCI device from being put into
> > D3 during suspend.  (This is meant to be used without any of the
> > earlier diagnostic patches.)  Obviously it's not the final solution; 
> > the test in the "if" statement needs to be more discriminating.  :-)
> > 
> > But before going any farther, I'd like to test if USB wakeup works.  
> > So after booting with this patch, make sure that the power/wakeup file
> > says "enabled" in the sysfs path for each controller as well as the
> > usb1, usb2, 1-2, and 2-2 paths under /sys/bus/usb/devices/.
> > 
> > Then suspend the computer without using the script, and while it is
> > asleep try plugging in a new USB device.  That should cause the
> > computer to wake up, if everything is working properly.
> I've set "enabled" for following files:
> 
> /sys/bus/usb/devices/usb1/power/wakeup
> /sys/bus/usb/devices/usb2/power/wakeup
> /sys/bus/usb/devices/1-1/power/wakeup
> /sys/bus/usb/devices/2-1/power/wakeup
> /sys/bus/pci/devices/0000:00:1a.0/power/wakeup
> /sys/bus/pci/devices/0000:00:1d.0/power/wakeup

Good.

> yet it didn't wake up after plugging, though devices light up.

You mean, the devices that you plug in light up?

I'd like to see the dmesg log for the complete suspend/resume cycle 
(naturally you'll have to resume the system by hand after plugging in 
the USB device).  Make sure that CONFIG_USB_DEBUG is enabled.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

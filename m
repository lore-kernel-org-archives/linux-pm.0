From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 11 Apr 2012 17:15:29 -0400
Message-ID: <1334178929.23924.309.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204111324100.1351-100000@iolanthe.rowland.org>
	 <Pine.LNX.4.44L0.1204111429510.1351-100000@iolanthe.rowland.org>
	 <20120411205204.GB3677@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120411205204.GB3677-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-04-12 at 02:52 +0600, Andrey Rahmatullin wrote:
> On Wed, Apr 11, 2012 at 03:12:13PM -0400, Alan Stern wrote:
> > You can try getting rid of the call to pci_prepare_to_sleep in 
> > drivers/usb/core/hcd-pci.c:hcd_pci_suspend_noirq.  This will prevent 
> > the controller from being put into D3hot and might interfere with 
> > wakeup detection.
> > 
> > I don't know how sigificant the difference is between
> > pci_disable_device and pci_disable_enabled_device.  Probably not very, 
> > since all it involves is whether or not to disable bus-mastering on the 
> > controller.
> I replaced the hcd_pci_suspend_noirq call with retval=0 and suspend/resume
> was successful.
> 

I just did the update and it was successful for me as well.

Seems there's some kind of issue with the hcd_pci_suspend_noirq() call.

Thanks!


-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

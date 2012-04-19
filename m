From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 12:22:55 -0400
Message-ID: <1334852575.28106.62.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204190934500.2070-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204190934500.2070-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-04-19 at 09:43 -0400, Alan Stern wrote:
> On Wed, 18 Apr 2012, Alan Stern wrote:
> 
> > Tomorrow we can try to figure out the appropriate workaround.
> 
> Below is a patch that will prevent any PCI device from being put into
> D3 during suspend.  (This is meant to be used without any of the
> earlier diagnostic patches.)  Obviously it's not the final solution; 
> the test in the "if" statement needs to be more discriminating.  :-)
> 
> But before going any farther, I'd like to test if USB wakeup works.  
> So after booting with this patch, make sure that the power/wakeup file
> says "enabled" in the sysfs path for each controller as well as the
> usb1, usb2, 1-2, and 2-2 paths under /sys/bus/usb/devices/.
> 
> Then suspend the computer without using the script, and while it is
> asleep try plugging in a new USB device.  That should cause the
> computer to wake up, if everything is working properly.
> 

I removed all previous patches and added this one. But without the
script, it locks up again in suspend.

I'll rebuild again just to make sure I didn't screw something up.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

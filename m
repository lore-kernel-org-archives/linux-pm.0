From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 10:10:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204131008010.1185-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1204122103230.10558-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204122103230.10558-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Apr 2012, Alan Stern wrote:

> Tomorrow I'll look through the code more carefully; with those changes
> there really is very little difference between the two cases.  Things
> like mmio mappings and IRQs requested; they shouldn't cause a crash.

Let's start with some basic information.  First, before suspending,
what shows up in /sys/kernel/debug/usb/devices?

Second, if you do

	echo 0 >/sys/bus/usb/devices/usb1/bConfigurationValue
	echo 0 >/sys/bus/usb/devices/usb2/bConfigurationValue

before suspending (using a vanilla kernel and no script), does it 
change the behavior?  I expect it won't, but we should check just to be 
thorough.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

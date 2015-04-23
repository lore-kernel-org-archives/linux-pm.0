From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: default value of power/wakeup
Date: Thu, 23 Apr 2015 10:40:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504231039180.1529-100000@iolanthe.rowland.org>
References: <CAGnHSEnPCL3PgA9-L5ECD=7WW3ykYrd-cDUXcT1dd-zE9WwXcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGnHSEnPCL3PgA9-L5ECD=7WW3ykYrd-cDUXcT1dd-zE9WwXcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Chen <Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 23 Apr 2015, Tom Yan wrote:

> I'm not saying that the kernel shouldn't initialize the attributes or
> have a default. But it should only set the default when the attribute
> is initialized (It doesn't even matter to me whether it's enabled or
> disabled).
> 
> It's just there should not be further manipulation from the kernel
> (e.g. device_set_wakeup_enable) afterwards because
> 1. it's brings inconsistency because the function is adopted per driver
> 2. it's a user preference and responsibilty
> 3. third it prevent udev to apply a rule properly (regression / bug)
> 
> P.S. Alan for my case, I don't need a patch for logitech-dj, I just
> need to remove device_set_enable_wakeup from hid_core.c, then I can
> enable or disable the attribute with a udev rule happily for both
> devices.

I understand that.  But removing device_set_enable_wakeup from
hid_core.c would annoy a lot of people.  Linus would probably decide
that it was a regression and would put the function call back in.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

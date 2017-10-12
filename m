From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] USB: Force disconnect Huawei 4G modem during suspend
Date: Thu, 12 Oct 2017 10:14:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1710121002520.1362-100000@iolanthe.rowland.org>
References: <CAD8Lp47KttKsevohjpAVeS_u77WqZd+rUZk4uwt=VV_SzRW-rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD8Lp47KttKsevohjpAVeS_u77WqZd+rUZk4uwt=VV_SzRW-rg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Oct 2017, Daniel Drake wrote:

> On Wed, Oct 11, 2017 at 11:04 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> > Also, you should check whether this is for a runtime suspend or a
> > system suspend.  You don't want to go around disconnecting a device
> > whenever it gets runtime suspended!
> 
> Good point, I had not considered runtime suspend. It's not quite so
> simple though.
> 
> I make your suggested change (testing PMSG_IS_AUTO in this codepath),
> then enable autosuspend with:
>  echo auto > /sys/bus/usb/devices/1-9/power/control
> 
> then the device gets suspended (no interface drivers are loaded)
> without the port disconnect happening.
> 
> Now if I go into S3 suspend, the original problem returns: the system
> wakes up immediately.

Nasty!

> So that is an imperfection with this approach. Any suggestions for how
> to proceed?

How about moving the test into usb_suspend() in driver.c?  If the quirk 
flag is set at that point, call hub_port_disable().  You'll have to add 
a glue routine to hub.c for this purpose.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE# signal for OF
Date: Fri, 05 Jan 2018 02:13:33 +0100
Message-ID: <2806186.IK6EZBC0cX@aspire.rjw.lan>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com> <5491520.JsEYlZiECc@aspire.rjw.lan> <20180105004130.GA151625@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180105004130.GA151625-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Friday, January 5, 2018 1:41:31 AM CET Brian Norris wrote:
> Hi,
> 
> Trying to catch up on this thread...
> 
> On Wed, Dec 27, 2017 at 01:57:07AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, December 26, 2017 2:06:47 AM CET JeffyChen wrote:
> > > Hi Rafael,
> > > 
> > > Thanks for your reply :)
> > > 
> > > On 12/26/2017 08:11 AM, Rafael J. Wysocki wrote:
> > > >> >+
> > > >> >+	dn = pci_device_to_OF_node(ppdev);
> > > >> >+	if (!dn)
> > > >> >+		return 0;
> > > >> >+
> > > >> >+	irq = of_irq_get_byname(dn, "wakeup");
> > > > Why is this a property of the bridge and not of the device itself?
> 
> Wait, isn't 'dn' the port node, not the bridge node?

I may be confused about the structure you have in DT.

In the device hierarchy PCIe ports are represented as bridges.

> > > That is suggested by Brian, because in that way, the wakeup pin would 
> > > not "tied to what exact device is installed (or no device, if it's a slot)."
> 
> I believe my thinking has evolved a bit over time, and I definitely am
> not the one true authority on this. I'll explain my main concerns, and
> whatever solution resolves these concerns is fine with me.
> 
> * I was primarily interested in avoiding handling WAKE# in the endpoint
>   drivers (e.g., as mwifiex is today).

OK, everybody on this thread is interested in that. :-)

> * I was also interested in not having to redefine a new DT device
>   node (with new "pciABCD,1234" compatible property) for each new device
>   attached. That just won't work for removable cards.

So if you make it the property of a bridge, it should be fine (as long
as the bridge itself is not removable).

> I need to reread the rest of this thread a few times to really
> understand what Rafael and Tony are discussing. But I feel like some of
> this is still moving away from the second point above.
> 
> > But I don't think it works when there are two devices using different WAKE#
> > interrupt lines under the same bridge.  Or how does it work then?

We seem to have agreed that this case needs to be neglected here.

The "wakeup-interrupt" property at the bridge level basically has to be defined
as the wakeup interrupt for all devices on the bus under the bridge.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

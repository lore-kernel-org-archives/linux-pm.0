From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v13 06/12] usb: xhci: use bus->sysdev for DMA
 configuration
Date: Thu, 16 Feb 2017 09:23:07 +0800
Message-ID: <20170216012307.GA30290@b29397-desktop>
References: <1486776443-2280-7-git-send-email-peter.chen@nxp.com>
 <e532a212-cd15-ab42-6188-fc11a12633af@ti.com>
 <CAK8P3a1D1v=LXrW=-t-fRJjbo_C6OpSuoqiGuZPOaBzQYCT-kA@mail.gmail.com>
 <cb7182c6-0236-26f2-4f96-9bc001994728@ti.com>
 <CAK8P3a22f=sQXt+3-PeAuBFQN7_4iXDQhu41teExd6bxJXxDAQ@mail.gmail.com>
 <20170215013514.GA6579@b29397-desktop>
 <cb3ee971-6d97-fff1-64f7-1b527559b047@ti.com>
 <20170215085127.GA26227@b29397-desktop>
 <2a3d2d65-e531-aaca-d5a1-a71f818cec61@ti.com>
 <87mvdnoenw.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87mvdnoenw.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sriram Dash <sriram.dash-3arQi8VN3Tc@public.gmane.org>, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, Rob
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 15, 2017 at 01:51:31PM +0200, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> >>>>>>>> Why are we using sysdev to read DT property? We should be using the
> >>>>>>>> XHCI device (&pdev->dev) here, no?
> >>>>>>>
> >>>>>>> If I remember correctly, this is one of the cases where pdev does not
> >>>>>>> have a device node attached to it because it was created by the driver
> >>>>>>> of the parent device on the fly in case of dwc3. When you have a pure xhci
> >>>>>>> device in DT, the two pointers are the same.
> >>>>>>
> >>>>>> From drivers/usb/dwc3/host.c
> >>>>>>
> >>>>>>>         if (dwc->usb3_lpm_capable) {
> >>>>>>>                 props[0].name = "usb3-lpm-capable";
> >>>>>>>                 ret = platform_device_add_properties(xhci, props);
> >>>>>>>                 if (ret) {
> >>>>>>>                         dev_err(dwc->dev, "failed to add properties to xHCI\n");
> >>>>>>>                         goto err1;
> >>>>>>>                 }
> >>>>>>>         }
> >>>>>>
> >>>>>> So it is setting the usb3-lpm-capable property into the xhci platform device
> >>>>>> and we should be reading the property from there.
> >>>>
> >>>> Why dwc3 needs another "snps,usb3_lpm_capable"? Why not using
> >>>> "usb3-lpm-capable" at firmware directly?
> >>>
> >>> dwc3 is not setting "snps,usb3_lpm_capable" but "usb3-lpm-capable" for the
> >>> xhci platform device.
> >>>
> >>> What did you mean by firmware? Did you mean something like BIOS?
> >>> At least TI platforms don't use any firmware like BIOS. So dwc3 driver
> >>> needs to create a platform device for xhci on the fly and set the DT properties.
> >>>
> >> 
> >> By readying code, the dwc3 calls dwc3_get_properties to set
> >> dwc->usb3_lpm_capable, and at dwc3/host.c, it sets property
> >> "usb3-lpm-capable" according to this flag, why not let common
> >> code xhci-plat.c to get this property from sysdev which is DT
> >> nodes for dwc3?
> >> 
> >
> > Felipe, any comments?
> 
> Won't work. We have quirk flags which are based on DWC3's revision which
> is not accessible by xhci-plat. Also, we can't call
> device_add_property() because it's not really *adding*. It's *setting*,
> meaning that we would loose all other properties.
> 

Sorry, I am not clear by reading the code, here we just discuss
"usb3-lpm-capable" property from DT or other firmwares.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

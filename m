From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v12 6/9] usb: xhci: use bus->sysdev for DMA configuration
Date: Thu, 9 Feb 2017 09:41:13 +0800
Message-ID: <20170209014113.GB460@b29397-desktop>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
 <1486372421-29073-7-git-send-email-peter.chen@nxp.com>
 <20170208204300.GC8068@usblab-sd-06.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170208204300.GC8068-NjF/qFWh7jSrUKQWM4GlyCPyLMyjRtWwAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jack Pham <jackp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgSriram Dash <sr>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 08, 2017 at 12:43:00PM -0800, Jack Pham wrote:
> Hi Peter, Sriram, Arnd,
> 
> On Mon, Feb 06, 2017 at 05:13:38PM +0800, Peter Chen wrote:
> > From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> > 
> > For xhci-hcd platform device, all the DMA parameters are not
> > configured properly, notably dma ops for dwc3 devices. So, set
> > the dma for xhci from sysdev. sysdev is pointing to device that
> > is known to the system firmware or hardware.
> > 
> > Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> > Signed-off-by: Sriram Dash <sriram.dash-3arQi8VN3Tc@public.gmane.org>
> > Tested-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Tested-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > Tested-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 6d33b42..7a9c860 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> 
> > -	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
> > +	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
> > +			       dev_name(&pdev->dev), NULL);
> 
> As mentioned already in [1], usb_create_shared_hcd() is called to create
> the second bus, however it also needs to be converted.
> 
> Not exactly as Roger's suggestion but this worked for me:
> 
> -       xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
> +       xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>                         dev_name(&pdev->dev), hcd);
>         if (!xhci->shared_hcd) {
>                 ret = -ENOMEM;
> 
> Without this, SuperSpeed devices fail to enumerate:
> 
>  usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
>  usb 2-1: device descriptor read/8, error -11
>  usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
>  usb 2-1: device descriptor read/8, error -11
>  usb 2-1: new SuperSpeed USB device number 3 using xhci-hcd
>  usb 2-1: device descriptor read/8, error -11
>  usb 2-1: new SuperSpeed USB device number 3 using xhci-hcd
>  usb 2-1: device descriptor read/8, error -11
>  <and continues...>
> 
> Thanks,
> Jack
> 

Do you work at same platform with Vivek Gautam? I see his tested-by
tag in this patch.

I have no dwc3 platform to test, I only got patches from [1], and rebase to
Greg's usb-next, the rebase has a conflict, and I made a 
change which is similar to revert below patch, but it is definitely
not your problem.

commit 488dc164914ff5ce5e913abd32048d28fc0d06b8
Author: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date:   Fri Jan 20 15:38:24 2017 +0200

    xhci: remove WARN_ON if dma mask is not set for platform devices


[1] http://www.spinics.net/lists/linux-usb/msg152375.html

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

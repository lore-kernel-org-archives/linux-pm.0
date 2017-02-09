From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v12 6/9] usb: xhci: use bus->sysdev for DMA configuration
Date: Thu, 9 Feb 2017 11:45:35 +0530
Message-ID: <CAFp+6iGCcTsELQQJ2n9MyS3S-3FWjTvSOEXGX3xpWwqH+7uSYQ@mail.gmail.com>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
 <1486372421-29073-7-git-send-email-peter.chen@nxp.com> <20170208204300.GC8068@usblab-sd-06.qualcomm.com>
 <20170209014113.GB460@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170209014113.GB460@b29397-desktop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jack Pham <jackp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam@gmai
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 9, 2017 at 7:11 AM, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Feb 08, 2017 at 12:43:00PM -0800, Jack Pham wrote:
>> Hi Peter, Sriram, Arnd,
>>
>> On Mon, Feb 06, 2017 at 05:13:38PM +0800, Peter Chen wrote:
>> > From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> >
>> > For xhci-hcd platform device, all the DMA parameters are not
>> > configured properly, notably dma ops for dwc3 devices. So, set
>> > the dma for xhci from sysdev. sysdev is pointing to device that
>> > is known to the system firmware or hardware.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> > Signed-off-by: Sriram Dash <sriram.dash-3arQi8VN3Tc@public.gmane.org>
>> > Tested-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> > Tested-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> > Tested-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> > Signed-off-by: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> > ---
>> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> > index 6d33b42..7a9c860 100644
>> > --- a/drivers/usb/host/xhci-plat.c
>> > +++ b/drivers/usb/host/xhci-plat.c
>>
>> > -   hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
>> > +   hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>> > +                          dev_name(&pdev->dev), NULL);
>>
>> As mentioned already in [1], usb_create_shared_hcd() is called to create
>> the second bus, however it also needs to be converted.
>>
>> Not exactly as Roger's suggestion but this worked for me:
>>
>> -       xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
>> +       xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>>                         dev_name(&pdev->dev), hcd);
>>         if (!xhci->shared_hcd) {
>>                 ret = -ENOMEM;
>>
>> Without this, SuperSpeed devices fail to enumerate:
>>
>>  usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
>>  usb 2-1: device descriptor read/8, error -11
>>  usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
>>  usb 2-1: device descriptor read/8, error -11
>>  usb 2-1: new SuperSpeed USB device number 3 using xhci-hcd
>>  usb 2-1: device descriptor read/8, error -11
>>  usb 2-1: new SuperSpeed USB device number 3 using xhci-hcd
>>  usb 2-1: device descriptor read/8, error -11
>>  <and continues...>
>>
>> Thanks,
>> Jack
>>
>
> Do you work at same platform with Vivek Gautam? I see his tested-by
> tag in this patch.

The patches [1] had worked for me on 4.9-rc4.
But with
(a) usb-next merged on 4.10-rc7
(b) this patch and [PATCH 3/9] in this series:
      [PATCH v12 3/9] usb: separate out sysdev pointer from usb_bus
and,
(c) phy patches for msm8996 [2] along with necessary device tree patches
I get a hang when SuperSpeed device is being enumerated on db820c.

The change above suggested by Jack works for me too, and i hope that's
the right way to do things.

I can give a Tested-by again with the changes for shared_hcd in the
next version.

[1] https://lkml.org/lkml/2016/11/17/339
[2] https://lkml.org/lkml/2017/1/10/225

>
> I have no dwc3 platform to test, I only got patches from [1], and rebase to
> Greg's usb-next, the rebase has a conflict, and I made a
> change which is similar to revert below patch, but it is definitely
> not your problem.
>
> commit 488dc164914ff5ce5e913abd32048d28fc0d06b8
> Author: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date:   Fri Jan 20 15:38:24 2017 +0200
>
>     xhci: remove WARN_ON if dma mask is not set for platform devices
>
>
> [1] http://www.spinics.net/lists/linux-usb/msg152375.html
>
> --
>
> Best Regards,
> Peter Chen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v12 6/9] usb: xhci: use bus->sysdev for DMA configuration
Date: Thu, 9 Feb 2017 17:38:25 +0530
Message-ID: <CAFp+6iFrE8oz2By9KR1n51OZZxZ05gStu03bMgD4zVbLXZ5ppQ@mail.gmail.com>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
 <1486372421-29073-7-git-send-email-peter.chen@nxp.com> <20170208204300.GC8068@usblab-sd-06.qualcomm.com>
 <85873d69-5664-0603-8cbd-a250d29ac335@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdBIMIj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2017 07:08:39 -0500
In-Reply-To: <85873d69-5664-0603-8cbd-a250d29ac335@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Jack Pham <jackp@codeaurora.org>, Peter Chen <peter.chen@nxp.com>, Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, broonie@kernel.org, sre@kernel.org, robh+dt <robh+dt@kernel.org>, shawnguo@kernel.org, rjw@rjwysocki.net, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, p.zabel@pengutronix.de, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundary

On Thu, Feb 9, 2017 at 5:23 PM, Roger Quadros <rogerq@ti.com> wrote:
>
>
> On 08/02/17 22:43, Jack Pham wrote:
>> Hi Peter, Sriram, Arnd,
>>
>> On Mon, Feb 06, 2017 at 05:13:38PM +0800, Peter Chen wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> For xhci-hcd platform device, all the DMA parameters are not
>>> configured properly, notably dma ops for dwc3 devices. So, set
>>> the dma for xhci from sysdev. sysdev is pointing to device that
>>> is known to the system firmware or hardware.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
>>> Tested-by: Baolin Wang <baolin.wang@linaro.org>
>>> Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>> ---
>>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>>> index 6d33b42..7a9c860 100644
>>> --- a/drivers/usb/host/xhci-plat.c
>>> +++ b/drivers/usb/host/xhci-plat.c
>>
>>> -    hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
>>> +    hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>>> +                           dev_name(&pdev->dev), NULL);
>>
>> As mentioned already in [1], usb_create_shared_hcd() is called to create
>> the second bus, however it also needs to be converted.
>>
>> Not exactly as Roger's suggestion but this worked for me:
>>
>> -       xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
>> +       xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>>                         dev_name(&pdev->dev), hcd);
>
> But we're creating a shared_hcd and there is an API for that so why not use it
> instead of calling __usb_create_hcd()?

Do we not want to pass on the DMA configuration from sysdev to
shared_hcd as well?

>
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
>> [1] https://lkml.org/lkml/2016/12/9/240
>>
>
> --
> cheers,
> -roger
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

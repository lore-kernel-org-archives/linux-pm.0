From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v13 06/12] usb: xhci: use bus->sysdev for DMA configuration
Date: Tue, 14 Feb 2017 13:58:40 +0100
Message-ID: <CAK8P3a22f=sQXt+3-PeAuBFQN7_4iXDQhu41teExd6bxJXxDAQ@mail.gmail.com>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
 <1486776443-2280-7-git-send-email-peter.chen@nxp.com> <e532a212-cd15-ab42-6188-fc11a12633af@ti.com>
 <CAK8P3a1D1v=LXrW=-t-fRJjbo_C6OpSuoqiGuZPOaBzQYCT-kA@mail.gmail.com> <cb7182c6-0236-26f2-4f96-9bc001994728@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34684 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbdBNM6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2017 07:58:42 -0500
In-Reply-To: <cb7182c6-0236-26f2-4f96-9bc001994728@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, sre@kernel.org, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, rjw@rjwysocki.net, dbaryshkov@gmail.com, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, stephen.boyd@linaro.org, frank.li@nxp.com, gary.bisson@boundarydevices.com, Vivek Gautam <vivek.gautam@codeaurora.org>, Sriram Dash <sriram.dash@nxp.com>, festevam@gmail.com, stillcompiling@gmail.com, vaibhav.hiremath@linaro.org, Krzysztof Kozlowski <krzk@kernel.org>, mka@chromium.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de

On Tue, Feb 14, 2017 at 1:26 PM, Roger Quadros <rogerq@ti.com> wrote:
> On 14/02/17 13:44, Arnd Bergmann wrote:
>> On Tue, Feb 14, 2017 at 11:36 AM, Roger Quadros <rogerq@ti.com> wrote:

>>> Why are we using sysdev to read DT property? We should be using the
>>> XHCI device (&pdev->dev) here, no?
>>
>> If I remember correctly, this is one of the cases where pdev does not
>> have a device node attached to it because it was created by the driver
>> of the parent device on the fly in case of dwc3. When you have a pure xhci
>> device in DT, the two pointers are the same.
>
> From drivers/usb/dwc3/host.c
>
>>         if (dwc->usb3_lpm_capable) {
>>                 props[0].name = "usb3-lpm-capable";
>>                 ret = platform_device_add_properties(xhci, props);
>>                 if (ret) {
>>                         dev_err(dwc->dev, "failed to add properties to xHCI\n");
>>                         goto err1;
>>                 }
>>         }
>
> So it is setting the usb3-lpm-capable property into the xhci platform device
> and we should be reading the property from there.

Hmm, ideally we would only have properties on one of the two, since we
refer to the sysdev for the properties regarding DMA and PHY among other
things, but I guess that's not an option here, since we can't call
platform_device_add_properties() on a dwc_pci device and have to
use the xhci pdev instead.

     Arnd

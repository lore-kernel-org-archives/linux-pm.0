From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v13 06/12] usb: xhci: use bus->sysdev for DMA configuration
Date: Tue, 14 Feb 2017 14:26:49 +0200
Message-ID: <cb7182c6-0236-26f2-4f96-9bc001994728@ti.com>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
 <1486776443-2280-7-git-send-email-peter.chen@nxp.com>
 <e532a212-cd15-ab42-6188-fc11a12633af@ti.com>
 <CAK8P3a1D1v=LXrW=-t-fRJjbo_C6OpSuoqiGuZPOaBzQYCT-kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a1D1v=LXrW=-t-fRJjbo_C6OpSuoqiGuZPOaBzQYCT-kA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, stephen.boyd@linaro.org, frank.li@nxp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gary.bisson@boundarydevices.com, Vivek Gautam <vivek.gautam@codeaurora.org>, Sriram Dash <sriram.dash@nxp.com>, festevam@gmail.com, stillcompiling@gmail.com, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, Krzysztof Kozlowski <krzk@kernel.org>, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, Rob Herring <robh+dt@kernel.org>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, oscar@naiandei.net, Linux ARM <linux-arm-kernel@lists.infradead.org>, hverkuil@xs4all.nl, Mathias
List-Id: linux-pm@vger.kernel.org

On 14/02/17 13:44, Arnd Bergmann wrote:
> On Tue, Feb 14, 2017 at 11:36 AM, Roger Quadros <rogerq@ti.com> wrote:
>> On 11/02/17 03:27, Peter Chen wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> For xhci-hcd platform device, all the DMA parameters are not
>>> configured properly, notably dma ops for dwc3 devices. So, set
>>> the dma for xhci from sysdev. sysdev is pointing to device that
>>> is known to the system firmware or hardware.
>>>
>>> Cc: Baolin Wang <baolin.wang@linaro.org>
>>> Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>>> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
>>> ---
>>> Hi, Baolin, Vivek and Alexander,
>>> I removed your tested-by tag due to add one change that adding sysdev
>>> for shared hcd too, if your test shows this change works for you or
>>> has no effect for you, please consider adding tested-by tag again,
>>> thanks.
> 
>>> @@ -222,20 +241,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>>
>>>       xhci->clk = clk;
>>>       xhci->main_hcd = hcd;
>>> -     xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
>>> +     xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>>>                       dev_name(&pdev->dev), hcd);
>>>       if (!xhci->shared_hcd) {
>>>               ret = -ENOMEM;
>>>               goto disable_clk;
>>>       }
>>>
>>> -     if (device_property_read_bool(&pdev->dev, "usb3-lpm-capable"))
>>> +     if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
>>
>> Why are we using sysdev to read DT property? We should be using the
>> XHCI device (&pdev->dev) here, no?
> 
> If I remember correctly, this is one of the cases where pdev does not
> have a device node attached to it because it was created by the driver
> of the parent device on the fly in case of dwc3. When you have a pure xhci
> device in DT, the two pointers are the same.

>From drivers/usb/dwc3/host.c

>         if (dwc->usb3_lpm_capable) {
>                 props[0].name = "usb3-lpm-capable";
>                 ret = platform_device_add_properties(xhci, props);
>                 if (ret) {
>                         dev_err(dwc->dev, "failed to add properties to xHCI\n");
>                         goto err1;
>                 }
>         }

So it is setting the usb3-lpm-capable property into the xhci platform device
and we should be reading the property from there.

-- 
cheers,
-roger

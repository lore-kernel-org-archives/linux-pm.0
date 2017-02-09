From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v12 6/9] usb: xhci: use bus->sysdev for DMA configuration
Date: Thu, 9 Feb 2017 13:54:58 +0200
Message-ID: <6f131f15-d2f0-c8ac-c6af-accd23afab62@ti.com>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
 <1486372421-29073-7-git-send-email-peter.chen@nxp.com>
 <20170208204300.GC8068@usblab-sd-06.qualcomm.com>
 <85873d69-5664-0603-8cbd-a250d29ac335@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <85873d69-5664-0603-8cbd-a250d29ac335@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jack Pham <jackp@codeaurora.org>, Peter Chen <peter.chen@nxp.com>
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, heiko@sntech.de, stephen.boyd@linaro.org, linux-kernel@vger.kernel.org, gary.bisson@boundarydevices.com, Sriram Dash <sriram.dash@nxp.com>, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, rjw@rjwysocki.net, sre@kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org



On 09/02/17 13:53, Roger Quadros wrote:
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
>>> -	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
>>> +	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>>> +			       dev_name(&pdev->dev), NULL);
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
> 

Just realized after I pressed send that there is no sysdev parameter
for create_shared_hcd().

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

-- 
cheers,
-roger

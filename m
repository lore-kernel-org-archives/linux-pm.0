From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v12 6/9] usb: xhci: use bus->sysdev for DMA configuration
Date: Fri, 10 Feb 2017 09:40:11 +0800
Message-ID: <20170210014011.GB1334@b29397-desktop>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
 <1486372421-29073-7-git-send-email-peter.chen@nxp.com>
 <20170208204300.GC8068@usblab-sd-06.qualcomm.com>
 <85873d69-5664-0603-8cbd-a250d29ac335@ti.com>
 <6f131f15-d2f0-c8ac-c6af-accd23afab62@ti.com>
 <CAFp+6iHQb9hUow99+vJ9TWYfZBFLd+ZAeqeRqMN-U_y=g9sRGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAFp+6iHQb9hUow99+vJ9TWYfZBFLd+ZAeqeRqMN-U_y=g9sRGQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Stephen Boyd <stephen.boyd@linaro.org>, Jack Pham <jackp@codeaurora.org>, sre@kernel.org, Gary Bisson <gary.bisson@boundarydevices.com>, Sriram Dash <sriram.dash@nxp.com>, Fabio Estevam <festevam@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, krzk@kernel.org, mka@chromium.org, Alan Stern <stern@rowland.harvard.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, mail@maciej.szmigiero.name, Pawel Moll <pawel.moll@arm.com>, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt <robh+dt@kernel.org>, oscar@naiandei.net, linux-arm-kerne
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 09, 2017 at 05:40:50PM +0530, Vivek Gautam wrote:
> On Thu, Feb 9, 2017 at 5:24 PM, Roger Quadros <rogerq@ti.com> wrote:
> >
> >
> > On 09/02/17 13:53, Roger Quadros wrote:
> >>
> >>
> >> On 08/02/17 22:43, Jack Pham wrote:
> >>> Hi Peter, Sriram, Arnd,
> >>>
> >>> On Mon, Feb 06, 2017 at 05:13:38PM +0800, Peter Chen wrote:
> >>>> From: Arnd Bergmann <arnd@arndb.de>
> >>>>
> >>>> For xhci-hcd platform device, all the DMA parameters are not
> >>>> configured properly, notably dma ops for dwc3 devices. So, set
> >>>> the dma for xhci from sysdev. sysdev is pointing to device that
> >>>> is known to the system firmware or hardware.
> >>>>
> >>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>>> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> >>>> Tested-by: Baolin Wang <baolin.wang@linaro.org>
> >>>> Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >>>> Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> >>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> >>>> ---
> >>>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> >>>> index 6d33b42..7a9c860 100644
> >>>> --- a/drivers/usb/host/xhci-plat.c
> >>>> +++ b/drivers/usb/host/xhci-plat.c
> >>>
> >>>> -   hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
> >>>> +   hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
> >>>> +                          dev_name(&pdev->dev), NULL);
> >>>
> >>> As mentioned already in [1], usb_create_shared_hcd() is called to create
> >>> the second bus, however it also needs to be converted.
> >>>
> >>> Not exactly as Roger's suggestion but this worked for me:
> >>>
> >>> -       xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
> >>> +       xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
> >>>                         dev_name(&pdev->dev), hcd);
> >>
> >> But we're creating a shared_hcd and there is an API for that so why not use it
> >> instead of calling __usb_create_hcd()?
> >>
> >
> > Just realized after I pressed send that there is no sysdev parameter
> > for create_shared_hcd().

Roger, does this change also work for you? If it is, please add a
tested-by tag for my v13 patch set.

-- 

Best Regards,
Peter Chen

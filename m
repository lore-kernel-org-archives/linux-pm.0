From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v13 06/12] usb: xhci: use bus->sysdev for DMA
 configuration
Date: Wed, 15 Feb 2017 09:35:14 +0800
Message-ID: <20170215013514.GA6579@b29397-desktop>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
 <1486776443-2280-7-git-send-email-peter.chen@nxp.com>
 <e532a212-cd15-ab42-6188-fc11a12633af@ti.com>
 <CAK8P3a1D1v=LXrW=-t-fRJjbo_C6OpSuoqiGuZPOaBzQYCT-kA@mail.gmail.com>
 <cb7182c6-0236-26f2-4f96-9bc001994728@ti.com>
 <CAK8P3a22f=sQXt+3-PeAuBFQN7_4iXDQhu41teExd6bxJXxDAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a22f=sQXt+3-PeAuBFQN7_4iXDQhu41teExd6bxJXxDAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Roger Quadros <rogerq@ti.com>, Mark Rutland <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, stephen.boyd@linaro.org, frank.li@nxp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gary.bisson@boundarydevices.com, Vivek Gautam <vivek.gautam@codeaurora.org>, Sriram Dash <sriram.dash@nxp.com>, festevam@gmail.com, stillcompiling@gmail.com, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, Krzysztof Kozlowski <krzk@kernel.org>, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, Rob Herring <robh+dt@kernel.org>, Alexander
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 14, 2017 at 01:58:40PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 14, 2017 at 1:26 PM, Roger Quadros <rogerq@ti.com> wrote:
> > On 14/02/17 13:44, Arnd Bergmann wrote:
> >> On Tue, Feb 14, 2017 at 11:36 AM, Roger Quadros <rogerq@ti.com> wrote:
> 
> >>> Why are we using sysdev to read DT property? We should be using the
> >>> XHCI device (&pdev->dev) here, no?
> >>
> >> If I remember correctly, this is one of the cases where pdev does not
> >> have a device node attached to it because it was created by the driver
> >> of the parent device on the fly in case of dwc3. When you have a pure xhci
> >> device in DT, the two pointers are the same.
> >
> > From drivers/usb/dwc3/host.c
> >
> >>         if (dwc->usb3_lpm_capable) {
> >>                 props[0].name = "usb3-lpm-capable";
> >>                 ret = platform_device_add_properties(xhci, props);
> >>                 if (ret) {
> >>                         dev_err(dwc->dev, "failed to add properties to xHCI\n");
> >>                         goto err1;
> >>                 }
> >>         }
> >
> > So it is setting the usb3-lpm-capable property into the xhci platform device
> > and we should be reading the property from there.

Why dwc3 needs another "snps,usb3_lpm_capable"? Why not using
"usb3-lpm-capable" at firmware directly?

Peter

> 
> Hmm, ideally we would only have properties on one of the two, since we
> refer to the sysdev for the properties regarding DMA and PHY among other
> things, but I guess that's not an option here, since we can't call
> platform_device_add_properties() on a dwc_pci device and have to
> use the xhci pdev instead.
> 
>      Arnd
> 
-- 

Best Regards,
Peter Chen

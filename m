From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 9 Nov 2016 09:33:16 +0800
Message-ID: <20161109013316.GA27425@b29397-desktop>
References: <cover.1476780088.git.baolin.wang@linaro.org>
 <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
 <87k2cttptn.fsf@notabene.neil.brown.name>
 <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
 <87a8dls7yn.fsf@notabene.neil.brown.name>
 <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com>
 <871sytqrqh.fsf@notabene.neil.brown.name>
 <20161108084133.GA12276@b29397-desktop>
 <87vavxn1v7.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87vavxn1v7.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 09, 2016 at 07:38:36AM +1100, NeilBrown wrote:
> On Tue, Nov 08 2016, Peter Chen wrote:
> 
> > On Thu, Nov 03, 2016 at 12:25:42PM +1100, NeilBrown wrote:
> >> 
> >> 
> >> 
> >> 2/ Change all usb phys to register an extcon and to send appropriate
> >>    notifications.  Many already do, but I don't think it is universal.
> >>    It is probable that the extcon should be registered using common code
> >>    instead of each phy driver having its own
> >>    extcon_get_edev_by_phandle()
> >>    or whatever.
> >>    If the usb phy driver needs to look at battery charger registers to
> >>    know what sort of cable was connected (which I believe is the case
> >>    for the chips you are interested in), then it should do that.
> >
> > Not only USB PHY to register an extcon, but also for the drivers which
> > can detect USB charger type, it may be USB controller driver, USB type-c
> > driver, pmic driver, and these drivers may not have an extcon device
> > since the internal part can finish the vbus detect.
> 
> Can you point to an example of the sort of hardware/driver you are
> referring to, preferably in the mainline kernel.  Concrete examples make
> this sort of thing much easier to understand.
> 

Eg, the nxp/fsl USB charger detector part, the register used to begin
the detection is in USB controller register region, and we also need to
use controller register to pull up dp to begin the secondary detect.

Since there is no USB charger framework, the code is not in mainline.
It finished an upstream version based on patch set in this thread [1]

Some SoCs uses chipidea IP doesn't need to use extcon to detect plugging
in/out, since the vbus pin connects to SoC's vbus pin.

The pmic has abilities to charger detection, eg, drivers/mfd/axp20x.c
and drivers/extcon/extcon-axp288.c.

> I think I would argue that if some piece of hardware can detect the USB
> charger type, then that piece of hardware is part of the "USB PHY", even
> if the hardware manufacturer has chosen to partition the register set in
> a way which doesn't make that obvious.

I agree with that the charger detect hardware is in the USB PHY part,
but some USB PHY's control is integrated in USB controller (eg, some
controller uses drivers/usb/phy/phy-generic.c as its PHY driver), so
we have to use controller register to finish some PHY function, eg
charger detection.

[1] https://www.spinics.net/lists/linux-usb/msg139425.html

-- 

Best Regards,
Peter Chen

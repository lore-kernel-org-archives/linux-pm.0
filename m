From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 8 Nov 2016 16:41:33 +0800
Message-ID: <20161108084133.GA12276@b29397-desktop>
References: <cover.1476780088.git.baolin.wang@linaro.org>
 <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
 <87k2cttptn.fsf@notabene.neil.brown.name>
 <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
 <87a8dls7yn.fsf@notabene.neil.brown.name>
 <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com>
 <871sytqrqh.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34506 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbcKHI7e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 03:59:34 -0500
Content-Disposition: inline
In-Reply-To: <871sytqrqh.fsf@notabene.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel>

On Thu, Nov 03, 2016 at 12:25:42PM +1100, NeilBrown wrote:
> On Tue, Nov 01 2016, Baolin Wang wrote:
> 
> 
> >> So I won't be responding on this topic any further until I see a genuine
> >> attempt to understand and resolve the inconsistencies with
> >> usb_register_notifier().
> >
> > Any better solution?
> 
> I'm not sure exactly what you are asking, so I'll assume you are asking
> the question I want to answer :-)
> 
> 1/ Liase with the extcon developers to resolve the inconsistencies
>   with USB connector types.
>   e.g. current there is both "EXTCON_USB" and "EXTCON_CHG_USB_SDP"
>   which both seem to suggest a standard downstream port.  There is no
>   documentation describing how these relate, and no consistent practice
>   to copy.
>   I suspect the intention is that
>     EXTCON_USB and EXTCON_USB_HOST indicated that data capabilities of
>     the cable, while EXTCON_CHG_USB* indicate the power capabilities of
>     the cable. 
>     So EXTCON_CHG_USB_SDP should always appear together with EXTCON_USB
>     while EXTCON_CHG_USB_DCP would not, and EXTCON_CHG_USB_ACA
>     would normally appear with EXTCON_USB_HOST (I think).
>   Some drivers follow this model, particularly extcon-max14577.c
>   but it is not consistent.
> 
>   This policy should be well documented and possibly existing drivers
>   should be updated to follow it.
> 
>   At the same time it would make sense to resolve EXTCON_CHG_USB_SLOW
>   and EXTCON_CHG_USB_FAST.  These names don't mean much.
>   They were recently removed from drivers/power/axp288_charger.c
>   which is good, but are still used in drivers/extcon/extcon-max*
>   Possibly they should be changed to names from the standard, or
>   possibly they should be renamed to identify the current they are
>   expected to provide. e.g. EXTCON_CHG_USB_500MA and EXTCON_CHG_USB_1A
> 
> 2/ Change all usb phys to register an extcon and to send appropriate
>    notifications.  Many already do, but I don't think it is universal.
>    It is probable that the extcon should be registered using common code
>    instead of each phy driver having its own
>    extcon_get_edev_by_phandle()
>    or whatever.
>    If the usb phy driver needs to look at battery charger registers to
>    know what sort of cable was connected (which I believe is the case
>    for the chips you are interested in), then it should do that.

Not only USB PHY to register an extcon, but also for the drivers which
can detect USB charger type, it may be USB controller driver, USB type-c
driver, pmic driver, and these drivers may not have an extcon device
since the internal part can finish the vbus detect.

-- 

Best Regards,
Peter Chen

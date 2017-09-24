From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH 0/7] AXP803 AC/Battery support
Date: Sun, 24 Sep 2017 15:36:47 +0100
Message-ID: <20170924153647.1d82e83c@archlinux>
References: <20170920151814.22461-1-icenowy@aosc.io>
        <20170921154621.0000328d@huawei.com>
        <CF74A2A9-B9F4-4413-975B-A0F4B24686A3@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbdIXOgw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 24 Sep 2017 10:36:52 -0400
In-Reply-To: <CF74A2A9-B9F4-4413-975B-A0F4B24686A3@aosc.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>
Cc: linux-arm-kernel@lists.infradead.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>

On Thu, 21 Sep 2017 23:20:11 +0800
Icenowy Zheng <icenowy@aosc.io> wrote:

> 于 2017年9月21日 GMT+08:00 下午10:46:21, Jonathan Cameron <Jonathan.Cameron@huawei.com> 写到:
> >On Wed, 20 Sep 2017 23:18:07 +0800
> >Icenowy Zheng <icenowy@aosc.io> wrote:
> >  
> >> The AXP803 PMIC, used by most Allwinner A64 boards, features 3 power  
> >inputs:  
> >> AC, USB and Battery.
> >> 
> >> This patchset adds support for the AC and Battery supplies, which is  
> >useful  
> >> for the boards from Pine64 (Pine64, SoPine w/ baseboard model A,  
> >Pinebook).  
> >> 
> >> The USB supply is not yet supported in this patchset because it's not
> >> present on Pine series boards.
> >> 
> >> In order to enable battery monitoring the ADC for battery is also  
> >enabled  
> >> for AXs.
> >> 
> >> In order to enable battery monitoring the ADC for battery is also  
> >enabled  
> >> for AXP803.  
> >
> >I'll go with the obvious question...
> >
> >Why an RFC rather than a standard patch submission? I'm not immediately
> >seeing what is controversial!  
> 
> Oh I am just not confident about this patchset,
> especially the IIO part.

It all looks fine to me.  I would imagine that, once everyone is
happy, this will go through the mfd tree, but Lee may have other ideas!

Jonathan
> 
> >
> >Jonathan
> >  
> >> 
> >> Icenowy Zheng (7):
> >>   dt-bindings: add compatibles for AXP803 Battery/USB power supplies
> >>   iio: adc: axp20x-adc: allow to skip ADC rate setup now
> >>   iio: adc: axp20x-adc: add support for AXP803
> >>   power: supply: axp20x-battery: support AXP803
> >>   mfd: axp20x: add cells for AXP803 ADC/AC Power/Battery
> >>   arm64: allwinner: a64: add power supply nodes in AXP803 DTSI
> >>   arm64: allwinner: a64: enable AC and Battery for Pine64
> >> 
> >>  .../bindings/power/supply/axp20x_battery.txt       |   1 +
> >>  .../bindings/power/supply/axp20x_usb_power.txt     |   1 +
> >>  arch/arm64/boot/dts/allwinner/axp803.dtsi          |  15 +++
> >>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   8 ++
> >>  drivers/iio/adc/axp20x_adc.c                       | 114  
> >++++++++++++++++++++-  
> >>  drivers/mfd/axp20x.c                               |  11 ++
> >>  drivers/power/supply/axp20x_battery.c              |  88  
> >++++++++++++++--  
> >>  7 files changed, 226 insertions(+), 12 deletions(-)
> >>   
> >
> >
> >_______________________________________________
> >linux-arm-kernel mailing list
> >linux-arm-kernel@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

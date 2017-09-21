From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [RFC PATCH 0/7] AXP803 AC/Battery support
Date: Thu, 21 Sep 2017 23:20:11 +0800
Message-ID: <CF74A2A9-B9F4-4413-975B-A0F4B24686A3@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io> <20170921154621.0000328d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170921154621.0000328d-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



于 2017年9月21日 GMT+08:00 下午10:46:21, Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> 写到:
>On Wed, 20 Sep 2017 23:18:07 +0800
>Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
>
>> The AXP803 PMIC, used by most Allwinner A64 boards, features 3 power
>inputs:
>> AC, USB and Battery.
>> 
>> This patchset adds support for the AC and Battery supplies, which is
>useful
>> for the boards from Pine64 (Pine64, SoPine w/ baseboard model A,
>Pinebook).
>> 
>> The USB supply is not yet supported in this patchset because it's not
>> present on Pine series boards.
>> 
>> In order to enable battery monitoring the ADC for battery is also
>enabled
>> for AXs.
>> 
>> In order to enable battery monitoring the ADC for battery is also
>enabled
>> for AXP803.
>
>I'll go with the obvious question...
>
>Why an RFC rather than a standard patch submission? I'm not immediately
>seeing what is controversial!

Oh I am just not confident about this patchset,
especially the IIO part.

>
>Jonathan
>
>> 
>> Icenowy Zheng (7):
>>   dt-bindings: add compatibles for AXP803 Battery/USB power supplies
>>   iio: adc: axp20x-adc: allow to skip ADC rate setup now
>>   iio: adc: axp20x-adc: add support for AXP803
>>   power: supply: axp20x-battery: support AXP803
>>   mfd: axp20x: add cells for AXP803 ADC/AC Power/Battery
>>   arm64: allwinner: a64: add power supply nodes in AXP803 DTSI
>>   arm64: allwinner: a64: enable AC and Battery for Pine64
>> 
>>  .../bindings/power/supply/axp20x_battery.txt       |   1 +
>>  .../bindings/power/supply/axp20x_usb_power.txt     |   1 +
>>  arch/arm64/boot/dts/allwinner/axp803.dtsi          |  15 +++
>>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   8 ++
>>  drivers/iio/adc/axp20x_adc.c                       | 114
>++++++++++++++++++++-
>>  drivers/mfd/axp20x.c                               |  11 ++
>>  drivers/power/supply/axp20x_battery.c              |  88
>++++++++++++++--
>>  7 files changed, 226 insertions(+), 12 deletions(-)
>> 
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

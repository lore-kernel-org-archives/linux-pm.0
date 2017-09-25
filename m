From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 0/7] AXP803 AC/Battery support
Date: Mon, 25 Sep 2017 11:22:16 +0200
Message-ID: <b23aafe5-411f-1b83-48f0-6f67b25666cc@free-electrons.com>
References: <20170920151814.22461-1-icenowy@aosc.io>
 <20170921154621.0000328d@huawei.com>
 <CF74A2A9-B9F4-4413-975B-A0F4B24686A3@aosc.io>
 <20170924153647.1d82e83c@archlinux>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBU4VUPHAKGQEUSF7MFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170924153647.1d82e83c@archlinux>
Content-Language: en-US
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Icenowy,

On 24/09/2017 16:36, Jonathan Cameron wrote:
> On Thu, 21 Sep 2017 23:20:11 +0800
> Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
>=20
>> =E4=BA=8E 2017=E5=B9=B49=E6=9C=8821=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=8810:46:21, Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> =E5=86=99=E5=88=
=B0:
>>> On Wed, 20 Sep 2017 23:18:07 +0800
>>> Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
>>> =20
>>>> The AXP803 PMIC, used by most Allwinner A64 boards, features 3 power =
=20
>>> inputs: =20
>>>> AC, USB and Battery.
>>>>
>>>> This patchset adds support for the AC and Battery supplies, which is =
=20
>>> useful =20
>>>> for the boards from Pine64 (Pine64, SoPine w/ baseboard model A, =20
>>> Pinebook). =20
>>>>
>>>> The USB supply is not yet supported in this patchset because it's not
>>>> present on Pine series boards.
>>>>
>>>> In order to enable battery monitoring the ADC for battery is also =20
>>> enabled =20
>>>> for AXs.
>>>>
>>>> In order to enable battery monitoring the ADC for battery is also =20
>>> enabled =20
>>>> for AXP803. =20
>>>
>>> I'll go with the obvious question...
>>>
>>> Why an RFC rather than a standard patch submission? I'm not immediately
>>> seeing what is controversial! =20
>>
>> Oh I am just not confident about this patchset,
>> especially the IIO part.
>=20
> It all looks fine to me.  I would imagine that, once everyone is
> happy, this will go through the mfd tree, but Lee may have other ideas!
>=20

Small modifications to make but I definitely agree with Jonathan that
you did not need to send an RFC.

Quentin

> Jonathan
>>
>>>
>>> Jonathan
>>> =20
>>>>
>>>> Icenowy Zheng (7):
>>>>   dt-bindings: add compatibles for AXP803 Battery/USB power supplies
>>>>   iio: adc: axp20x-adc: allow to skip ADC rate setup now
>>>>   iio: adc: axp20x-adc: add support for AXP803
>>>>   power: supply: axp20x-battery: support AXP803
>>>>   mfd: axp20x: add cells for AXP803 ADC/AC Power/Battery
>>>>   arm64: allwinner: a64: add power supply nodes in AXP803 DTSI
>>>>   arm64: allwinner: a64: enable AC and Battery for Pine64
>>>>
>>>>  .../bindings/power/supply/axp20x_battery.txt       |   1 +
>>>>  .../bindings/power/supply/axp20x_usb_power.txt     |   1 +
>>>>  arch/arm64/boot/dts/allwinner/axp803.dtsi          |  15 +++
>>>>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   8 ++
>>>>  drivers/iio/adc/axp20x_adc.c                       | 114 =20
>>> ++++++++++++++++++++- =20
>>>>  drivers/mfd/axp20x.c                               |  11 ++
>>>>  drivers/power/supply/axp20x_battery.c              |  88 =20
>>> ++++++++++++++-- =20
>>>>  7 files changed, 226 insertions(+), 12 deletions(-)
>>>>  =20
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel =20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

--=20
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

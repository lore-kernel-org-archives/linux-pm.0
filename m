From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
Date: Fri, 29 Aug 2014 01:01:40 +0200
Message-ID: <4669530.jbaGRecGMH@diego>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com> <4488604.oBeB6it8Vr@wuerfel> <53FF84C4.9080902@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <53FF84C4.9080902@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>, Eduardo Valentin <edubezval@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, rui.zhang@intel.com, grant.likely@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, dmitry.torokhov@gmail.com, zhaoyifeng <zyf@rock-chips.com>, linux-iio@vger.kernel.org, Courtney Cavin <courtney.cavin@sonymobile.com>
List-Id: linux-pm@vger.kernel.org

Hi Caesar,

Am Freitag, 29. August 2014, 03:36:36 schrieb Caesar Wang:
> Arnd & Heiko & Eduardo,
>=20
> OK. Maybe you are right.
>=20
> This driver should be put into drivers/iio/adc/* ,
> Anyway,I will re-edit it ASAP.

I pieced together an example on how this could look, if you need inspir=
ation.

As I've written, the tsadc on the rk3066 is simply another saradc, so i=
t was=20
easy to build a usable example with it, which you can find in my=20
devel/workbench branch [0].

Things to note, the adc values are converted to voltages instead of the=
=20
"code"-values listed in the TRM [formula: (code * vref_mv)  >> 12)] and=
 the=20
temperatures are listed in millikelvin (C+273150) as expected by the pe=
nding=20
iio-thermal driver.


@Courtney: (not sure how to reply to the old thread from february)
the only issue I found was the unit of the voltages. The binding doc li=
sts=20
them as uV, while iio (and the driver itself) expect to use mV.

Otherwise the iio-thermal driver:
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko



[0] https://github.com/mmind/linux-rockchip/commits/devel/workbench
(recent commits till "thermal: add generic IIO channel thermal sensor d=
river")



> =E5=9C=A8 2014/8/29 0:16, Arnd Bergmann =E5=86=99=E9=81=93:
> > On Thursday 28 August 2014 18:11:43 Heiko St=C3=BCbner wrote:
> >> Am Donnerstag, 28. August 2014, 10:37:35 schrieb Eduardo Valentin:
> >>>> On the driver side, I believe the correct way to deal with this =
setup
> >>>> is to split your driver into a generic
> >>>> drivers/iio/adc/rockchips-tsadc.c
> >>>> file, and a smaller thermal driver that uses the iio in-kernel
> >>>> interfaces,
> >>>> ideally one that is independent of the underlying hardware and c=
an
> >>>> work on any ADC implementation.
> >>>=20
> >>> Agreed. If you can write such interface and make your driver to w=
ork in
> >>> such way, that would be great.
> >>=20
> >> But I currently don't see how you would model the temperature hand=
ling
> >> parts from a generic thermal driver to a generic adc driver for th=
e
> >> rk3288-tsadc.
> >>=20
> >> I guess the general temperature irq handling would use iio-trigger=
s? But
> >> how does the target temperature get into the TSADC_COMP1_INT regis=
ter.
> >>=20
> >> Also when getting the temperature, Caesar's driver compares it to =
its
> >> trip
> >> points and sets the next trip point depending on the current tempe=
rature
> >> (passive <-> critical) in rockchip_get_temp.
> >>=20
> >> Maybe there is some completely easy way for this, but currently I =
don't
> >> see
> >> it.
> >=20
> > Eduardo earlier today replied to an email about a generic driver fo=
r
> > thermal, which was posted in February but hasn't been merged.
> > See https://lkml.org/lkml/2014/2/5/810
> >=20
> > There may be a newer version of this patch, which I haven't found.
> >=20
> > 	Arnd


From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
Date: Thu, 28 Aug 2014 18:16:27 +0200
Message-ID: <4488604.oBeB6it8Vr@wuerfel>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com> <20140828143733.GA18084@developer> <3440260.edal29kzlR@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3440260.edal29kzlR@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <caesar.wang@rock-chips.com>, rui.zhang@intel.com, grant.likely@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, dmitry.torokhov@gmail.com, zhaoyifeng <zyf@rock-chips.com>, linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 28 August 2014 18:11:43 Heiko St=FCbner wrote:
> Am Donnerstag, 28. August 2014, 10:37:35 schrieb Eduardo Valentin:
> > > On the driver side, I believe the correct way to deal with this s=
etup
> > > is to split your driver into a generic drivers/iio/adc/rockchips-=
tsadc.c
> > > file, and a smaller thermal driver that uses the iio in-kernel in=
terfaces,
> > > ideally one that is independent of the underlying hardware and ca=
n
> > > work on any ADC implementation.
> >=20
> > Agreed. If you can write such interface and make your driver to wor=
k in
> > such way, that would be great.
>=20
> But I currently don't see how you would model the temperature handlin=
g parts=20
> from a generic thermal driver to a generic adc driver for the rk3288-=
tsadc.
>=20
> I guess the general temperature irq handling would use iio-triggers? =
But how=20
> does the target temperature get into the TSADC_COMP1_INT register.
>=20
> Also when getting the temperature, Caesar's driver compares it to its=
 trip=20
> points and sets the next trip point depending on the current temperat=
ure=20
> (passive <-> critical) in rockchip_get_temp.
>=20
> Maybe there is some completely easy way for this, but currently I don=
't see=20
> it.

Eduardo earlier today replied to an email about a generic driver for
thermal, which was posted in February but hasn't been merged.
See https://lkml.org/lkml/2014/2/5/810

There may be a newer version of this patch, which I haven't found.

	Arnd

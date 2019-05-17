From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Date: Sat, 18 May 2019 01:27:39 +0800
Message-ID: <CAEExFWtNhTqLR+v3o6vn0Y4L65i_XsrEeiex6DNLEPEkhseCjA@mail.gmail.com>
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea> <CAEExFWvcMbiCJ4HD0UAtv1P6AuBJ=oUdmhu886BNZhrRz483Ug@mail.gmail.com>
 <20190517073634.izdmba3yqvxviyg3@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517073634.izdmba3yqvxviyg3@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com, will.deacon@arm.com, David Miller <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan.Cameron@huawei.com, Nicolas Ferre <nicolas.ferre@microchip.com>, paulmck@linux.ibm.com, Andy Gross <andy.gross@linaro.org>, olof@lixom.net, bjorn.andersson@linaro.org, Jagan Teki <jagan@amarulasolutions.com>, marc.w.gonzalez@free.fr, stefan.wahren@i2se.com, enric.balletbo@collabora.com, Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infra>
List-Id: linux-pm@vger.kernel.org

On Fri, May 17, 2019 at 3:36 PM Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
>
> On Fri, May 17, 2019 at 01:51:56AM +0800, Frank Lee wrote:
> > > > +struct sun50i_thermal_chip {
> > > > +     int     sensor_num;
> > > > +     int     offset;
> > > > +     int     scale;
> > > > +     int     ft_deviation;
> > > > +     int     temp_calib_base;
> > > > +     int     temp_data_base;
> > > > +     int     (*enable)(struct tsens_device *tmdev);
> > > > +     int     (*disable)(struct tsens_device *tmdev);
> > > > +};
> > >
> > > I'm not super fond of having a lot of quirks that are not needed. If
> > > we ever need those quirks when adding support for a new SoC, then
> > > yeah, we should totally have some, but only when and if it's needed.
> > >
> > > Otherwise, the driver is more complicated for no particular reason.
> >
> > This is unavoidable because of the difference in soc.
>
> I know, but this isn't my point.
>
> My point is that at this time of the driver development, we don't know
> what is going to be needed to support all of those SoCs.
>
> Some of the parameters you added might not be needed, some parameters
> might be missing, we don't know. So let's keep it simple for now.
>
> > > > +static int tsens_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct tsens_device *tmdev;
> > > > +     struct device *dev =3D &pdev->dev;
> > > > +     int ret;
> > > > +
> > > > +     tmdev =3D devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > > > +     if (!tmdev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     tmdev->dev =3D dev;
> > > > +     tmdev->chip =3D of_device_get_match_data(&pdev->dev);
> > > > +     if (!tmdev->chip)
> > > > +             return -EINVAL;
> > > > +
> > > > +     ret =3D tsens_init(tmdev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D tsens_register(tmdev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D tmdev->chip->enable(tmdev);
> > > > +     if (ret)
> > > > +             return ret;
> > > >
> > > > +     platform_set_drvdata(pdev, tmdev);
> > >
> > > Your registration should be the very last thing you do. Otherwise, yo=
u
> > > have a small window where the get_temp callback can be called, but th=
e
> > > driver will not be functional yet.
> >
> > No. Anyway, ths data qcquisition is ms level.
>
> That's kind of irrelevant. There's nothing preventing get_temp to be
> called right away.
As Ond=C5=99ej said,

Registration after enabling will lead to call tz update on non-registered t=
z
from an interrupt handler.

>
> > > > +     ret =3D tsens_calibrate(tmdev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     /*
> > > > +      * clkin =3D 24MHz
> > > > +      * T acquire =3D clkin / (SUN50I_THS_CTRL0_T_ACQ + 1)
> > > > +      *           =3D 20us
> > > > +      */
> > > > +     regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> > > > +                  SUN50I_THS_CTRL0_T_ACQ(479));
> > > > +     /* average over 4 samples */
> > > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
> > > > +                  SUN50I_THS_FILTER_EN |
> > > > +                  SUN50I_THS_FILTER_TYPE(1));
> > > > +     /* period =3D (SUN50I_H6_THS_PC_TEMP_PERIOD + 1) * 4096 / clk=
in; ~10ms */
> > > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
> > > > +                  SUN50I_H6_THS_PC_TEMP_PERIOD(58));
> > > > +     /* enable sensor */
> > > > +     val =3D GENMASK(tmdev->chip->sensor_num - 1, 0);
> > > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
> > > > +
> > > > +     return 0;
> > > > +
> > > > +assert_reset:
> > > > +     reset_control_assert(tmdev->reset);
> > > > +
> > > > +     return ret;
> > >
> > > Can't we do that with runtime_pm?
> >
> > Saving energy doesn't make much sense compared to system security.
>
> I'm not sure what you mean by security.

Protect system hardware from damage.

Thx,
Yangtao
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

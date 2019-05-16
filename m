From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Date: Thu, 16 May 2019 23:11:51 +0200
Message-ID: <20190516211151.qwac53shdjhlwj4p@core.my.home>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea>
 <CAEExFWvcMbiCJ4HD0UAtv1P6AuBJ=oUdmhu886BNZhrRz483Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEExFWvcMbiCJ4HD0UAtv1P6AuBJ=oUdmhu886BNZhrRz483Ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Lee <tiny.windzz@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, bjorn.andersson@linaro.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, paulmck@linux.ibm.com, stefan.wahren@i2se.com, Linux PM <linux-pm@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jagan Teki <jagan@amarulasolutions.com>, Andy Gross <andy.gross@linaro.org>, rui.zhang@intel.com, devicetree@vger.kernel.org, marc.w.gonzalez@free.fr, Eduardo Valentin <edubezval@gmail.com>, enric.balletbo@collabora.com, robh+dt@kernel.org, Jonathan.Cameron@huawei.com, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, May 17, 2019 at 01:51:56AM +0800, Frank Lee wrote:
> > > +static int tsens_probe(struct platform_device *pdev)
> > > +{
> > > +     struct tsens_device *tmdev;
> > > +     struct device *dev = &pdev->dev;
> > > +     int ret;
> > > +
> > > +     tmdev = devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > > +     if (!tmdev)
> > > +             return -ENOMEM;
> > > +
> > > +     tmdev->dev = dev;
> > > +     tmdev->chip = of_device_get_match_data(&pdev->dev);
> > > +     if (!tmdev->chip)
> > > +             return -EINVAL;
> > > +
> > > +     ret = tsens_init(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = tsens_register(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = tmdev->chip->enable(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > >
> > > +     platform_set_drvdata(pdev, tmdev);
> >
> > Your registration should be the very last thing you do. Otherwise, you
> > have a small window where the get_temp callback can be called, but the
> > driver will not be functional yet.
> No. Anyway, ths data qcquisition is ms level.

Tz code can change in the future, and call the get_temp callback during
registration, and this would break. It's better to be correct, than make
dangerous assumptions. So platform_set_drvdata should be done somewhere 
prior to init_resource.

Enable should be after register though. Because otherwise you may be calling
tz update on non-registered tz from an interrupt handler.

> > > +     return ret;
> > > +}
> > > +

regards,
	o.

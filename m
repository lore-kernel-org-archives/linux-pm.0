From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Date: Thu, 16 May 2019 19:36:49 +0200
Message-ID: <20190516173649.5s2s32ol43kbbhzg@core.my.home>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea>
 <20190512214128.qjyys3vfpwdiacib@core.my.home>
 <20190516150252.hf4u3bloo37chy6q@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190516150252.hf4u3bloo37chy6q@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, mark.rutland@arm.com, daniel.lezcano@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, bjorn.andersson@linaro.org, mchehab+samsung@kernel.org, paulmck@linux.ibm.com, stefan.wahren@i2se.com, linux-pm@vger.kernel.org, wens@csie.org, jagan@amarulasolutions.com, andy.gross@linaro.org, rui.zhang@intel.com, devicetree@vger.kernel.org, marc.w.gonzalez@free.fr, edubezval@gmail.com, enric.balletbo@collabora.com, robh+dt@kernel.org, Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, olof@lixom.net, davem@davemloft.net
List-Id: linux-pm@vger.kernel.org

Hello Maxime,

On Thu, May 16, 2019 at 05:02:52PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Sun, May 12, 2019 at 11:41:28PM +0200, Ondřej Jirman wrote:
> > > > +static int tsens_get_temp(void *data, int *temp)
> > > > +{
> > > > +	struct tsensor *s = data;
> > > > +	struct tsens_device *tmdev = s->tmdev;
> > > > +	int val;
> > > > +
> > > > +	regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> > > > +		    0x4 * s->id, &val);
> > > > +
> > > > +	if (unlikely(val == 0))
> > > > +		return -EBUSY;
> > >
> > > I'm not sure why a val equals to 0 would be associated with EBUSY?
> >
> > Thermal zone driver can (will) call get_temp before we got the
> > first interrupt and the thermal data. In that case val will be 0.
> >
> > Resulting in:
> >
> >  (val + offset) * scale = (-2794) * -67 = 187198
> >
> > 187°C and immediate shutdown during boot - based on cirtical
> > temperature being reached.
> >
> > Busy here means, get_temp does not yet have data. Thermal zone
> > driver just reports any error to dmesg output.
> 
> Ah, that makes sense.
> 
> I guess if we're switching to an interrupt-based driver, then we can
> just use a waitqueue, or is get_temp supposed to be atomic?

I'm not entirely sure, because I might have inadverently used a combination of
interrupt and polling when testing this. It may be that if we set polling-delay
to 0 in dts, that tz core will not try to call get_temp prematurely at all, and
will simply wait for temperature update from the interrupt.

I guess this needs to be tested/checked in tz code.

regards,
	o.

> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

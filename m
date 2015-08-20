From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Thu, 20 Aug 2015 09:57:48 +0200
Message-ID: <20150820075748.GP18700@pengutronix.de>
References: <1438955751-20778-1-git-send-email-s.hauer@pengutronix.de>
 <1438955751-20778-3-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omD9fhmyHEm6jWaWXi3y90Y5VDr6QeFD7tqMLbZpSN3+yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48755 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbHTH5y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 03:57:54 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omD9fhmyHEm6jWaWXi3y90Y5VDr6QeFD7tqMLbZpSN3+yw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>

On Tue, Aug 11, 2015 at 03:03:53PM +0800, Daniel Kurtz wrote:
> Hi Sascha,
> 
> I think this patch looks very good now, just some very tiny things inline...
> 
> > +
> > +struct mtk_thermal {
> > +       struct device *dev;
> > +       void __iomem *thermal_base;
> > +
> > +       struct clk *clk_peri_therm;
> > +       struct clk *clk_auxadc;
> > +
> > +       struct mtk_thermal_bank banks[MT8173_NUM_ZONES];
> > +
> > +       struct mutex lock;
> > +
> > +       /* Calibration values */
> > +       int calib_a;
> > +       int calib_b;
> 
> Rather than "a" and "b", these should probably names something like
> "offset" and "slope".

Ok.

> 
> Since these are properties of the hardware (board? SoC?), perhaps it
> makes sense to allow setting them in devicetree?

It seems there are some fuses in the SoC which shall store the
calibration values ultimately. The current bootloader cannot convert
these values into device tree properties and I'm not sure the format in
which they are stored is clear now (I hope not, since then we would have
five calibration values to describe a line). Also the new nvmem
framework seems to make it possible to describe the place for the
constants in the device tree rather than having to put the values
themselves into the device tree.
To cut a long story short I left this for a future exercise.

> > +       /*
> > +        * The MT8173 thermal controller does not have its own ADC. Instead it
> > +        * uses AHB bus accesses to control the AUXADC. To do this the thermal
> > +        * controller has to be programmed with the physical addresses of the
> > +        * AUXADC registers and with the various bit positions in the AUXADC.
> > +        * Also the thermal controller controls a mux in the APMIXEDSYS register
> > +        * space.
> > +        */
> > +
> > +       /*
> > +        * this value will be stored to TEMP_PNPMUXADDR (TEMP_SPARE0)
> > +        * automatically by hw
> > +        */
> > +       writel(BIT(MT8173_TEMP_AUXADC_CHANNEL), mt->thermal_base + TEMP_ADCMUX);
> > +
> > +       /* AHB address for auxadc mux selection */
> > +       writel(auxadc_phys_base + 0x00c, mt->thermal_base + TEMP_ADCMUXADDR);
> 
> Can you define a AUXADC_ constant for this "0x00c"?

Ok. Sorry, missed that in the last review.

> > +
> > +       ret = clk_prepare_enable(mt->clk_peri_therm);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
> > +               goto err_disable_clk_auxadc;
> > +       }
> 
> Seems like the temp sensor and ADC will always be on and clocked, even
> if not used.
> Does it make sense to give this driver runtime_pm support to disable
> the sensor and its clocks between temperature readings?  (Doesn't need
> to be added in this patch, of course.

In the longer run I would rather implement interrupt support so that we
get interrupted on critical conditions. Then we probably have to keep the
clock enabled anyway.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

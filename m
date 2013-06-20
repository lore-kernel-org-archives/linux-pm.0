From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] thermal: add imx thermal driver support
Date: Thu, 20 Jun 2013 10:47:51 +0800
Message-ID: <20130620024749.GB19896@S2101-09.ap.freescale.net>
References: <1371280241-31699-1-git-send-email-shawn.guo@linaro.org>
 <51C0C8D8.5090301@ti.com>
 <20130619073739.GA3280@S2101-09.ap.freescale.net>
 <51C1BA1A.5010704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:43611
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935534Ab3FTCr5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2013 22:47:57 -0400
Content-Disposition: inline
In-Reply-To: <51C1BA1A.5010704@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

On Wed, Jun 19, 2013 at 10:03:06AM -0400, Eduardo Valentin wrote:
> >>> @@ -0,0 +1,14 @@
> >>> +* Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
> >>
> >> Any hw documentation reference?
> >>
> > http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf?fpsp=1&WT_TYPE=Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation
> > 
> 
> OK. Tks.
> 
> Some ppl like to put hw doc reference on your driver documentation. But
> for me is your call. I believe it is good to ask the kernel doc guys too.
> 
I'm not a fan of doing that, because I can not tell that the link will
be still valid there in 5 years or so.

> >>> +
> >>> +Required properties:
> >>> +- compatible : "fsl,imx6q-thermal"
> >>> +- fsl,tempmon : phandle pointer to TEMPMON control registers
> >>> +- fsl,tempmon-data : phandle pointer to TEMPMON calibration data
> >>
> >> what exactly is calibration data?
> >>
> > The temperature calibration values are fused individually for each part
> > in the product testing process.  It consists of a pair of hardware
> > monitor values at 25 C and a high temperature which is specified by
> > calibration data itself, which will be used by software to translate
> > hardware counter values to Celsius. The detailed description can be
> > found in hardware reference manual.
> 
> That was what I expected. But it is not that clear what you meant by
> "thermal cal data" your DT documenation. Maybe you need to describe how
> to enter a fsl,tempmon-data.
> 
Ok, I will try to come up with something better.

<snip>

> >>> +#define IMX_POLLING_DELAY		5000 /* millisecond */
> >>> +#define IMX_PASSIVE_DELAY		3000
> >>
> >> What is your maximum delta between CPU frequencies? Sure this polling
> >> intervals can hold your maximum power burst?
> >>
> > I have to admit I'm not sure how to determine the optimal intervals
> > here.  I initially have both intervals be 1000 ms, but I'm not sure if
> > it's necessary.  I need some help on that.  The frequency table on the
> > target consists of 396, 792, 996 and 1200 in MHz.
> 
> Here you can do simple calculation on your maximum delta Celsius over
> delta time. Then check it against your maximum delta power (power at
> 1.2GHz - power at 396MHz) with respect to your power vs. temp. curve.
> That will give you a rough expectation on what you need to be sampling.
> But you probably need help from some guy doing thermal modeling and
> simulation on your chip.
> 
Ok, thanks for the input.  I just consulted the Freescale thermal
expert.  Though I did not get the modeling and simulation data, I was
told that one 1~2 seconds should be safer.  So I'm going to change the
definitions as below.

#define IMX_POLLING_DELAY	2000 /* millisecond */
#define IMX_PASSIVE_DELAY	1000

> > 
> >>> +
> >>> +struct imx_thermal_data {
> >>> +	struct thermal_zone_device *tz;
> >>> +	struct thermal_cooling_device *cdev;
> >>> +	enum thermal_device_mode mode;
> >>> +	struct regmap *tempmon;
> >>> +	bool meas_suspended;
> >>> +	int c1, c2; /* See forumla in imx_get_sensor_data() */
> >>> +};
> >>> +
> >>> +static int imx_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
> >>> +{
> >>> +	struct imx_thermal_data *data = tz->devdata;
> >>> +	struct regmap *map = data->tempmon;
> >>> +	static unsigned long last_temp;
> >>> +	unsigned int n_meas;
> >>> +	u32 val;
> >>> +
> >>> +	/*
> >>> +	 * Every time we measure the temperature, we will power on the
> >>> +	 * temperature sensor, enable measurements, take a reading,
> >>> +	 * disable measurements, power off the temperature sensor.
> >>> +	 */
> >>
> >> Are these sensors used on any hw failsafe mechanism?
> >>
> > No, I do not think so.
> 
> OK. Then safe to turn it off right? Another good reason to have a fine
> tuned sampling rate.
> 
Yes.

> > 
> >>> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
> >>> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
> >>> +
> >>> +	/*
> >>> +	 * According to the temp sensor designers, it may require up to ~17us
> >>> +	 * to complete a measurement.  But this timing isn't checked on every
> >>> +	 * part nor is it specified in the datasheet, so sleeping at least 1ms
> >>> +	 * should provide plenty of time.  Sleeping longer than 1ms is ok so no
> >>> +	 * need for usleep_range.
> >>> +	 */
> >>> +	msleep(1);
> >>
> >> I know 1ms is usually too short time slice when talking about thermal
> >> monitoring on nowadays processors even, but 17us to 1ms sounds like an
> >> overkill.. Sure you are not hiding other issues?
> >>
> > At least none I'm ware of.  I will update the comment and simply use
> > usleep_range in the next post to prove that I'm not hiding other
> > issues :)
> 
> OK. It just looks strange that here you need 1ms, but after suspend you
> can afford waiting only 50us. Anything special about the suspend path?
> 
Nothing special I think.  I'm changing the 1ms here to ~50 us.

<snip>

> >>> +	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl,tempmon");
> >>
> >> Is this MMIO? Sure you want to do regmapped access to something so
> >> simple as io mem r/w?
> >>
> > Yes, MMIO.  But it's embedded in some kind of system controller block,
> > call anatop on imx6q, which contains miscellaneous registers for various
> > function blocks.  We do not want to have various device drivers iomap
> > the same space multiple times.  syscon API which uses regmap was created
> > exactly for such cases, so we use it here.
> 
> Then again, I was more on the overhead imposed by regmap. For buses like
> i2c I understand its usage, but MMIO starts to be a stretch.
> 
The syscon regmap interface is widely used on Freescale platforms
as well as others to access register bits embedded in this sort of
system controllers.  I do not think there is much overhead since it's
just a wrapper of MMIO accessors, and besides we do not have the
register access on hot path anyway in the driver.

Shawn


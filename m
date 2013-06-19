From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2] thermal: add imx thermal driver support
Date: Wed, 19 Jun 2013 10:03:06 -0400
Message-ID: <51C1BA1A.5010704@ti.com>
References: <1371280241-31699-1-git-send-email-shawn.guo@linaro.org> <51C0C8D8.5090301@ti.com> <20130619073739.GA3280@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2WNXMUWXAUIRVEOIPXLCX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49739 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756495Ab3FSODi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Jun 2013 10:03:38 -0400
In-Reply-To: <20130619073739.GA3280@S2101-09.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

------enig2WNXMUWXAUIRVEOIPXLCX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19-06-2013 03:37, Shawn Guo wrote:
> Thanks for the review effort, Eduardo.
>=20
> On Tue, Jun 18, 2013 at 04:53:44PM -0400, Eduardo Valentin wrote:
>> On 15-06-2013 03:10, Shawn Guo wrote:
>>> This is based on the initial imx thermal work done by
>>> Rob Lee <rob.lee@linaro.org> (Not sure if the email address is still
>>> valid).  Since he is no longer interested in the work and I have
>>> rewritten a significant amount of the code, I just took the authorshi=
p
>>> over from him.
>>>
>>> It adds the imx thermal support using Temperature Monitor (TEMPMON)
>>> block found on some Freescale i.MX SoCs.  The driver uses syscon regm=
ap
>>> interface to access TEMPMON control registers and calibration data, a=
nd
>>> supports cpufreq as the cooling device.
>>>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>> ---
>>> Changes since v1:
>>> * Change trip type to passive.
>>>
>>>  .../devicetree/bindings/thermal/imx-thermal.txt    |   14 +
>>>  drivers/thermal/Kconfig                            |    8 +
>>>  drivers/thermal/Makefile                           |    1 +
>>>  drivers/thermal/imx_thermal.c                      |  429 ++++++++++=
++++++++++
>>>  4 files changed, 452 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/thermal/imx-the=
rmal.txt
>>>  create mode 100644 drivers/thermal/imx_thermal.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.tx=
t b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
>>> new file mode 100644
>>> index 0000000..c606e2b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
>>> @@ -0,0 +1,14 @@
>>> +* Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
>>
>> Any hw documentation reference?
>>
> http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf?fpsp=
=3D1&WT_TYPE=3DReference%20Manuals&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3D=
pdf&WT_ASSET=3DDocumentation
>=20

OK. Tks.

Some ppl like to put hw doc reference on your driver documentation. But
for me is your call. I believe it is good to ask the kernel doc guys too.=


>>> +
>>> +Required properties:
>>> +- compatible : "fsl,imx6q-thermal"
>>> +- fsl,tempmon : phandle pointer to TEMPMON control registers
>>> +- fsl,tempmon-data : phandle pointer to TEMPMON calibration data
>>
>> what exactly is calibration data?
>>
> The temperature calibration values are fused individually for each part=

> in the product testing process.  It consists of a pair of hardware
> monitor values at 25 C and a high temperature which is specified by
> calibration data itself, which will be used by software to translate
> hardware counter values to Celsius. The detailed description can be
> found in hardware reference manual.

That was what I expected. But it is not that clear what you meant by
"thermal cal data" your DT documenation. Maybe you need to describe how
to enter a fsl,tempmon-data.

>=20
>>> +
>>> +Example:
>>> +
>>> +tempmon {
>>> +	compatible =3D "fsl,imx6q-tempmon";
>>> +	fsl,tempmon =3D <&anatop>;
>>> +	fsl,tempmon-data =3D <&ocotp>;
>>> +};
>>
>> Why do you need specific DT bindings for things like registers?
>>
> Because there is no dedicated IO space for the block.  Instead, the
> registers spread in system controllers which contain miscellaneous
> control and data registers.  So we chose to access the registers via
> syscon regmap interface, and we need phandle pointer to the correct
> syscon device node.

I believe it is same as OMAPs SCM. What I did was simply to ioremap the
registers belonging to the temp sensor. At least they are not shared
with any other ip behind the SCM.

>=20
>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>> index 5e3c025..935fcbe 100644
>>> --- a/drivers/thermal/Kconfig
>>> +++ b/drivers/thermal/Kconfig
>>> @@ -91,6 +91,14 @@ config THERMAL_EMULATION
>>>  	  because userland can easily disable the thermal policy by simply
>>>  	  flooding this sysfs node with low temperature values.
>>> =20
>>> +config IMX_THERMAL
>>> +	tristate "Temperature sensor driver for Freescale i.MX SoCs"
>>> +	depends on CPU_THERMAL
>>> +	depends on MFD_SYSCON
>>> +	depends on OF
>>> +	help
>>> +	  Support for Temperature Monitor (TEMPMON) found on Freescale i.MX=
 SoCs.
>>> +
>>
>> I guess this help generates a warning (too short) by checkpatch.pl.
>>
> Yes.  But from what I've seen, most maintainers are not so concerned by=

> this particular checkpatch warning.  If you are really concerned by it,=

> I can surely manage to write up something longer.

Not a strong opinion. Just want to keep things clean. Might not be a big
effort to give it a better help though.

>=20
>>>  config SPEAR_THERMAL
>>>  	bool "SPEAr thermal sensor driver"
>>>  	depends on PLAT_SPEAR
>>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>>> index c054d41..6910b2d 100644
>>> --- a/drivers/thermal/Makefile
>>> +++ b/drivers/thermal/Makefile
>>> @@ -21,6 +21,7 @@ obj-$(CONFIG_EXYNOS_THERMAL)	+=3D exynos_thermal.o
>>>  obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
>>>  obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
>>>  obj-$(CONFIG_ARMADA_THERMAL)	+=3D armada_thermal.o
>>> +obj-$(CONFIG_IMX_THERMAL)	+=3D imx_thermal.o
>>>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
>>>  obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
>>> =20
>>> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_ther=
mal.c
>>> new file mode 100644
>>> index 0000000..2374a0d
>>> --- /dev/null
>>> +++ b/drivers/thermal/imx_thermal.c
>>> @@ -0,0 +1,429 @@
>>> +/*
>>> + * Copyright 2013 Freescale Semiconductor, Inc.
>>> + *
>>
>> No contact entry?
>>
> I'm not a big fan of doing that, because we will need to patch the
> contact from time to time to keep it update to date.  I've run into the=

> situation a lot where the contract left in the file became invalid and
> git log helps give the recent/updated contact.

Well, you can see this from other side. If you keep a contact entry, we
will be force to updated it when it gets invalid (git will start to
throw it when ppl ask for maintainers and it will return).

But it is really your call.

>=20
>>> + * This program is free software; you can redistribute it and/or mod=
ify
>>> + * it under the terms of the GNU General Public License version 2 as=

>>> + * published by the Free Software Foundation.
>>> + *
>>> + */
>>> +
>>> +#include <linux/cpu_cooling.h>
>>> +#include <linux/cpufreq.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/device.h>
>>> +#include <linux/init.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/thermal.h>
>>> +#include <linux/types.h>
>>> +
>>> +#define REG_SET		0x4
>>> +#define REG_CLR		0x8
>>> +#define REG_TOG		0xc
>>> +
>>> +#define MISC0				0x0150
>>> +#define MISC0_REFTOP_SELBIASOFF		(1 << 3)
>>> +
>>> +#define TEMPSENSE0			0x0180
>>> +#define TEMPSENSE0_TEMP_CNT_SHIFT	8
>>> +#define TEMPSENSE0_TEMP_CNT_MASK	(0xfff << TEMPSENSE0_TEMP_CNT_SHIFT=
)
>>> +#define TEMPSENSE0_FINISHED		(1 << 2)
>>> +#define TEMPSENSE0_MEASURE_TEMP		(1 << 1)
>>> +#define TEMPSENSE0_POWER_DOWN		(1 << 0)
>>> +
>>> +#define TEMPSENSE1			0x0190
>>> +#define TEMPSENSE1_MEASURE_FREQ		0xffff
>>> +
>>> +#define OCOTP_ANA1			0x04e0
>>> +
>>> +/* The driver supports 1 passive trip point and 1 critical trip poin=
t */
>>> +enum imx_thermal_trip {
>>> +	IMX_TRIP_PASSIVE,
>>> +	IMX_TRIP_CRITICAL,
>>> +	IMX_TRIP_NUM,
>>> +};
>>> +
>>> +/*
>>> + * It defines the temperature in millicelsius for passive trip point=

>>> + * that will trigger cooling action when crossed.
>>> + */
>>> +#define IMX_TEMP_PASSIVE		85000
>>> +
>>> +/*
>>> + * The maximum die temperature on imx parts is 105C, let's give some=
 cushion
>>> + * for noise and possible temperature rise between measurements.
>>> + */
>>> +#define IMX_TEMP_CRITICAL		100000
>>> +
>>> +#define IMX_POLLING_DELAY		5000 /* millisecond */
>>> +#define IMX_PASSIVE_DELAY		3000
>>
>> What is your maximum delta between CPU frequencies? Sure this polling
>> intervals can hold your maximum power burst?
>>
> I have to admit I'm not sure how to determine the optimal intervals
> here.  I initially have both intervals be 1000 ms, but I'm not sure if
> it's necessary.  I need some help on that.  The frequency table on the
> target consists of 396, 792, 996 and 1200 in MHz.

Here you can do simple calculation on your maximum delta Celsius over
delta time. Then check it against your maximum delta power (power at
1.2GHz - power at 396MHz) with respect to your power vs. temp. curve.
That will give you a rough expectation on what you need to be sampling.
But you probably need help from some guy doing thermal modeling and
simulation on your chip.

>=20
>>> +
>>> +struct imx_thermal_data {
>>> +	struct thermal_zone_device *tz;
>>> +	struct thermal_cooling_device *cdev;
>>> +	enum thermal_device_mode mode;
>>> +	struct regmap *tempmon;
>>> +	bool meas_suspended;
>>> +	int c1, c2; /* See forumla in imx_get_sensor_data() */
>>> +};
>>> +
>>> +static int imx_get_temp(struct thermal_zone_device *tz, unsigned lon=
g *temp)
>>> +{
>>> +	struct imx_thermal_data *data =3D tz->devdata;
>>> +	struct regmap *map =3D data->tempmon;
>>> +	static unsigned long last_temp;
>>> +	unsigned int n_meas;
>>> +	u32 val;
>>> +
>>> +	/*
>>> +	 * Every time we measure the temperature, we will power on the
>>> +	 * temperature sensor, enable measurements, take a reading,
>>> +	 * disable measurements, power off the temperature sensor.
>>> +	 */
>>
>> Are these sensors used on any hw failsafe mechanism?
>>
> No, I do not think so.

OK. Then safe to turn it off right? Another good reason to have a fine
tuned sampling rate.

>=20
>>> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
>>> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
>>> +
>>> +	/*
>>> +	 * According to the temp sensor designers, it may require up to ~17=
us
>>> +	 * to complete a measurement.  But this timing isn't checked on eve=
ry
>>> +	 * part nor is it specified in the datasheet, so sleeping at least =
1ms
>>> +	 * should provide plenty of time.  Sleeping longer than 1ms is ok s=
o no
>>> +	 * need for usleep_range.
>>> +	 */
>>> +	msleep(1);
>>
>> I know 1ms is usually too short time slice when talking about thermal
>> monitoring on nowadays processors even, but 17us to 1ms sounds like an=

>> overkill.. Sure you are not hiding other issues?
>>
> At least none I'm ware of.  I will update the comment and simply use
> usleep_range in the next post to prove that I'm not hiding other
> issues :)

OK. It just looks strange that here you need 1ms, but after suspend you
can afford waiting only 50us. Anything special about the suspend path?


>=20
>>> +
>>> +	regmap_read(map, TEMPSENSE0, &val);
>>> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
>>> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
>>> +
>>> +	if ((val & TEMPSENSE0_FINISHED) =3D=3D 0) {
>>> +		dev_dbg(&tz->device, "temp measurement never finished\n");
>>> +		return -EAGAIN;
>>> +	}
>>> +
>>> +	n_meas =3D (val & TEMPSENSE0_TEMP_CNT_MASK) >> TEMPSENSE0_TEMP_CNT_=
SHIFT;
>>> +
>>> +	/* See imx_get_sensor_data() for forumla derivation */
>>> +	*temp =3D data->c2 + data->c1 * n_meas;
>>> +
>>> +	if (*temp !=3D last_temp) {
>>> +		dev_dbg(&tz->device, "millicelsius: %ld\n", *temp);
>>> +		last_temp =3D *temp;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_get_mode(struct thermal_zone_device *tz,
>>> +			enum thermal_device_mode *mode)
>>> +{
>>> +	struct imx_thermal_data *data =3D tz->devdata;
>>> +
>>> +	*mode =3D data->mode;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_set_mode(struct thermal_zone_device *tz,
>>> +			enum thermal_device_mode mode)
>>> +{
>>> +	struct imx_thermal_data *data =3D tz->devdata;
>>> +
>>> +	if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
>>> +		tz->polling_delay =3D IMX_POLLING_DELAY;
>>> +		tz->passive_delay =3D IMX_PASSIVE_DELAY;
>>> +	} else {
>>> +		tz->polling_delay =3D 0;
>>> +		tz->passive_delay =3D 0;
>>> +	}
>>> +
>>> +	data->mode =3D mode;
>>> +	thermal_zone_device_update(tz);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_get_trip_type(struct thermal_zone_device *tz, int tri=
p,
>>> +			     enum thermal_trip_type *type)
>>> +{
>>> +	*type =3D (trip =3D=3D IMX_TRIP_PASSIVE) ? THERMAL_TRIP_PASSIVE :
>>> +					     THERMAL_TRIP_CRITICAL;
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_get_crit_temp(struct thermal_zone_device *tz,
>>> +			     unsigned long *temp)
>>> +{
>>> +	*temp =3D IMX_TEMP_CRITICAL;
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_get_trip_temp(struct thermal_zone_device *tz, int tri=
p,
>>> +			     unsigned long *temp)
>>> +{
>>> +	*temp =3D (trip =3D=3D IMX_TRIP_PASSIVE) ? IMX_TEMP_PASSIVE :
>>> +					     IMX_TEMP_CRITICAL;
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_bind(struct thermal_zone_device *tz,
>>> +		    struct thermal_cooling_device *cdev)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret =3D thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev=
,
>>> +					       THERMAL_NO_LIMIT,
>>> +					       THERMAL_NO_LIMIT);
>>> +	if (ret) {
>>> +		dev_err(&tz->device,
>>> +			"binding zone %s with cdev %s failed:%d\n",
>>> +			tz->type, cdev->type, ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>
>> nit: I think it is just safe to do:
>=20
> Yes, it is.  But I personally would like to separate error return from
> successful one, because I feel it's more readable.

This is indeed a matter of taste.

>=20
>> +	ret =3D thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,=

>> +					       THERMAL_NO_LIMIT,
>> +					       THERMAL_NO_LIMIT);
>> +	if (ret)
>> +		dev_err(&tz->device,
>> +			"binding zone %s with cdev %s failed:%d\n",
>> +			tz->type, cdev->type, ret);
>> +
>> +	return ret;
>>
>>> +}
>>> +
>>> +static int imx_unbind(struct thermal_zone_device *tz,
>>> +		      struct thermal_cooling_device *cdev)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret =3D thermal_zone_unbind_cooling_device(tz, IMX_TRIP_PASSIVE, cd=
ev);
>>> +	if (ret) {
>>> +		dev_err(&tz->device,
>>> +			"unbinding zone %s with cdev %s failed:%d\n",
>>> +			tz->type, cdev->type, ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>
>> ditto.
>>
>>> +}
>>> +
>>> +static const struct thermal_zone_device_ops imx_tz_ops =3D {
>>> +	.bind =3D imx_bind,
>>> +	.unbind =3D imx_unbind,
>>> +	.get_temp =3D imx_get_temp,
>>> +	.get_mode =3D imx_get_mode,
>>> +	.set_mode =3D imx_set_mode,
>>> +	.get_trip_type =3D imx_get_trip_type,
>>> +	.get_trip_temp =3D imx_get_trip_temp,
>>> +	.get_crit_temp =3D imx_get_crit_temp,
>>> +};
>>> +
>>> +static int imx_get_sensor_data(struct platform_device *pdev)
>>> +{
>>> +	struct imx_thermal_data *data =3D platform_get_drvdata(pdev);
>>> +	struct regmap *map;
>>> +	int t1, t2, n1, n2;
>>> +	int ret;
>>> +	u32 val;
>>> +
>>> +	map =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>>> +					      "fsl,tempmon-data");
>>> +	if (IS_ERR(map)) {
>>> +		ret =3D PTR_ERR(map);
>>> +		dev_err(&pdev->dev, "failed to get sensor regmap: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret =3D regmap_read(map, OCOTP_ANA1, &val);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	if (val =3D=3D 0 || val =3D=3D ~0) {
>>> +		dev_err(&pdev->dev, "invalid sensor calibration data\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Sensor data layout:
>>> +	 *   [31:20] - sensor value @ 25C
>>> +	 *    [19:8] - sensor value of hot
>>> +	 *     [7:0] - hot temperature value
>>> +	 */
>>> +	n1 =3D val >> 20;
>>> +	n2 =3D (val & 0xfff00) >> 8;
>>> +	t2 =3D val & 0xff;
>>> +	t1 =3D 25; /* t1 always 25C */
>>> +
>>> +	/*
>>> +	 * Derived from linear interpolation,
>>> +	 * Tmeas =3D T2 + (Nmeas - N2) * (T1 - T2) / (N1 - N2)
>>> +	 * We want to reduce this down to the minimum computation necessary=

>>> +	 * for each temperature read.  Also, we want Tmeas in millicelsius
>>> +	 * and we don't want to lose precision from integer division. So...=

>>> +	 * milli_Tmeas =3D 1000 * T2 + 1000 * (Nmeas - N2) * (T1 - T2) / (N=
1 - N2)
>>> +	 * Let constant c1 =3D 1000 * (T1 - T2) / (N1 - N2)
>>> +	 * milli_Tmeas =3D (1000 * T2) + c1 * (Nmeas - N2)
>>> +	 * milli_Tmeas =3D (1000 * T2) + (c1 * Nmeas) - (c1 * N2)
>>> +	 * Let constant c2 =3D (1000 * T2) - (c1 * N2)
>>> +	 * milli_Tmeas =3D c2 + (c1 * Nmeas)
>>> +	 */
>>> +	data->c1 =3D 1000 * (t1 - t2) / (n1 - n2);
>>> +	data->c2 =3D 1000 * t2 - data->c1 * n2;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_thermal_probe(struct platform_device *pdev)
>>> +{
>>> +	struct imx_thermal_data *data;
>>> +	struct cpumask clip_cpus;
>>> +	struct regmap *map;
>>> +	int ret;
>>> +
>>> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>> +	if (!data)
>>> +		return -ENOMEM;
>>> +
>>> +	map =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl,tem=
pmon");
>>
>> Is this MMIO? Sure you want to do regmapped access to something so
>> simple as io mem r/w?
>>
> Yes, MMIO.  But it's embedded in some kind of system controller block,
> call anatop on imx6q, which contains miscellaneous registers for variou=
s
> function blocks.  We do not want to have various device drivers iomap
> the same space multiple times.  syscon API which uses regmap was create=
d
> exactly for such cases, so we use it here.

Then again, I was more on the overhead imposed by regmap. For buses like
i2c I understand its usage, but MMIO starts to be a stretch.

>=20
>>> +	if (IS_ERR(map)) {
>>> +		ret =3D PTR_ERR(map);
>>> +		dev_err(&pdev->dev, "failed to get tempmon regmap: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +	data->tempmon =3D map;
>>> +
>>> +	platform_set_drvdata(pdev, data);
>>> +
>>> +	ret =3D imx_get_sensor_data(pdev);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to get sensor data\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* Make sure sensor is in known good state for measurements */
>>> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
>>> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
>>> +	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
>>> +	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
>>> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
>>> +
>>> +	cpumask_set_cpu(0, &clip_cpus);
>>> +	data->cdev =3D cpufreq_cooling_register(&clip_cpus);
>>> +	if (IS_ERR(data->cdev)) {
>>> +		ret =3D PTR_ERR(data->cdev);
>>> +		dev_err(&pdev->dev,
>>> +			"failed to register cpufreq cooling device: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	data->tz =3D thermal_zone_device_register("imx_thermal_zone",
>>> +						IMX_TRIP_NUM, 0, data,
>>> +						&imx_tz_ops, NULL,
>>> +						IMX_PASSIVE_DELAY,
>>> +						IMX_POLLING_DELAY);
>>> +	if (IS_ERR(data->tz)) {
>>> +		ret =3D PTR_ERR(data->tz);
>>> +		dev_err(&pdev->dev,
>>> +			"failed to register thermal zone device %d\n", ret);
>>> +		cpufreq_cooling_unregister(data->cdev);
>>> +		return ret;
>>> +	}
>>> +
>>> +	data->mode =3D THERMAL_DEVICE_ENABLED;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_thermal_remove(struct platform_device *pdev)
>>> +{
>>> +	struct imx_thermal_data *data =3D platform_get_drvdata(pdev);
>>> +
>>> +	thermal_zone_device_unregister(data->tz);
>>> +	cpufreq_cooling_unregister(data->cdev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int imx_thermal_suspend(struct device *dev)
>>> +{
>>> +	struct imx_thermal_data *data =3D dev_get_drvdata(dev);
>>> +	struct regmap *map =3D data->tempmon;
>>> +	u32 val;
>>> +
>>> +	regmap_read(map, TEMPSENSE0, &val);
>>> +
>>> +	/* Was a measurement taking place?  If not, nothing to do. */
>>> +	if (val & TEMPSENSE0_POWER_DOWN)
>>> +		return 0;
>>> +
>>> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
>>> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
>>
>> hmmm.. Whould this mess with the running meas? Any luck to wait it to
>> finish then suspend?
>=20
> Yeah, sounds like a good idea.  Will simply give it a wait.

OK.

>=20
>>
>>> +
>>> +	data->meas_suspended =3D true;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_thermal_resume(struct device *dev)
>>> +{
>>> +	struct imx_thermal_data *data =3D dev_get_drvdata(dev);
>>> +	struct regmap *map =3D data->tempmon;
>>> +
>>> +	/*
>>> +	 * If a measurement was taking place while suspend, re-take the
>>> +	 * measurement.
>>> +	 */
>>> +	if (data->meas_suspended) {
>>> +		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
>>> +		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
>>> +		/*
>>> +		 * According to the temp sensor designers, it may require
>>> +		 * up to ~17us to complete a measurement.  But this timing
>>> +		 * isn't checked on every part nor is it specified in the
>>> +		 * datasheet, so delay 50us for timing margin.
>>> +		 */
>>> +		udelay(50);
>>
>> hmm.. here you need 50us only but on regular readings 1ms?
>>
>>> +		data->meas_suspended =3D false;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +#endif
>>> +
>>> +static SIMPLE_DEV_PM_OPS(imx_thermal_pm_ops,
>>> +			 imx_thermal_suspend, imx_thermal_resume);
>>> +
>>> +static const struct of_device_id of_imx_thermal_match[] =3D {
>>> +	{ .compatible =3D "fsl,imx6q-tempmon", },
>>> +	{ /* end */ }
>>> +};
>>> +
>>> +static struct platform_driver imx_thermal =3D {
>>> +	.driver =3D {
>>> +		.name	=3D "imx_thermal",
>>> +		.owner  =3D THIS_MODULE,
>>> +		.pm	=3D &imx_thermal_pm_ops,
>>> +		.of_match_table =3D of_imx_thermal_match,
>>> +	},
>>> +	.probe		=3D imx_thermal_probe,
>>> +	.remove		=3D imx_thermal_remove,
>>> +};
>>> +
>>> +static int __init imx_thermal_init(void)
>>> +{
>>> +	return platform_driver_register(&imx_thermal);
>>> +}
>>> +late_initcall(imx_thermal_init);
>>> +
>>> +static void __exit imx_thermal_exit(void)
>>> +{
>>> +	platform_driver_unregister(&imx_thermal);
>>> +}
>>> +module_exit(imx_thermal_exit);
>>
>> How about using module_platform_driver() macro?
>=20
> I thought that the thermal driver has to be probed before cpufreq
> driver.  I just give it a trial run and found that imx_thermal_probe()
> can return success even when cpufreq driver is not probed yet.  So
> making imx_thermal_init a late_initcall seems unnecessary.  Therefore,
> yes, we can use module_platform_driver() here.

OK. Looks like to be a general issue. I faced the same with cpufreq vs
thermal. Initially I also thought of doing late_init, but it does not
really solve the problem. I solved it by returning -EDEFER_PROBE till a
proper cpufreq driver pops up. Which actually solved the issue.

We might want to make this solution go into cpufreq_cooling device
instead, and drivers have to propagate the error code at their probe.

I will cook somehting for this so that drivers are cleaner.

>=20
> Shawn
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2WNXMUWXAUIRVEOIPXLCX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHBuhoACgkQCXcVR3XQvP3vfAD+Ps5rQ0ygKq9AFLXyKEh10SlD
kUiA+PrUX1NU1n4nSIQA/3vqQQWmNr1xHF4xKew7TUk1T5OfrCw8u6qfb+7+RfjP
=pJ3/
-----END PGP SIGNATURE-----

------enig2WNXMUWXAUIRVEOIPXLCX--

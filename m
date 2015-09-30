From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Wed, 30 Sep 2015 10:36:14 +0100
Message-ID: <9hhpp105jw1.fsf@e105922-lin.cambridge.arm.com>
References: <1443015463-23639-1-git-send-email-s.hauer@pengutronix.de>
	<1443015463-23639-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443015463-23639-3-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
	(Sascha Hauer's message of "Wed, 23 Sep 2015 15:37:42 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Sascha,

Re-posting a comment from v7. Perhaps you missed it...

Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> writes:

> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instead
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
>
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/thermal/Kconfig       |   8 +
>  drivers/thermal/Makefile      |   1 +
>  drivers/thermal/mtk_thermal.c | 537 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 546 insertions(+)
>  create mode 100644 drivers/thermal/mtk_thermal.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 0390044..dadd1eb 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -348,6 +348,14 @@ config INTEL_PCH_THERMAL
>  	  Thermal reporting device will provide temperature reading,
>  	  programmable trip points and other information.
>  
> +config MTK_THERMAL
> +	tristate "Temperature sensor driver for mediatek SoCs"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	default y
> +	help
> +	  Enable this option if you want to have support for thermal management
> +	  controller present in Mediatek SoCs
> +
>  menu "Texas Instruments thermal drivers"
>  source "drivers/thermal/ti-soc-thermal/Kconfig"
>  endmenu
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 26f1608..5f979e7 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -45,3 +45,4 @@ obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
>  obj-$(CONFIG_ST_THERMAL)	+= st/
>  obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> +obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> new file mode 100644
> index 0000000..6be1a6c
> --- /dev/null
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -0,0 +1,537 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: Hanyi Wu <hanyi.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <dt-bindings/thermal/mt8173.h>
> +
> +/* AUXADC Registers */
> +#define AUXADC_CON0_V		0x000
> +#define AUXADC_CON1_V		0x004
> +#define AUXADC_CON1_SET_V	0x008
> +#define AUXADC_CON1_CLR_V	0x00c
> +#define AUXADC_CON2_V		0x010
> +#define AUXADC_DATA(channel)	(0x14 + (channel) * 4)
> +#define AUXADC_MISC_V		0x094
> +
> +#define AUXADC_CON1_CHANNEL(x)	BIT(x)
> +
> +#define APMIXED_SYS_TS_CON1	0x604
> +
> +/* Thermal Controller Registers */
> +#define TEMP_MONCTL0		0x000
> +#define TEMP_MONCTL1		0x004
> +#define TEMP_MONCTL2		0x008
> +#define TEMP_MONIDET0		0x014
> +#define TEMP_MONIDET1		0x018
> +#define TEMP_MSRCTL0		0x038
> +#define TEMP_AHBPOLL		0x040
> +#define TEMP_AHBTO		0x044
> +#define TEMP_ADCPNP0		0x048
> +#define TEMP_ADCPNP1		0x04c
> +#define TEMP_ADCPNP2		0x050
> +#define TEMP_ADCPNP3		0x0b4
> +
> +#define TEMP_ADCMUX		0x054
> +#define TEMP_ADCEN		0x060
> +#define TEMP_PNPMUXADDR		0x064
> +#define TEMP_ADCMUXADDR		0x068
> +#define TEMP_ADCENADDR		0x074
> +#define TEMP_ADCVALIDADDR	0x078
> +#define TEMP_ADCVOLTADDR	0x07c
> +#define TEMP_RDCTRL		0x080
> +#define TEMP_ADCVALIDMASK	0x084
> +#define TEMP_ADCVOLTAGESHIFT	0x088
> +#define TEMP_ADCWRITECTRL	0x08c
> +#define TEMP_MSR0		0x090
> +#define TEMP_MSR1		0x094
> +#define TEMP_MSR2		0x098
> +#define TEMP_MSR3		0x0B8
> +
> +#define TEMP_SPARE0		0x0f0
> +
> +#define PTPCORESEL		0x400
> +
> +#define TEMP_MONCTL1_PERIOD_UNIT(x)	((x) & 0x3ff)
> +
> +#define TEMP_MONCTL2_FILTER_INTERVAL(x)	(((x) & 0x3ff)) << 16
> +#define TEMP_MONCTL2_SENSOR_INTERVAL(x)	((x) & 0x3ff)
> +
> +#define TEMP_AHBPOLL_ADC_POLL_INTERVAL(x)	(x)
> +
> +#define TEMP_ADCWRITECTRL_ADC_PNP_WRITE		BIT(0)
> +#define TEMP_ADCWRITECTRL_ADC_MUX_WRITE		BIT(1)
> +
> +#define TEMP_ADCVALIDMASK_VALID_HIGH		BIT(5)
> +#define TEMP_ADCVALIDMASK_VALID_POS(bit)	(bit)
> +
> +#define MT8173_TS1	0
> +#define MT8173_TS2	1
> +#define MT8173_TS3	2
> +#define MT8173_TS4	3
> +#define MT8173_TSABB	4
> +
> +/* AUXADC channel 11 is used for the temperature sensors */
> +#define MT8173_TEMP_AUXADC_CHANNEL	11
> +
> +/* The total number of temperature sensors in the MT8173 */
> +#define MT8173_NUM_SENSORS		5
> +
> +/* The number of banks in the MT8173 */
> +#define MT8173_NUM_ZONES		4
> +
> +/* The number of sensing points per bank */
> +#define MT8173_NUM_SENSORS_PER_ZONE	4
> +
> +#define THERMAL_NAME    "mtk-thermal"
> +
> +struct mtk_thermal;
> +
> +struct mtk_thermal_bank {
> +	struct mtk_thermal *mt;
> +	struct thermal_zone_device *tzd;
> +	int id;
> +};
> +
> +struct mtk_thermal {
> +	struct device *dev;
> +	void __iomem *thermal_base;
> +
> +	struct clk *clk_peri_therm;
> +	struct clk *clk_auxadc;
> +
> +	struct mtk_thermal_bank banks[MT8173_NUM_ZONES];
> +
> +	struct mutex lock;
> +
> +	/* Calibration values */
> +	int calib_slope;
> +	int calib_offset;
> +};
> +
> +struct mtk_thermal_bank_cfg {
> +	unsigned int num_sensors;
> +	unsigned int sensors[MT8173_NUM_SENSORS_PER_ZONE];
> +};
> +
> +static const int sensor_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
> +
> +/*
> + * The MT8173 thermal controller has four banks. Each bank can read up to
> + * four temperature sensors simultaneously. The MT8173 has a total of 5
> + * temperature sensors. We use each bank to measure a certain area of the
> + * SoC. Since TS2 is located centrally in the SoC it is influenced by multiple
> + * areas, hence is used in different banks.
> + */
> +static const struct mtk_thermal_bank_cfg bank_data[] = {
> +	[MT8173_THERMAL_ZONE_CA53] = {
> +		.num_sensors = 2,
> +		.sensors = { MT8173_TS2, MT8173_TS3 },
> +	},
> +
> +	[MT8173_THERMAL_ZONE_CA57] = {
> +		.num_sensors = 2,
> +		.sensors = { MT8173_TS2, MT8173_TS4 },
> +	},
> +
> +	[MT8173_THERMAL_ZONE_GPU] = {
> +		.num_sensors = 3,
> +		.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> +	},
> +
> +	[MT8173_THERMAL_ZONE_CORE] = {
> +		.num_sensors = 1,
> +		.sensors = { MT8173_TS2 },
> +	},
> +};
> +
> +struct mtk_thermal_sense_point {
> +	int msr;
> +	int adcpnp;
> +};
> +
> +static const struct mtk_thermal_sense_point
> +		sensing_points[MT8173_NUM_SENSORS_PER_ZONE] = {
> +	{
> +		.msr = TEMP_MSR0,
> +		.adcpnp = TEMP_ADCPNP0,
> +	}, {
> +		.msr = TEMP_MSR1,
> +		.adcpnp = TEMP_ADCPNP1,
> +	}, {
> +		.msr = TEMP_MSR2,
> +		.adcpnp = TEMP_ADCPNP2,
> +	}, {
> +		.msr = TEMP_MSR3,
> +		.adcpnp = TEMP_ADCPNP3,
> +	},
> +};
> +
> +/**
> + * raw_to_mcelsius - convert a raw ADC value to mcelsius
> + * @mt:		The thermal controller
> + * @raw:	raw ADC value
> + *
> + * This converts the raw ADC value to mcelsius using the SoC specific
> + * calibration constants
> + */
> +static int raw_to_mcelsius(struct mtk_thermal *mt, u32 raw)
> +{
> +	return mt->calib_offset + mt->calib_slope * (raw & 0xfff);
> +}
> +
> +/**
> + * mtk_thermal_get_bank - get bank
> + * @bank:	The bank
> + *
> + * The bank registers are banked, we have to select a bank in the
> + * PTPCORESEL register to access it.
> + */
> +static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
> +{
> +	struct mtk_thermal *mt = bank->mt;
> +	u32 val;
> +
> +	mutex_lock(&mt->lock);
> +
> +	val = readl(mt->thermal_base + PTPCORESEL);
> +	val &= ~0xf;
> +	val |= bank->id;
> +	writel(val, mt->thermal_base + PTPCORESEL);
> +}
> +
> +/**
> + * mtk_thermal_put_bank - release bank
> + * @bank:	The bank
> + *
> + * release a bank previously taken with mtk_thermal_get_bank,
> + */
> +static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
> +{
> +	struct mtk_thermal *mt = bank->mt;
> +
> +	mutex_unlock(&mt->lock);
> +}
> +
> +/**
> + * mtk_thermal_bank_temperature - get the temperature of a bank
> + * @bank:	The bank
> + *
> + * The temperature of a bank is considered the maximum temperature of
> + * the sensors associated to the bank.
> + */
> +static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
> +{
> +	struct mtk_thermal *mt = bank->mt;
> +	int temp, i, max;
> +	u32 raw;
> +
> +	temp = max = INT_MIN;
> +
> +	for (i = 0; i < bank_data[bank->id].num_sensors; i++) {
> +		raw = readl(mt->thermal_base + sensing_points[i].msr);
> +
> +		temp = raw_to_mcelsius(mt, raw);
> +
> +		/*
> +		 * The first read of a sensor often contains very high bogus
> +		 * temperature value. Filter these out so that the system does
> +		 * not immediately shut down.
> +		 */
> +		if (temp > 200000)
> +			temp = 0;
> +

If the bogus value is only the first time the sensor is read, instead of
filtering here, you could call mtk_thermal_bank_temperature at probe
time when you are initialising the banks and ignore the returned value.

Thanks,
Punit

> +		if (temp > max)
> +			max = temp;
> +	}
> +
> +	return max;
> +}
> +

[...]

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

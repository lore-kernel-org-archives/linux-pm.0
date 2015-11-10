From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Tue, 10 Nov 2015 12:05:54 +0000
Message-ID: <20151110120554.GB3551@e104805>
References: <1447064013-13026-1-git-send-email-s.hauer@pengutronix.de>
 <1447064013-13026-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55617 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbbKJMF7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Nov 2015 07:05:59 -0500
Content-Disposition: inline
In-Reply-To: <1447064013-13026-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org

On Mon, Nov 09, 2015 at 11:13:32AM +0100, Sascha Hauer wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instead
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/Kconfig       |   8 +
>  drivers/thermal/Makefile      |   1 +
>  drivers/thermal/mtk_thermal.c | 619 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 628 insertions(+)
>  create mode 100644 drivers/thermal/mtk_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5aabc4b..503448a 100644
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
>  depends on ARCH_HAS_BANDGAP || COMPILE_TEST
>  source "drivers/thermal/ti-soc-thermal/Kconfig"
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
> index 0000000..2d2e97c
> --- /dev/null
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -0,0 +1,619 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: Hanyi Wu <hanyi.wu@mediatek.com>
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
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/thermal.h>
> +#include <linux/reset.h>
> +#include <linux/types.h>
> +#include <linux/nvmem-consumer.h>
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
> +/* Layout of the fuses providing the calibration data */
> +#define MT8173_CALIB_BUF0_VALID		(1 << 0)
> +#define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22 ) & 0x3ff)
> +#define MT8173_CALIB_BUF0_VTS_TS1(x)	(((x) >> 17 ) & 0x1ff)
> +#define MT8173_CALIB_BUF0_VTS_TS2(x)	(((x) >> 8 ) & 0x1ff)
> +#define MT8173_CALIB_BUF1_VTS_TS3(x)	(((x) >> 0 ) & 0x1ff)
> +#define MT8173_CALIB_BUF2_VTS_TS4(x)	(((x) >> 23 ) & 0x1ff)
> +#define MT8173_CALIB_BUF2_VTS_TSABB(x)	(((x) >> 14 ) & 0x1ff)
> +#define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1 ) & 0x3f)
> +#define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26 ) & 0x3f)
> +
> +#define THERMAL_NAME    "mtk-thermal"
> +
> +struct mtk_thermal;
> +
> +struct mtk_thermal_bank {
> +	struct mtk_thermal *mt;
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
> +	s32 adc_ge;
> +	s32 degc_cali;
> +	s32 o_slope;
> +	s32 vts[MT8173_NUM_SENSORS];
> +
> +	struct thermal_zone_device *tzd;
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
> +	{
> +		.num_sensors = 2,
> +		.sensors = { MT8173_TS2, MT8173_TS3 },
> +	}, {
> +		.num_sensors = 2,
> +		.sensors = { MT8173_TS2, MT8173_TS4 },
> +	}, {
> +		.num_sensors = 3,
> +		.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> +	}, {
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
> +static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
> +{
> +	s32 tmp;
> +
> +	raw &= 0xfff;
> +
> +	tmp = 203450520 << 3;
> +	tmp /= 165 + mt->o_slope;
> +	tmp /= 10000 + mt->adc_ge;
> +	tmp *= raw - mt->vts[sensno] - 3350;
> +	tmp >>= 3;
> +
> +	return mt->degc_cali * 500 - tmp;
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
> +		temp = raw_to_mcelsius(mt, bank_data[bank->id].sensors[i], raw);
> +
> +		/*
> +		 * The first read of a sensor often contains very high bogus
> +		 * temperature value. Filter these out so that the system does
> +		 * not immediately shut down.
> +		 */
> +		if (temp > 200000)
> +			temp = 0;
> +
> +		if (temp > max)
> +			max = temp;
> +	}
> +
> +	return max;
> +}
> +
> +static int mtk_read_temp(void *data, int *temperature)
> +{
> +	struct mtk_thermal *mt = data;
> +	int i;
> +	int tempmax = INT_MIN;
> +
> +	for (i = 0; i < MT8173_NUM_ZONES; i++) {
> +		struct mtk_thermal_bank *bank = &mt->banks[i];
> +		int t;
> +
> +		mtk_thermal_get_bank(bank);
> +
> +		t = mtk_thermal_bank_temperature(bank);

IIUIC, when you had multiple thermal zones
mtk_thermal_bank_temperature() made sense, but now it looks like
you're just doing the maximum of all sensors.  Why bother with the
banks any more?  Aren't you just calculating the maximum of all
sensors?  As TS2 is present in all banks, there's no point in reading
it four times just to get the maximum of all sensors.

> +		mtk_thermal_put_bank(bank);
> +
> +		if (t > tempmax)
> +			tempmax = t;
> +	}
> +
> +	*temperature = tempmax;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
> +	.get_temp = mtk_read_temp,
> +};

Cheers,
Javi


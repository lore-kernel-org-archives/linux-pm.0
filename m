From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal driver for mt2701.
Date: Thu, 7 Jul 2016 17:24:40 +0530
Message-ID: <577E4300.406@ti.com>
References: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
 <1467882386-40544-3-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1467882386-40544-3-git-send-email-dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fan Chen <fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Dawei Chien,


On Thursday 07 July 2016 02:36 PM, Dawei Chien wrote:
> This patch adds support for mt2701 chip to mtk_thermal.c,
> and integrate both mt8173 and mt2701 on the same driver.
> MT8173 has four banks and five sensors, and MT2701 has
> only one bank and three sensors.
>
> Signed-off-by: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/thermal/mtk_thermal.c |  258 ++++++++++++++++++++++++++---------------
>   1 file changed, 165 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 262ab0a..860f2e2 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -2,6 +2,7 @@
>    * Copyright (c) 2015 MediaTek Inc.
>    * Author: Hanyi Wu <hanyi.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>    *         Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + *         Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>    *
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 as
> @@ -21,6 +22,7 @@
>   #include <linux/nvmem-consumer.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/io.h>
> @@ -88,6 +90,7 @@
>   #define TEMP_ADCVALIDMASK_VALID_HIGH		BIT(5)
>   #define TEMP_ADCVALIDMASK_VALID_POS(bit)	(bit)
>
> +/* MT8173 thermal sensors */
>   #define MT8173_TS1	0
>   #define MT8173_TS2	1
>   #define MT8173_TS3	2
> @@ -97,35 +100,62 @@
>   /* AUXADC channel 11 is used for the temperature sensors */
>   #define MT8173_TEMP_AUXADC_CHANNEL	11
>
> -/* The total number of temperature sensors in the MT8173 */
> -#define MT8173_NUM_SENSORS		5
> -
> -/* The number of banks in the MT8173 */
> -#define MT8173_NUM_ZONES		4
> -
> -/* The number of sensing points per bank */
> -#define MT8173_NUM_SENSORS_PER_ZONE	4
> -
>   /* Layout of the fuses providing the calibration data */
> -#define MT8173_CALIB_BUF0_VALID		BIT(0)
> -#define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22) & 0x3ff)
> -#define MT8173_CALIB_BUF0_VTS_TS1(x)	(((x) >> 17) & 0x1ff)
> -#define MT8173_CALIB_BUF0_VTS_TS2(x)	(((x) >> 8) & 0x1ff)
> -#define MT8173_CALIB_BUF1_VTS_TS3(x)	(((x) >> 0) & 0x1ff)
> -#define MT8173_CALIB_BUF2_VTS_TS4(x)	(((x) >> 23) & 0x1ff)
> -#define MT8173_CALIB_BUF2_VTS_TSABB(x)	(((x) >> 14) & 0x1ff)
> -#define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1) & 0x3f)
> -#define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26) & 0x3f)
> +#define CALIB_BUF0_VALID		BIT(0)
> +#define CALIB_BUF1_ADC_GE(x)	(((x) >> 22) & 0x3ff)
> +#define CALIB_BUF0_VTS_TS1(x)	(((x) >> 17) & 0x1ff)
> +#define CALIB_BUF0_VTS_TS2(x)	(((x) >> 8) & 0x1ff)
> +#define CALIB_BUF1_VTS_TS3(x)	(((x) >> 0) & 0x1ff)
> +#define CALIB_BUF2_VTS_TS4(x)	(((x) >> 23) & 0x1ff)
> +#define CALIB_BUF2_VTS_TS5(x)	(((x) >> 14) & 0x1ff)
> +#define CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1) & 0x3f)
> +#define CALIB_BUF0_O_SLOPE(x)	(((x) >> 26) & 0x3f)
> +

IMHO the above changes from defining CALIB_BUF1_ADC_GE(x) to 
CALIB_BUF0_O_SLOPE(x) can be avoided. We are just renaming the same 
defines to a generic name. Instead the macro starting with MT8173 can 
only be used wherever needed commonly both by 8173 instance and for
2701 instance.

> +#define NVMEM_TS1	0
> +#define NVMEM_TS2	1
> +#define NVMEM_TS3	2
> +#define NVMEM_TS4	3
> +#define NVMEM_TS5	4
> +
> +/* MT2701 thermal sensors */
> +#define MT2701_TS1	0
> +#define MT2701_TS2	1
> +#define MT2701_TSABB	2
> +
> +/* AUXADC channel 11 is used for the temperature sensors */
> +#define MT2701_TEMP_AUXADC_CHANNEL	11
>
>   #define THERMAL_NAME    "mtk-thermal"
>
> +/* Maximum support banks */
> +#define MAX_NUM_BANK		5

Why is this 5?
Commit message states: MT8173 has four banks and five sensors, and 
MT2701 has only one bank and three sensors. Am i missing something here?

> +
>   struct mtk_thermal;
>
> +struct thermal_bank_cfg {
> +	unsigned int num_sensors;
> +	unsigned int sensors[MAX_NUM_BANK];
> +};
> +
>   struct mtk_thermal_bank {
>   	struct mtk_thermal *mt;
>   	int id;
>   };
>
> +struct mtk_thermal_sense_point {
> +	int msr;
> +	int adcpnp;
> +};
> +
> +struct mtk_thermal_data {
> +	struct thermal_bank_cfg bank_data[MAX_NUM_BANK];

So for MT8173 we are allocating one bank extra and for MT2701 we are 
allocating 4 banks extra right? Why not do something like this:

struct thermal_bank *banks_data
Assign the array based on the SoC type?

> +	struct mtk_thermal_sense_point sensing_points[MAX_NUM_BANK];
> +	int sensor_mux_values[MAX_NUM_BANK];
> +	s32 num_banks;
> +	s32 num_sensors;
> +	s32 auxadc_channel;
> +};
> +
>   struct mtk_thermal {
>   	struct device *dev;
>   	void __iomem *thermal_base;
> @@ -133,27 +163,20 @@ struct mtk_thermal {
>   	struct clk *clk_peri_therm;
>   	struct clk *clk_auxadc;
>
> -	struct mtk_thermal_bank banks[MT8173_NUM_ZONES];
> -
> +	struct mtk_thermal_bank banks[MAX_NUM_BANK];

Here again some extra memory allocation.

Why not keep a pointer which points to the desired array?

> +	const struct mtk_thermal_data *conf;
>   	/* lock: for getting and putting banks */
>   	struct mutex lock;
> +	struct thermal_zone_device *tzd;
>
>   	/* Calibration values */
>   	s32 adc_ge;
>   	s32 degc_cali;
>   	s32 o_slope;
> -	s32 vts[MT8173_NUM_SENSORS];
> -
> -};
> -
> -struct mtk_thermal_bank_cfg {
> -	unsigned int num_sensors;
> -	unsigned int sensors[MT8173_NUM_SENSORS_PER_ZONE];
> +	s32 vts[MAX_NUM_BANK];
>   };
>
> -static const int sensor_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
> -
> -/*
> +/**
>    * The MT8173 thermal controller has four banks. Each bank can read up to
>    * four temperature sensors simultaneously. The MT8173 has a total of 5
>    * temperature sensors. We use each bank to measure a certain area of the
> @@ -166,42 +189,76 @@ static const int sensor_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
>    * data, and this indeed needs the temperatures of the individual banks
>    * for making better decisions.
>    */
> -static const struct mtk_thermal_bank_cfg bank_data[] = {
> -	{
> -		.num_sensors = 2,
> -		.sensors = { MT8173_TS2, MT8173_TS3 },
> -	}, {
> -		.num_sensors = 2,
> -		.sensors = { MT8173_TS2, MT8173_TS4 },
> -	}, {
> -		.num_sensors = 3,
> -		.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> -	}, {
> -		.num_sensors = 1,
> -		.sensors = { MT8173_TS2 },
> +static const struct mtk_thermal_data mt8173_thermal_data = {
> +	.auxadc_channel = MT8173_TEMP_AUXADC_CHANNEL,
> +	.num_banks = 4,
> +	.num_sensors = 5,
> +	.bank_data = {
> +		{
> +			.num_sensors = 2,
> +			.sensors = { MT8173_TS2, MT8173_TS3 },
> +		}, {
> +			.num_sensors = 2,
> +			.sensors = { MT8173_TS2, MT8173_TS4 },
> +		}, {
> +			.num_sensors = 3,
> +			.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> +		}, {
> +			.num_sensors = 1,
> +			.sensors = { MT8173_TS2 },
> +		},
>   	},
> +	.sensing_points = {
> +		{
> +			.msr = TEMP_MSR0,
> +			.adcpnp = TEMP_ADCPNP0,
> +		}, {
> +			.msr = TEMP_MSR1,
> +			.adcpnp = TEMP_ADCPNP1,
> +		}, {
> +			.msr = TEMP_MSR2,
> +			.adcpnp = TEMP_ADCPNP2,
> +		}, {
> +			.msr = TEMP_MSR3,
> +			.adcpnp = TEMP_ADCPNP3,
> +		},
> +	},
> +	.sensor_mux_values = { 0, 1, 2, 3, 16 },
>   };
>
> -struct mtk_thermal_sense_point {
> -	int msr;
> -	int adcpnp;
> -};
> -
> -static const struct mtk_thermal_sense_point
> -		sensing_points[MT8173_NUM_SENSORS_PER_ZONE] = {
> -	{
> -		.msr = TEMP_MSR0,
> -		.adcpnp = TEMP_ADCPNP0,
> -	}, {
> -		.msr = TEMP_MSR1,
> -		.adcpnp = TEMP_ADCPNP1,
> -	}, {
> -		.msr = TEMP_MSR2,
> -		.adcpnp = TEMP_ADCPNP2,
> -	}, {
> -		.msr = TEMP_MSR3,
> -		.adcpnp = TEMP_ADCPNP3,
> +/**
> + * The MT2701 thermal controller has one bank, which can read up to
> + * three temperature sensors simultaneously. The MT2701 has a total of 3
> + * temperature sensors.
> + *
> + * The thermal core only gets the maximum temperature of this one bank,
> + * so the bank concept wouldn't be necessary here. However, the SVS (Smart
> + * Voltage Scaling) unit makes its decisions based on the same bank
> + * data.
> + */
> +static const struct mtk_thermal_data mt2701_thermal_data = {
> +	.auxadc_channel = MT2701_TEMP_AUXADC_CHANNEL,
> +	.num_banks = 1,
> +	.num_sensors = 3,
> +	.bank_data = {
> +		{
> +			.num_sensors = 3,
> +			.sensors = { MT2701_TS1, MT2701_TS2, MT2701_TSABB },
> +		},
>   	},
> +	.sensing_points = {
> +		{
> +			.msr = TEMP_MSR0,
> +			.adcpnp = TEMP_ADCPNP0,
> +		}, {
> +			.msr = TEMP_MSR1,
> +			.adcpnp = TEMP_ADCPNP1,
> +		}, {
> +			.msr = TEMP_MSR2,
> +			.adcpnp = TEMP_ADCPNP2,
> +		},
> +	},
> +	.sensor_mux_values = { 0, 1, 16},
>   };
>
>   /**
> @@ -270,13 +327,15 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>   static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   {
>   	struct mtk_thermal *mt = bank->mt;
> +	const struct mtk_thermal_data *conf = mt->conf;
>   	int i, temp = INT_MIN, max = INT_MIN;
>   	u32 raw;
>
> -	for (i = 0; i < bank_data[bank->id].num_sensors; i++) {
> -		raw = readl(mt->thermal_base + sensing_points[i].msr);
> +	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> +		raw = readl(mt->thermal_base + conf->sensing_points[i].msr);
>
> -		temp = raw_to_mcelsius(mt, bank_data[bank->id].sensors[i], raw);
> +		temp = raw_to_mcelsius(mt, conf->bank_data[bank->id].sensors[i],
> +				       raw);
>
>   		/*
>   		 * The first read of a sensor often contains very high bogus
> @@ -299,7 +358,7 @@ static int mtk_read_temp(void *data, int *temperature)
>   	int i;
>   	int tempmax = INT_MIN;
>
> -	for (i = 0; i < MT8173_NUM_ZONES; i++) {
> +	for (i = 0; i < mt->conf->num_banks; i++) {
>   		struct mtk_thermal_bank *bank = &mt->banks[i];
>
>   		mtk_thermal_get_bank(bank);
> @@ -322,7 +381,7 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   				  u32 apmixed_phys_base, u32 auxadc_phys_base)
>   {
>   	struct mtk_thermal_bank *bank = &mt->banks[num];
> -	const struct mtk_thermal_bank_cfg *cfg = &bank_data[num];
> +	const struct mtk_thermal_data *conf = mt->conf;
>   	int i;
>
>   	bank->id = num;
> @@ -368,7 +427,7 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   	 * this value will be stored to TEMP_PNPMUXADDR (TEMP_SPARE0)
>   	 * automatically by hw
>   	 */
> -	writel(BIT(MT8173_TEMP_AUXADC_CHANNEL), mt->thermal_base + TEMP_ADCMUX);
> +	writel(BIT(conf->auxadc_channel), mt->thermal_base + TEMP_ADCMUX);
>
>   	/* AHB address for auxadc mux selection */
>   	writel(auxadc_phys_base + AUXADC_CON1_CLR_V,
> @@ -379,18 +438,18 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   	       mt->thermal_base + TEMP_PNPMUXADDR);
>
>   	/* AHB value for auxadc enable */
> -	writel(BIT(MT8173_TEMP_AUXADC_CHANNEL), mt->thermal_base + TEMP_ADCEN);
> +	writel(BIT(conf->auxadc_channel), mt->thermal_base + TEMP_ADCEN);
>
>   	/* AHB address for auxadc enable (channel 0 immediate mode selected) */
>   	writel(auxadc_phys_base + AUXADC_CON1_SET_V,
>   	       mt->thermal_base + TEMP_ADCENADDR);
>
>   	/* AHB address for auxadc valid bit */
> -	writel(auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
> +	writel(auxadc_phys_base + AUXADC_DATA(conf->auxadc_channel),
>   	       mt->thermal_base + TEMP_ADCVALIDADDR);
>
>   	/* AHB address for auxadc voltage output */
> -	writel(auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
> +	writel(auxadc_phys_base + AUXADC_DATA(conf->auxadc_channel),
>   	       mt->thermal_base + TEMP_ADCVOLTADDR);
>
>   	/* read valid & voltage are at the same register */
> @@ -407,11 +466,12 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   	writel(TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
>   	       mt->thermal_base + TEMP_ADCWRITECTRL);
>
> -	for (i = 0; i < cfg->num_sensors; i++)
> -		writel(sensor_mux_values[cfg->sensors[i]],
> -		       mt->thermal_base + sensing_points[i].adcpnp);
> +	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
> +		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
> +		       mt->thermal_base + conf->sensing_points[i].adcpnp);
>
> -	writel((1 << cfg->num_sensors) - 1, mt->thermal_base + TEMP_MONCTL0);
> +	writel((1 << conf->bank_data[num].num_sensors) - 1,
> +	       mt->thermal_base + TEMP_MONCTL0);
>
>   	writel(TEMP_ADCWRITECTRL_ADC_PNP_WRITE |
>   	       TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
> @@ -442,7 +502,7 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
>
>   	/* Start with default values */
>   	mt->adc_ge = 512;
> -	for (i = 0; i < MT8173_NUM_SENSORS; i++)
> +	for (i = 0; i < mt->conf->num_sensors; i++)
>   		mt->vts[i] = 260;
>   	mt->degc_cali = 40;
>   	mt->o_slope = 0;
> @@ -467,15 +527,15 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
>   		goto out;
>   	}
>
> -	if (buf[0] & MT8173_CALIB_BUF0_VALID) {
> -		mt->adc_ge = MT8173_CALIB_BUF1_ADC_GE(buf[1]);
> -		mt->vts[MT8173_TS1] = MT8173_CALIB_BUF0_VTS_TS1(buf[0]);
> -		mt->vts[MT8173_TS2] = MT8173_CALIB_BUF0_VTS_TS2(buf[0]);
> -		mt->vts[MT8173_TS3] = MT8173_CALIB_BUF1_VTS_TS3(buf[1]);
> -		mt->vts[MT8173_TS4] = MT8173_CALIB_BUF2_VTS_TS4(buf[2]);
> -		mt->vts[MT8173_TSABB] = MT8173_CALIB_BUF2_VTS_TSABB(buf[2]);
> -		mt->degc_cali = MT8173_CALIB_BUF0_DEGC_CALI(buf[0]);
> -		mt->o_slope = MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
> +	if (buf[0] & CALIB_BUF0_VALID) {
> +		mt->adc_ge = CALIB_BUF1_ADC_GE(buf[1]);
> +		mt->vts[NVMEM_TS1] = CALIB_BUF0_VTS_TS1(buf[0]);
> +		mt->vts[NVMEM_TS2] = CALIB_BUF0_VTS_TS2(buf[0]);
> +		mt->vts[NVMEM_TS3] = CALIB_BUF1_VTS_TS3(buf[1]);
> +		mt->vts[NVMEM_TS4] = CALIB_BUF2_VTS_TS4(buf[1]);
> +		mt->vts[NVMEM_TS5] = CALIB_BUF2_VTS_TS5(buf[2]);
> +		mt->degc_cali = CALIB_BUF0_DEGC_CALI(buf[0]);
> +		mt->o_slope = CALIB_BUF0_O_SLOPE(buf[0]);

I guess even the above code changes can be avoided if we just retain 
macros starting with MT8173?

Best Regards,
Keerthy

>   	} else {
>   		dev_info(dev, "Device not calibrated, using default calibration values\n");
>   	}
> @@ -486,18 +546,36 @@ out:
>   	return ret;
>   }
>
> +static const struct of_device_id mtk_thermal_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt8173-thermal",
> +		.data = (void *)&mt8173_thermal_data,
> +	},
> +	{
> +		.compatible = "mediatek,mt2701-thermal",
> +		.data = (void *)&mt2701_thermal_data,
> +	}, {
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
> +
>   static int mtk_thermal_probe(struct platform_device *pdev)
>   {
>   	int ret, i;
>   	struct device_node *auxadc, *apmixedsys, *np = pdev->dev.of_node;
>   	struct mtk_thermal *mt;
>   	struct resource *res;
> +	const struct of_device_id *of_id;
>   	u64 auxadc_phys_base, apmixed_phys_base;
>
>   	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>   	if (!mt)
>   		return -ENOMEM;
>
> +	of_id = of_match_device(mtk_thermal_of_match, &pdev->dev);
> +	if (of_id)
> +		mt->conf = (const struct mtk_thermal_data *)of_id->data;
> +
>   	mt->clk_peri_therm = devm_clk_get(&pdev->dev, "therm");
>   	if (IS_ERR(mt->clk_peri_therm))
>   		return PTR_ERR(mt->clk_peri_therm);
> @@ -565,7 +643,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		goto err_disable_clk_auxadc;
>   	}
>
> -	for (i = 0; i < MT8173_NUM_ZONES; i++)
> +	for (i = 0; i < mt->conf->num_banks; i++)
>   		mtk_thermal_init_bank(mt, i, apmixed_phys_base,
>   				      auxadc_phys_base);
>
> @@ -592,13 +670,6 @@ static int mtk_thermal_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> -static const struct of_device_id mtk_thermal_of_match[] = {
> -	{
> -		.compatible = "mediatek,mt8173-thermal",
> -	}, {
> -	},
> -};
> -
>   static struct platform_driver mtk_thermal_driver = {
>   	.probe = mtk_thermal_probe,
>   	.remove = mtk_thermal_remove,
> @@ -610,6 +681,7 @@ static struct platform_driver mtk_thermal_driver = {
>
>   module_platform_driver(mtk_thermal_driver);
>
> +MODULE_AUTHOR("Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
>   MODULE_AUTHOR("Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
>   MODULE_AUTHOR("Hanyi Wu <hanyi.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
>   MODULE_DESCRIPTION("Mediatek thermal driver");
>

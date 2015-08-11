From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Tue, 11 Aug 2015 15:03:53 +0800
Message-ID: <CAGS+omD9fhmyHEm6jWaWXi3y90Y5VDr6QeFD7tqMLbZpSN3+yw@mail.gmail.com>
References: <1438955751-20778-1-git-send-email-s.hauer@pengutronix.de> <1438955751-20778-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34440 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbbHKHEO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 03:04:14 -0400
Received: by ykdt205 with SMTP id t205so79181180ykd.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 00:04:13 -0700 (PDT)
In-Reply-To: <1438955751-20778-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>

Hi Sascha,

I think this patch looks very good now, just some very tiny things inline...

On Fri, Aug 7, 2015 at 9:55 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
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
>  drivers/thermal/mtk_thermal.c | 581 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 590 insertions(+)
>  create mode 100644 drivers/thermal/mtk_thermal.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 118938e..07ad114 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -340,6 +340,14 @@ config ACPI_THERMAL_REL
>         tristate
>         depends on ACPI
>
> +config MTK_THERMAL
> +       tristate "Temperature sensor driver for mediatek SoCs"
> +       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       default y
> +       help
> +         Enable this option if you want to have support for thermal management
> +         controller present in Mediatek SoCs
> +
>  menu "Texas Instruments thermal drivers"
>  source "drivers/thermal/ti-soc-thermal/Kconfig"
>  endmenu
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 535dfee..cc1cab3 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -44,3 +44,4 @@ obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
>  obj-$(CONFIG_ST_THERMAL)       += st/
>  obj-$(CONFIG_TEGRA_SOCTHERM)   += tegra_soctherm.o
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> +obj-$(CONFIG_MTK_THERMAL)      += mtk_thermal.o
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> new file mode 100644
> index 0000000..1a3829a
> --- /dev/null
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -0,0 +1,581 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Hanyi.Wu <hanyi.wu@mediatek.com>
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
> +
> +/* AUXADC Registers */
> +#define AUXADC_CON0_V          0x000
> +#define AUXADC_CON1_V          0x004
> +#define AUXADC_CON1_SET_V      0x008
> +#define AUXADC_CON1_CLR_V      0x00c
> +#define AUXADC_CON2_V          0x010
> +#define AUXADC_DATA(channel)   (0x14 + (channel) * 4)
> +#define AUXADC_MISC_V          0x094
> +
> +#define AUXADC_CON1_CHANNEL(x) BIT(x)
> +
> +#define APMIXED_SYS_TS_CON1    0x604
> +
> +/* Thermal Controller Registers */
> +#define TEMP_MONCTL0           0x000
> +#define TEMP_MONCTL1           0x004
> +#define TEMP_MONCTL2           0x008
> +#define TEMP_MONINT            0x00c
> +#define TEMP_MONINTSTS         0x010
> +#define TEMP_MONIDET0          0x014
> +#define TEMP_MONIDET1          0x018
> +#define TEMP_MONIDET2          0x01c
> +#define TEMP_H2NTHRE           0x024
> +#define TEMP_HTHRE             0x028
> +#define TEMP_CTHRE             0x02c
> +#define TEMP_OFFSETH           0x030
> +#define TEMP_OFFSETL           0x034
> +#define TEMP_MSRCTL0           0x038
> +#define TEMP_MSRCTL1           0x03c
> +#define TEMP_AHBPOLL           0x040
> +#define TEMP_AHBTO             0x044
> +#define TEMP_ADCPNP0           0x048
> +#define TEMP_ADCPNP1           0x04c
> +#define TEMP_ADCPNP2           0x050
> +#define TEMP_ADCPNP3           0x0b4
> +
> +#define TEMP_ADCMUX            0x054
> +#define TEMP_ADCEXT            0x058
> +#define TEMP_ADCEXT1           0x05c
> +#define TEMP_ADCEN             0x060
> +#define TEMP_PNPMUXADDR                0x064
> +#define TEMP_ADCMUXADDR                0x068
> +#define TEMP_ADCEXTADDR                0x06c
> +#define TEMP_ADCEXT1ADDR       0x070
> +#define TEMP_ADCENADDR         0x074
> +#define TEMP_ADCVALIDADDR      0x078
> +#define TEMP_ADCVOLTADDR       0x07c
> +#define TEMP_RDCTRL            0x080
> +#define TEMP_ADCVALIDMASK      0x084
> +#define TEMP_ADCVOLTAGESHIFT   0x088
> +#define TEMP_ADCWRITECTRL      0x08c
> +#define TEMP_MSR0              0x090
> +#define TEMP_MSR1              0x094
> +#define TEMP_MSR2              0x098
> +#define TEMP_MSR3              0x0B8
> +
> +#define TEMP_IMMD0             0x0a0
> +#define TEMP_IMMD1             0x0a4
> +#define TEMP_IMMD2             0x0a8
> +
> +#define TEMP_PROTCTL           0x0c0
> +#define TEMP_PROTTA            0x0c4
> +#define TEMP_PROTTB            0x0c8
> +#define TEMP_PROTTC            0x0cc
> +
> +#define TEMP_SPARE0            0x0f0
> +#define TEMP_SPARE1            0x0f4
> +#define TEMP_SPARE2            0x0f8
> +#define TEMP_SPARE3            0x0fc
> +
> +#define PTPCORESEL             0x400
> +#define THERMINTST             0x404
> +#define PTPODINTST             0x408
> +#define THSTAGE0ST             0x40c
> +#define THSTAGE1ST             0x410
> +#define THSTAGE2ST             0x414
> +#define THAHBST0               0x418
> +#define THAHBST1               0x41c   /* Only for DE debug */
> +#define PTPSPARE0              0x420
> +#define PTPSPARE1              0x424
> +#define PTPSPARE2              0x428
> +#define PTPSPARE3              0x42c
> +#define THSLPEVEB              0x430
> +
> +#define TEMP_MONCTL1_PERIOD_UNIT(x)    ((x) & 0x3ff)
> +
> +#define TEMP_MONCTL2_FILTER_INTERVAL(x)        (((x) & 0x3ff)) << 16
> +#define TEMP_MONCTL2_SENSOR_INTERVAL(x)        ((x) & 0x3ff)
> +
> +#define TEMP_AHBPOLL_ADC_POLL_INTERVAL(x)      (x)
> +
> +#define TEMP_MONINT_COLD(sp)                   (BIT(0) << ((sp) * 5))
> +#define TEMP_MONINT_HOT(sp)                    (BIT(1) << ((sp) * 5))
> +#define TEMP_MONINT_LOW_OFS(sp)                        (BIT(2) << ((sp) * 5))
> +#define TEMP_MONINT_HIGH_OFS(sp)               (BIT(3) << ((sp) * 5))
> +#define TEMP_MONINT_HOT_TO_NORM(sp)            (BIT(4) << ((sp) * 5))
> +#define TEMP_MONINT_TIMEOUT                    BIT(15)
> +#define TEMP_MONINT_IMMEDIATE_SENSE(sp)                BIT(16 + (sp))
> +#define TEMP_MONINT_FILTER_SENSE(sp)           BIT(19 + (sp))
> +
> +#define TEMP_ADCWRITECTRL_ADC_PNP_WRITE                BIT(0)
> +#define TEMP_ADCWRITECTRL_ADC_MUX_WRITE                BIT(1)
> +#define TEMP_ADCWRITECTRL_ADC_EXTRA_WRITE      BIT(2)
> +#define TEMP_ADCWRITECTRL_ADC_EXTRA1_WRITE     BIT(3)
> +
> +#define TEMP_ADCVALIDMASK_VALID_HIGH           BIT(5)
> +#define TEMP_ADCVALIDMASK_VALID_POS(bit)       (bit)
> +
> +#define TEMP_PROTCTL_AVERAGE                   (0 << 16)
> +#define TEMP_PROTCTL_MAXIMUM                   (1 << 16)
> +#define TEMP_PROTCTL_SELECTED                  (2 << 16)
> +
> +#define MT8173_TS1     0
> +#define MT8173_TS2     1
> +#define MT8173_TS3     2
> +#define MT8173_TS4     3
> +#define MT8173_TSABB   4
> +
> +/* AUXADC channel 11 is used for the temperature sensors */
> +#define MT8173_TEMP_AUXADC_CHANNEL     11
> +
> +/* The total number of temperature sensors in the MT8173 */
> +#define MT8173_NUM_SENSORS             5
> +
> +/* The number of banks in the MT8173 */
> +#define MT8173_NUM_ZONES               4
> +
> +/* The number of sensing points per bank */
> +#define MT8173_NUM_SENSORS_PER_ZONE    4

Aw well... since you left "bank" in all of the comments, variable
names and function names, I now regret suggesting you change these
macro names.  For consistency, I think we should change the macro
names back to:

 MT8173_NUM_BANKS

and

 MT8173_NUM_SENSORS_PER_BANK


 since you only changed the names for these constants, perhaps

> +
> +#define THERMAL_NAME    "mtk-thermal"
> +
> +struct mtk_thermal;
> +
> +struct mtk_thermal_bank {
> +       struct mtk_thermal *mt;
> +       struct thermal_zone_device *tzd;
> +       int id;
> +};
> +
> +struct mtk_thermal {
> +       struct device *dev;
> +       void __iomem *thermal_base;
> +
> +       struct clk *clk_peri_therm;
> +       struct clk *clk_auxadc;
> +
> +       struct mtk_thermal_bank banks[MT8173_NUM_ZONES];
> +
> +       struct mutex lock;
> +
> +       /* Calibration values */
> +       int calib_a;
> +       int calib_b;

Rather than "a" and "b", these should probably names something like
"offset" and "slope".

Since these are properties of the hardware (board? SoC?), perhaps it
makes sense to allow setting them in devicetree?

> +};
> +
> +struct mtk_thermal_bank_cfg {
> +       unsigned int num_sensors;
> +       unsigned int sensors[MT8173_NUM_SENSORS_PER_ZONE];
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
> +       {
> +               .num_sensors = 2,
> +               .sensors = { MT8173_TS2, MT8173_TS3 },
> +       }, {
> +               .num_sensors = 2,
> +               .sensors = { MT8173_TS2, MT8173_TS4 },
> +       }, {
> +               .num_sensors = 3,
> +               .sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> +       }, {
> +               .num_sensors = 1,
> +               .sensors = { MT8173_TS2 },
> +       },
> +};
> +
> +struct mtk_thermal_sense_point {
> +       int msr;
> +       int adcpnp;
> +};
> +
> +static const struct mtk_thermal_sense_point
> +               sensing_points[MT8173_NUM_SENSORS_PER_ZONE] = {
> +       {
> +               .msr = TEMP_MSR0,
> +               .adcpnp = TEMP_ADCPNP0,
> +       }, {
> +               .msr = TEMP_MSR1,
> +               .adcpnp = TEMP_ADCPNP1,
> +       }, {
> +               .msr = TEMP_MSR2,
> +               .adcpnp = TEMP_ADCPNP2,
> +       }, {
> +               .msr = TEMP_MSR3,
> +               .adcpnp = TEMP_ADCPNP3,
> +       },
> +};
> +
> +/**
> + * raw_to_mcelsius - convert a raw ADC value to mcelsius
> + * @mt:                The thermal controller
> + * @raw:       raw ADC value
> + *
> + * This converts the raw ADC value to mcelsius using the SoC specific
> + * calibration constants
> + */
> +static int raw_to_mcelsius(struct mtk_thermal *mt, u32 raw)
> +{
> +       return mt->calib_b + mt->calib_a * (raw & 0xfff);
> +}
> +
> +/**
> + * mtk_thermal_get_bank - get bank
> + * @bank:      The bank
> + *
> + * The bank registers are banked, we have to select a bank in the
> + * PTPCORESEL register to access it.
> + */
> +static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
> +{
> +       struct mtk_thermal *mt = bank->mt;
> +       u32 val;
> +
> +       mutex_lock(&mt->lock);
> +
> +       val = readl(mt->thermal_base + PTPCORESEL);
> +       val &= ~0xf;
> +       val |= bank->id;
> +       writel(val, mt->thermal_base + PTPCORESEL);
> +}
> +
> +/**
> + * mtk_thermal_put_bank - release bank
> + * @bank:      The bank
> + *
> + * release a bank previously taken with mtk_thermal_get_bank,
> + */
> +static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
> +{
> +       struct mtk_thermal *mt = bank->mt;
> +
> +       mutex_unlock(&mt->lock);
> +}
> +
> +/**
> + * mtk_thermal_bank_temperature - get the temperature of a bank
> + * @bank:      The bank
> + *
> + * The temperature of a bank is considered the maximum temperature of
> + * the sensors associated to the bank.
> + */
> +static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
> +{
> +       struct mtk_thermal *mt = bank->mt;
> +       int temp, i, max;
> +       u32 raw;
> +
> +       temp = max = INT_MIN;
> +
> +       for (i = 0; i < bank_data[bank->id].num_sensors; i++) {
> +               raw = readl(mt->thermal_base + sensing_points[i].msr);
> +
> +               temp = raw_to_mcelsius(mt, raw);
> +
> +               /*
> +                * The first read of a sensor often contains very high bogus
> +                * temperature value. Filter these out so that the system does
> +                * not immediately shut down.
> +                */
> +               if (temp > 200000)
> +                       temp = 0;
> +
> +               if (temp > max)
> +                       max = temp;
> +       }
> +
> +       return max;
> +}
> +
> +static int mtk_read_temp(void *data, long *temp)
> +{
> +       struct mtk_thermal_bank *bank = data;
> +
> +       mtk_thermal_get_bank(bank);
> +
> +       *temp = mtk_thermal_bank_temperature(bank);
> +
> +       mtk_thermal_put_bank(bank);
> +
> +       return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
> +       .get_temp = mtk_read_temp,
> +};
> +
> +static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
> +               u32 apmixed_phys_base, u32 auxadc_phys_base)
> +{
> +       struct mtk_thermal_bank *bank = &mt->banks[num];
> +       const struct mtk_thermal_bank_cfg *cfg = &bank_data[num];
> +       int i;
> +
> +       bank->id = num;
> +       bank->mt = mt;
> +
> +       mtk_thermal_get_bank(bank);
> +
> +       /* bus clock 66M counting unit is 12 * 15.15ns * 256 = 46.540us */
> +       writel(TEMP_MONCTL1_PERIOD_UNIT(12), mt->thermal_base + TEMP_MONCTL1);
> +
> +       /*
> +        * filt interval is 1 * 46.540us = 46.54us,
> +        * sen interval is 429 * 46.540us = 19.96ms
> +        */
> +       writel(TEMP_MONCTL2_FILTER_INTERVAL(1) |
> +                       TEMP_MONCTL2_SENSOR_INTERVAL(429),
> +                       mt->thermal_base + TEMP_MONCTL2);
> +
> +       /* poll is set to 10u */
> +       writel(TEMP_AHBPOLL_ADC_POLL_INTERVAL(768),
> +                       mt->thermal_base + TEMP_AHBPOLL);
> +
> +       /* temperature sampling control, 1 sample */
> +       writel(0x00000000, mt->thermal_base + TEMP_MSRCTL0);
> +
> +       /* exceed this polling time, IRQ would be inserted */
> +       writel(0xffffffff, mt->thermal_base + TEMP_AHBTO);
> +
> +       /* number of interrupts per event, 1 is enough */
> +       writel(0x0, mt->thermal_base + TEMP_MONIDET0);
> +       writel(0x0, mt->thermal_base + TEMP_MONIDET1);
> +
> +       /*
> +        * The MT8173 thermal controller does not have its own ADC. Instead it
> +        * uses AHB bus accesses to control the AUXADC. To do this the thermal
> +        * controller has to be programmed with the physical addresses of the
> +        * AUXADC registers and with the various bit positions in the AUXADC.
> +        * Also the thermal controller controls a mux in the APMIXEDSYS register
> +        * space.
> +        */
> +
> +       /*
> +        * this value will be stored to TEMP_PNPMUXADDR (TEMP_SPARE0)
> +        * automatically by hw
> +        */
> +       writel(BIT(MT8173_TEMP_AUXADC_CHANNEL), mt->thermal_base + TEMP_ADCMUX);
> +
> +       /* AHB address for auxadc mux selection */
> +       writel(auxadc_phys_base + 0x00c, mt->thermal_base + TEMP_ADCMUXADDR);

Can you define a AUXADC_ constant for this "0x00c"?

> +
> +       /* AHB address for pnp sensor mux selection */
> +       writel(apmixed_phys_base + APMIXED_SYS_TS_CON1,
> +                       mt->thermal_base + TEMP_PNPMUXADDR);
> +
> +       /* AHB value for auxadc enable */
> +       writel(BIT(MT8173_TEMP_AUXADC_CHANNEL), mt->thermal_base + TEMP_ADCEN);
> +
> +       /* AHB address for auxadc enable (channel 0 immediate mode selected) */
> +       writel(auxadc_phys_base + AUXADC_CON1_SET_V,
> +                       mt->thermal_base + TEMP_ADCENADDR);
> +
> +       /* AHB address for auxadc valid bit */
> +       writel(auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
> +                       mt->thermal_base + TEMP_ADCVALIDADDR);
> +
> +       /* AHB address for auxadc voltage output */
> +       writel(auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
> +                       mt->thermal_base + TEMP_ADCVOLTADDR);
> +
> +       /* read valid & voltage are at the same register */
> +       writel(0x0, mt->thermal_base + TEMP_RDCTRL);
> +
> +       /* indicate where the valid bit is */
> +       writel(TEMP_ADCVALIDMASK_VALID_HIGH | TEMP_ADCVALIDMASK_VALID_POS(12),
> +                       mt->thermal_base + TEMP_ADCVALIDMASK);
> +
> +       /* no shift */
> +       writel(0x0, mt->thermal_base + TEMP_ADCVOLTAGESHIFT);
> +
> +       /* enable auxadc mux write transaction */
> +       writel(TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
> +                       mt->thermal_base + TEMP_ADCWRITECTRL);
> +
> +       for (i = 0; i < cfg->num_sensors; i++)
> +               writel(sensor_mux_values[cfg->sensors[i]],
> +                               mt->thermal_base + sensing_points[i].adcpnp);
> +
> +       writel((1 << cfg->num_sensors) - 1, mt->thermal_base + TEMP_MONCTL0);
> +
> +       writel(TEMP_ADCWRITECTRL_ADC_PNP_WRITE | TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
> +                       mt->thermal_base + TEMP_ADCWRITECTRL);
> +
> +       mtk_thermal_put_bank(bank);
> +}
> +
> +static u64 of_get_phys_base(struct device_node *np)
> +{
> +       u64 size64;
> +       const __be32 *regaddr_p;
> +
> +       regaddr_p = of_get_address(np, 0, &size64, NULL);
> +       if (!regaddr_p)
> +               return OF_BAD_ADDR;
> +
> +       return of_translate_address(np, regaddr_p);
> +}
> +
> +static int mtk_thermal_probe(struct platform_device *pdev)
> +{
> +       int ret, i;
> +       struct device_node *auxadc, *apmixedsys, *np = pdev->dev.of_node;
> +       struct mtk_thermal *mt;
> +       struct resource *res;
> +       u64 auxadc_phys_base, apmixed_phys_base;
> +
> +       mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
> +       if (!mt)
> +               return -ENOMEM;
> +
> +       mt->clk_peri_therm = devm_clk_get(&pdev->dev, "therm");
> +       if (IS_ERR(mt->clk_peri_therm))
> +               return PTR_ERR(mt->clk_peri_therm);
> +
> +       mt->clk_auxadc = devm_clk_get(&pdev->dev, "auxadc");
> +       if (IS_ERR(mt->clk_auxadc))
> +               return PTR_ERR(mt->clk_auxadc);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       mt->thermal_base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(mt->thermal_base))
> +               return PTR_ERR(mt->thermal_base);
> +
> +       mutex_init(&mt->lock);
> +
> +       mt->dev = &pdev->dev;
> +
> +       auxadc = of_parse_phandle(np, "mediatek,auxadc", 0);
> +       if (!auxadc) {
> +               dev_err(&pdev->dev, "missing auxadc node\n");
> +               return -ENODEV;
> +       }
> +
> +       auxadc_phys_base = of_get_phys_base(auxadc);
> +       if (auxadc_phys_base == OF_BAD_ADDR) {
> +               dev_err(&pdev->dev, "Can't get auxadc phys address\n");
> +               return -EINVAL;
> +       }
> +
> +       apmixedsys = of_parse_phandle(np, "mediatek,apmixedsys", 0);
> +       if (!apmixedsys) {
> +               dev_err(&pdev->dev, "missing apmixedsys node\n");
> +               return -ENODEV;
> +       }
> +
> +       apmixed_phys_base = of_get_phys_base(apmixedsys);
> +       if (apmixed_phys_base == OF_BAD_ADDR) {
> +               dev_err(&pdev->dev, "Can't get auxadc phys address\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = clk_prepare_enable(mt->clk_auxadc);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = device_reset(&pdev->dev);
> +       if (ret)
> +               goto err_disable_clk_auxadc;
> +
> +       ret = clk_prepare_enable(mt->clk_peri_therm);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
> +               goto err_disable_clk_auxadc;
> +       }

Seems like the temp sensor and ADC will always be on and clocked, even
if not used.
Does it make sense to give this driver runtime_pm support to disable
the sensor and its clocks between temperature readings?  (Doesn't need
to be added in this patch, of course.

That's it!  Thanks for spinning (and re-spinning, ...) the patches!

-Dan

> +
> +       /*
> +        * These calibration values should finally be provided by the
> +        * firmware or fuses. For now use default values.
> +        */
> +       mt->calib_a = -123;
> +       mt->calib_b = 465124;
> +
> +       for (i = 0; i < MT8173_NUM_ZONES; i++)
> +               mtk_thermal_init_bank(mt, i, apmixed_phys_base, auxadc_phys_base);
> +
> +       platform_set_drvdata(pdev, mt);
> +
> +       for (i = 0; i < MT8173_NUM_ZONES; i++) {
> +               struct mtk_thermal_bank *bank = &mt->banks[i];
> +
> +               bank->tzd = thermal_zone_of_sensor_register(&pdev->dev, i, bank,
> +                               &mtk_thermal_ops);
> +       }
> +
> +       return 0;
> +
> +err_disable_clk_auxadc:
> +       clk_disable_unprepare(mt->clk_auxadc);
> +
> +       return ret;
> +}
> +
> +static int mtk_thermal_remove(struct platform_device *pdev)
> +{
> +       struct mtk_thermal *mt = platform_get_drvdata(pdev);
> +       int i;
> +
> +       for (i = 0; i < MT8173_NUM_ZONES; i++) {
> +               struct mtk_thermal_bank *bank = &mt->banks[i];
> +
> +               thermal_zone_of_sensor_unregister(&pdev->dev, bank->tzd);
> +       }
> +
> +       clk_disable_unprepare(mt->clk_peri_therm);
> +       clk_disable_unprepare(mt->clk_auxadc);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_thermal_of_match[] = {
> +       {
> +               .compatible = "mediatek,mt8173-thermal",
> +       }, {
> +       },
> +};
> +
> +static struct platform_driver mtk_thermal_driver = {
> +       .probe = mtk_thermal_probe,
> +       .remove = mtk_thermal_remove,
> +       .driver = {
> +               .name = THERMAL_NAME,
> +               .of_match_table = mtk_thermal_of_match,
> +       },
> +};
> +
> +module_platform_driver(mtk_thermal_driver);
> +
> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de");
> +MODULE_DESCRIPTION("Mediatek thermal driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.4.6
>

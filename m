From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Tue, 21 Jul 2015 23:13:22 +0800
Message-ID: <CAGS+omAsTBMhfLPs5V68Ou1E5WXnQzZ3_E5+9qCCbAja3dgY-w@mail.gmail.com>
References: <1437465566-16299-1-git-send-email-s.hauer@pengutronix.de> <1437465566-16299-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437465566-16299-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, "Hanyi.Wu" <hanyi.wu@mediatek.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sasha Hauer <kernel@pengutronix.de>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Sascha,

Review comments inline...

On Tue, Jul 21, 2015 at 3:59 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instead
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/thermal/mediatek-thermal.txt          |   8 +-
>  drivers/thermal/Kconfig                            |   8 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/mtk_thermal.c                      | 602 +++++++++++++++++++++
>  4 files changed, 615 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/thermal/mtk_thermal.c
>
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> index d90e4dc..c425a0f 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> @@ -18,8 +18,8 @@ Required properties:
>  - resets, reset-names: Reference to the reset controller controlling the thermal
>                         controller. Required reset-names:
>                 "therm":        The main reset line
> -- auxadc: A phandle to the AUXADC which the thermal controller uses
> -- apmixedsys: A phandle to the APMIXEDSYS controller.
> +- mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
> +- mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description

I think you meant to squash these Documentation hunks into patch 1.

>
>  Example:
> @@ -33,6 +33,6 @@ Example:
>                 clock-names = "therm", "auxadc";
>                 resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
>                 reset-names = "therm";
> -               auxadc = <&auxadc>;
> -               apmixedsys = <&apmixedsys>;
> +               mediatek,auxadc = <&auxadc>;
> +               mediatek,apmixedsys = <&apmixedsys>;
>         };
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
> index 0000000..2f177b5
> --- /dev/null
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -0,0 +1,602 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Hanyi.Wu <hanyi.wu@mediatek.com>

Should this patch be SOB by Hanyi.Wu <hanyi.wu@mediatek.com> ?

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
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/dmi.h>
> +#include <linux/thermal.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/time.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/interrupt.h>
> +#include <linux/reset.h>

nit: some folks like to see #includes alphabetized.

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
> +#define AUXADC_CON1_CHANNEL(x) (1 << (x))

Or just use BIT() ?

> +
> +/* Thermal Controller Registers */
> +#define TEMPMONCTL0            0x000

nit: "TEMP_" might makes these register names a bit more readable.

> +#define TEMPMONCTL1            0x004
> +#define TEMPMONCTL2            0x008
> +#define TEMPMONINT             0x00c
> +#define TEMPMONINTSTS          0x010
> +#define TEMPMONIDET0           0x014
> +#define TEMPMONIDET1           0x018
> +#define TEMPMONIDET2           0x01c
> +#define TEMPH2NTHRE            0x024
> +#define TEMPHTHRE              0x028
> +#define TEMPCTHRE              0x02c
> +#define TEMPOFFSETH            0x030
> +#define TEMPOFFSETL            0x034
> +#define TEMPMSRCTL0            0x038
> +#define TEMPMSRCTL1            0x03c
> +#define TEMPAHBPOLL            0x040
> +#define TEMPAHBTO              0x044
> +#define TEMPADCPNP0            0x048
> +#define TEMPADCPNP1            0x04c
> +#define TEMPADCPNP2            0x050
> +#define TEMPADCPNP3            0x0b4
> +
> +#define TEMPADCMUX             0x054
> +#define TEMPADCEXT             0x058
> +#define TEMPADCEXT1            0x05c
> +#define TEMPADCEN              0x060
> +#define TEMPPNPMUXADDR         0x064
> +#define TEMPADCMUXADDR         0x068
> +#define TEMPADCEXTADDR         0x06c
> +#define TEMPADCEXT1ADDR                0x070
> +#define TEMPADCENADDR          0x074
> +#define TEMPADCVALIDADDR       0x078
> +#define TEMPADCVOLTADDR                0x07c
> +#define TEMPRDCTRL             0x080
> +#define TEMPADCVALIDMASK       0x084
> +#define TEMPADCVOLTAGESHIFT    0x088
> +#define TEMPADCWRITECTRL       0x08c
> +#define TEMPMSR0               0x090
> +#define TEMPMSR1               0x094
> +#define TEMPMSR2               0x098
> +#define TEMPMSR3               0x0B8
> +
> +#define TEMPIMMD0              0x0a0
> +#define TEMPIMMD1              0x0a4
> +#define TEMPIMMD2              0x0a8
> +
> +#define TEMPPROTCTL            0x0c0
> +#define TEMPPROTTA             0x0c4
> +#define TEMPPROTTB             0x0c8
> +#define TEMPPROTTC             0x0cc
> +
> +#define TEMPSPARE0             0x0f0
> +#define TEMPSPARE1             0x0f4
> +#define TEMPSPARE2             0x0f8
> +#define TEMPSPARE3             0x0fc
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
> +#define TEMPMONINT_COLD(sp)                    ((1 << 0) << ((sp) * 5))
> +#define TEMPMONINT_HOT(sp)                     ((1 << 1) << ((sp) * 5))
> +#define TEMPMONINT_LOW_OFS(sp)                 ((1 << 2) << ((sp) * 5))
> +#define TEMPMONINT_HIGH_OFS(sp)                        ((1 << 3) << ((sp) * 5))
> +#define TEMPMONINT_HOT_TO_NORM(sp)             ((1 << 4) << ((sp) * 5))
> +#define TEMPMONINT_TIMEOUT                     (1 << 15)
> +#define TEMPMONINT_IMMEDIATE_SENSE(sp)         (1 << (16 + (sp)))
> +#define TEMPMONINT_FILTER_SENSE(sp)            (1 << (19 + (sp)))

Some clever use of BIT() could clean these up.

> +
> +#define TEMPADCWRITECTRL_ADC_PNP_WRITE         (1 << 0)
> +#define TEMPADCWRITECTRL_ADC_MUX_WRITE         (1 << 1)
> +#define TEMPADCWRITECTRL_ADC_EXTRA_WRITE       (1 << 2)
> +#define TEMPADCWRITECTRL_ADC_EXTRA1_WRITE      (1 << 3)

BIT()

> +
> +#define TEMPADCVALIDMASK_VALID_HIGH            (1 << 5)
> +#define TEMPADCVALIDMASK_VALID_POS(bit)                (bit)
> +
> +#define TEMPPROTCTL_AVERAGE                    (0 << 16)
> +#define TEMPPROTCTL_MAXIMUM                    (1 << 16)
> +#define TEMPPROTCTL_SELECTED                   (2 << 16)
> +
> +#define MT8173_THERMAL_ZONE_CA57               0
> +#define MT8173_THERMAL_ZONE_CA53               1
> +#define MT8173_THERMAL_ZONE_GPU                        2
> +#define MT8173_THERMAL_ZONE_CORE               3

These 4 MT8173_THERMAL_ZONE_* defines are not used.
Do they refer to the same zones as "MT8173_TS1", etc?
If so, I actually like them better, since they are more descriptive.

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
> +#define MT8173_NUM_BANKS               4
> +
> +/* The number of sensing points per bank */
> +#define MT8173_NUM_SENSING_POINTS      4
> +
> +#define THERMAL_NAME    "mtk-thermal"
> +
> +struct mtk_thermal;
> +
> +struct mtk_thermal_bank {
> +       struct mtk_thermal *mt;
> +       struct thermal_zone_device *tz;
> +       int id;
> +};
> +
> +struct mtk_thermal {
> +       struct device *dev;
> +       void __iomem *thermal_base;
> +       void __iomem *auxadc_base;

auxadc_base is never used.

> +
> +       u64 auxadc_phys_base;
> +       u64 apmixed_phys_base;
> +       struct reset_control *reset;

these three are only used during probe->bank_init(), so don't store
them in struct mtk_thermal.

> +       struct clk *clk_peri_therm;
> +       struct clk *clk_auxadc;
> +
> +       struct mtk_thermal_bank banks[MT8173_NUM_BANKS];
> +
> +       struct mutex lock;
> +
> +       /* Calibration values */
> +       s32 adc_ge;
> +       s32 adc_oe;
> +       s32 degc_cali;
> +       s32 o_slope;
> +       s32 vts;
> +};
> +
> +struct mtk_thermal_bank_cfg {
> +       unsigned int enable_mask;

A simple sensor count would be more clear than enable_mask.

> +       unsigned int sensors[4];

MT8173_NUM_SENSING_POINTS perhaps?

> +};
> +
> +static int sensor_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
> +
> +/*
> + * The MT8173 thermal controller has four banks. Each bank can read up to
> + * four temperature sensors simultaneously. The MT8173 has a total of 5
> + * temperature sensors. We use each bank to measure a certain area of the
> + * SoC. Since TS2 is located centrally in the SoC it is influenced by multiple
> + * areas, hence is used in different banks.
> + */
> +static struct mtk_thermal_bank_cfg bank_data[] = {

static const struct

> +       {
> +               .enable_mask = 3,
> +               .sensors = { MT8173_TS2, MT8173_TS3 },
> +       }, {
> +               .enable_mask = 3,
> +               .sensors = { MT8173_TS2, MT8173_TS4 },
> +       }, {
> +               .enable_mask = 7,
> +               .sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> +       }, {
> +               .enable_mask = 1,
> +               .sensors = { MT8173_TS2 },
> +       },
> +};
> +
> +static int tempmsr_ofs[MT8173_NUM_SENSING_POINTS] = {
const
> +       TEMPMSR0, TEMPMSR1, TEMPMSR2, TEMPMSR3
> +};
> +
> +static int tempadcpnp_ofs[MT8173_NUM_SENSING_POINTS] = {
const
> +       TEMPADCPNP0, TEMPADCPNP1, TEMPADCPNP2, TEMPADCPNP3
> +};

These two arrays are tightly coupled, so perhaps it would be useful to
create a struct to represent a sense point:

struct mtk_thermal_sense_point {
  int msr;
  int adcpnp;
};

static const struct mtk_thermal_sense_point[MT8173_NUM_SENSING_POINTS] = {
  { TEMP_MSR0, TEMP_ADCPNP0 },
  { TEMP_MSR1, TEMP_ADCPNP1 },
  { TEMP_MSR2, TEMP_ADCPNP2 },
  { TEMP_MSR3, TEMP_ADCPNP3 },
};

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
> +       s32 format_1, format_2, format_3, format_4;

The formula would be easier to follow with better variable names than
"format_X".

> +       s32 xtoomt;

What does "xtoomt" mean?

> +       s32 gain;
> +
> +       raw &= 0xfff;
> +
> +       gain = (10000 + mt->adc_ge);

no outer ()

> +
> +       xtoomt = ((((mt->vts + 3350 - mt->adc_oe) * 10000) / 4096) * 10000) /
> +               gain;
> +
> +       format_1 = ((mt->degc_cali * 10) >> 1);

When doing computations, I think "A / 2" is preferred over "A >> 1".
Also, no outer ().

> +       format_2 = (raw - mt->adc_oe);
> +       format_3 = (((((format_2) * 10000) >> 12) * 10000) / gain) - xtoomt;

This is just:
  format_3 = ((((raw - mt->vts - 3350) * 10000) / 4096) * 10000) / gain;

No wonder mt->adc_oe = 512-512 = 0... it just cancels itself out here, anyway.

> +       format_3 = format_3 * 15 / 18;

Of course we should multiply by 15/18!
What is going on here?  Why this magic 5/6 ratio?

> +       format_4 = ((format_3 * 100) / (165 + mt->o_slope));

no outer ()

> +       format_4 = format_4 - (format_4 << 1);

Hmm...
 A = X - 2*X;
otherwise known as:
 A = -X;

> +       return (format_1 + format_4) * 100;

Or just:
  return (format_1 - format_4) * 100;

> +
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
> +       temp = max = -INT_MAX;

nit: INT_MIN?

> +
> +       for (i = 0; i < MT8173_NUM_SENSING_POINTS; i++) {

If enable_mask became sensor_count, this would become:

    for (i = 0; i < bank_data[bank->id].sensor_count; i++) {

> +               int sensno;
> +
> +               if (!(bank_data[bank->id].enable_mask & (1 << i)))
> +                       continue;
> +
> +               raw = readl(mt->thermal_base + tempmsr_ofs[i]);
> +
> +               sensno = bank_data[bank->id].sensors[i];

sensno is set but not used.

> +               temp = raw_to_mcelsius(mt, raw);
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
> +       /*
> +        * The first read of a sensor often contains very high bogus temperature
> +        * value. Filter these out so that the system does not immediately shut
> +        * down.
> +        */
> +       if (*temp > 200000)
> +               *temp = 0;

Why not just put this limiter in mtk_thermal_bank_temperature(), and
discard bogus sense points?
Since mtk_thermal_bank_temperature() returns the max of all sense
points, any one bogus sense point will cause a bogus temperature.

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
> +static void mtk_thermal_init_bank(struct mtk_thermal_bank *bank)
> +{
> +       struct mtk_thermal *mt = bank->mt;
> +       struct mtk_thermal_bank_cfg *cfg = &bank_data[bank->id];
> +       int i;
> +
> +       mtk_thermal_get_bank(bank);
> +
> +       /* bus clock 66M counting unit is 12 * 15.15ns * 256 = 46.540us */
> +       writel(0x0000000c, mt->thermal_base + TEMPMONCTL1);

Please create some #defines for the register bits that are written in
this function.

> +
> +       /*
> +        * filt interval is 1 * 46.540us = 46.54us,
> +        * sen interval is 429 * 46.540us = 19.96ms
> +        */
> +       writel(0x000101ad, mt->thermal_base + TEMPMONCTL2);
> +
> +       /* poll is set to 10u */
> +       writel(0x00000300, mt->thermal_base + TEMPAHBPOLL);
> +
> +       /* temperature sampling control, 1 sample */
> +       writel(0x00000000, mt->thermal_base + TEMPMSRCTL0);
> +
> +       /* exceed this polling time, IRQ would be inserted */
> +       writel(0xffffffff, mt->thermal_base + TEMPAHBTO);
> +
> +       /* number of interrupts per event, 1 is enough */
> +       writel(0x0, mt->thermal_base + TEMPMONIDET0);
> +       writel(0x0, mt->thermal_base + TEMPMONIDET1);
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
> +        * this value will be stored to TEMPPNPMUXADDR (TEMPSPARE0)
> +        * automatically by hw
> +        */
> +       writel(1 << MT8173_TEMP_AUXADC_CHANNEL, mt->thermal_base + TEMPADCMUX);
> +
> +       /* AHB address for auxadc mux selection */
> +       writel(mt->auxadc_phys_base + 0x00c,

Is this "0x00c" : AUXADC_CON1_CLR_V ?

Since auxadc_phys_base is only used during probe()->init_bank(), don't
store it in mt.

> +                       mt->thermal_base + TEMPADCMUXADDR);
> +
> +       /* AHB address for pnp sensor mux selection */
> +       writel(mt->apmixed_phys_base + 0x0604,

What is the name of the APMIXED register with offset "0x0604"?

Since apmixed_phys_base is only used during probe()->init_bank(),
don't store it in mt.

> +                       mt->thermal_base + TEMPPNPMUXADDR);
> +
> +       /* AHB value for auxadc enable */
> +       writel(1 << MT8173_TEMP_AUXADC_CHANNEL, mt->thermal_base + TEMPADCEN);
> +
> +       /* AHB address for auxadc enable (channel 0 immediate mode selected) */
> +       writel(mt->auxadc_phys_base + AUXADC_CON1_SET_V,
> +                       mt->thermal_base + TEMPADCENADDR);
> +
> +       /* AHB address for auxadc valid bit */
> +       writel(mt->auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
> +                       mt->thermal_base + TEMPADCVALIDADDR);
> +
> +       /* AHB address for auxadc voltage output */
> +       writel(mt->auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
> +                       mt->thermal_base + TEMPADCVOLTADDR);
> +
> +       /* read valid & voltage are at the same register */
> +       writel(0x0, mt->thermal_base + TEMPRDCTRL);
> +
> +       /* indicate where the valid bit is */
> +       writel(TEMPADCVALIDMASK_VALID_HIGH | TEMPADCVALIDMASK_VALID_POS(12),
> +                       mt->thermal_base + TEMPADCVALIDMASK);
> +
> +       /* no shift */
> +       writel(0x0, mt->thermal_base + TEMPADCVOLTAGESHIFT);
> +
> +       /* enable auxadc mux write transaction */
> +       writel(TEMPADCWRITECTRL_ADC_MUX_WRITE,
> +                       mt->thermal_base + TEMPADCWRITECTRL);
> +
> +       for (i = 0; i < MT8173_NUM_SENSING_POINTS; i++)
> +               writel(sensor_mux_values[cfg->sensors[i]],
> +                               mt->thermal_base + tempadcpnp_ofs[i]);

Not all banks use MT8173_NUM_SENSING_POINTS sensors.
If enable_mask became sensor_count, this could avoid writing
unnecessary registers:

       for (i = 0; i < cfg->sensor_count; i++)


> +
> +       writel(cfg->enable_mask, mt->thermal_base + TEMPMONCTL0);

And computing enable_mask from sensor_count is trivial:

GENMASK(cfg->sensor_count - 1, 0);

> +
> +       writel(TEMPADCWRITECTRL_ADC_PNP_WRITE | TEMPADCWRITECTRL_ADC_MUX_WRITE,
> +                       mt->thermal_base + TEMPADCWRITECTRL);
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
> +       mt->reset = devm_reset_control_get(&pdev->dev, "therm");
> +       if (IS_ERR(mt->reset)) {
> +               ret = PTR_ERR(mt->reset);
> +               dev_err(&pdev->dev, "cannot get reset: %d\n", ret);
> +               return ret;
> +       }
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
> +       mt->auxadc_phys_base = of_get_phys_base(auxadc);
> +       if (mt->auxadc_phys_base == OF_BAD_ADDR) {
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
> +       mt->apmixed_phys_base = of_get_phys_base(apmixedsys);
> +       if (mt->apmixed_phys_base == OF_BAD_ADDR) {
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
> +       reset_control_reset(mt->reset);
> +
> +       ret = clk_prepare_enable(mt->clk_peri_therm);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
> +               goto err_enable_clk;

I think labels are usually named by what they do, rather than what
causes the goto.
So, perhaps:

  goto err_disable_clk_auxadc;

> +       }
> +
> +       /*
> +        * These calibration values should finally be provided by the
> +        * firmware or fuses. For now use default values.
> +        */
> +       mt->adc_ge = ((512 - 512) * 10000) / 4096;
> +       mt->adc_oe = 512 - 512;
> +       mt->degc_cali = 40;
> +       mt->o_slope = 0;
> +       mt->vts = 260;
> +
> +       for (i = 0; i < MT8173_NUM_BANKS; i++) {
> +               struct mtk_thermal_bank *bank = &mt->banks[i];
> +
> +               bank->id = i;
> +               bank->mt = mt;
> +               mtk_thermal_init_bank(&mt->banks[i]);

I think this would work better as just:
   mtk_thermal_init_bank(mt, i, apmixedsys_phys_base, auxadc_phys_base);

Setting "id" and "mt" out here doesn't add much value.

> +       }
> +
> +       platform_set_drvdata(pdev, mt);
> +
> +       for (i = 0; i < MT8173_NUM_BANKS; i++) {
> +               struct mtk_thermal_bank *bank = &mt->banks[i];
> +
> +               bank->tz = thermal_zone_of_sensor_register(&pdev->dev, i, bank,
> +                               &mtk_thermal_ops);
> +       }
> +
> +       return 0;
> +
> +err_enable_clk:
> +       clk_disable_unprepare(mt->clk_peri_therm);
> +
> +       return ret;
> +}
> +
> +static int mtk_thermal_remove(struct platform_device *pdev)
> +{
> +       struct mtk_thermal *mt = platform_get_drvdata(pdev);
> +       int i;
> +
> +       for (i = 0; i < MT8173_NUM_BANKS; i++) {
> +               struct mtk_thermal_bank *bank = &mt->banks[i];
> +
> +               if (!IS_ERR(bank))

How could this be true?

ok... enough for now :-)

Thanks,
-Dan


> +                       thermal_zone_of_sensor_unregister(&pdev->dev, bank->tz);
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
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

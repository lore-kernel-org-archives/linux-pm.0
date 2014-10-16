From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v10 1/5] thermal: rockchip: add driver for thermal
Date: Thu, 16 Oct 2014 20:13:05 +0800
Message-ID: <543FB651.8090106@rock-chips.com>
References: <1413306608-11498-1-git-send-email-caesar.wang@rock-chips.com> <1413306608-11498-2-git-send-email-caesar.wang@rock-chips.com> <543D6695.7070009@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:54998 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbaJPMNU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 08:13:20 -0400
In-Reply-To: <543D6695.7070009@mentor.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, arnd@arndb.de
Cc: zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com

Vladimir,

=E5=9C=A8 2014=E5=B9=B410=E6=9C=8815=E6=97=A5 02:08, Vladimir Zapolskiy=
 =E5=86=99=E9=81=93:
> On 14.10.2014 20:10, Caesar Wang wrote:
>> Thermal is TS-ADC Controller module supports
>> user-defined mode and automatic mode.
>>
>> User-defined mode refers,TSADC all the control signals entirely by
>> software writing to register for direct control.
>>
>> Automaic mode refers to the module automatically poll TSADC output,
>> and the results were checked.If you find that the temperature High
>> in a period of time,an interrupt is generated to the processor
>> down-measures taken;If the temperature over a period of time High,
>> the resulting TSHUT gave CRU module,let it reset the entire chip,
>> or via GPIO give PMIC.
>>
>> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> ---
>>   drivers/thermal/Kconfig            |   9 +
>>   drivers/thermal/Makefile           |   1 +
>>   drivers/thermal/rockchip_thermal.c | 667=20
>> +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 677 insertions(+)
>>   create mode 100644 drivers/thermal/rockchip_thermal.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index ef5587f..5efcf73 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -133,6 +133,15 @@ config SPEAR_THERMAL
>>         Enable this to plug the SPEAr thermal sensor driver into the=
=20
>> Linux
>>         thermal framework.
>>
>> +config ROCKCHIP_THERMAL
>> +    tristate "Rockchip thermal driver"
>> +    depends on ARCH_ROCKCHIP
>> +    help
>> +      Rockchip thermal driver provides support for Temperature sens=
or
>> +      ADC (TS-ADC) found on Rockchip SoCs. It supports one critical
>> +      trip point. Cpufreq is used as the cooling device and will=20
>> throttle
>> +      CPUs when the Temperature crosses the passive trip point.
>> +
>>   config RCAR_THERMAL
>>       tristate "Renesas R-Car thermal driver"
>>       depends on ARCH_SHMOBILE || COMPILE_TEST
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 31e232f..21da0a8 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -19,6 +19,7 @@ thermal_sys-$(CONFIG_CPU_THERMAL)    +=3D cpu_cool=
ing.o
>>
>>   # platform thermal drivers
>>   obj-$(CONFIG_SPEAR_THERMAL)    +=3D spear_thermal.o
>> +obj-$(CONFIG_ROCKCHIP_THERMAL)    +=3D rockchip_thermal.o
>>   obj-$(CONFIG_RCAR_THERMAL)    +=3D rcar_thermal.o
>>   obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_thermal.o
>>   obj-y                +=3D samsung/
>> diff --git a/drivers/thermal/rockchip_thermal.c=20
>> b/drivers/thermal/rockchip_thermal.c
>> new file mode 100644
>> index 0000000..926611b
>> --- /dev/null
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -0,0 +1,667 @@
>> +/*
>> + * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This program is free software; you can redistribute it and/or=20
>> modify it
>> + * under the terms and conditions of the GNU General Public License=
,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but=20
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of=20
>> MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public=20
>> License for
>> + * more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/cpu_cooling.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/thermal.h>
>> +
>> +/**
>> + * If the temperature over a period of time High,
>> + * the resulting TSHUT gave CRU module,let it reset the entire chip=
,
>> + * or via GPIO give PMIC.
>> + */
>> +enum reset_mode {
>> +    CRU =3D 0,
>> +    GPIO,
>> +};
>> +
>> +/**
>> + * The system has three Teperture Sensors.
>> + * channel0 is reserve,channel1 is for CPU,and
>> + * channel channel 2 is for GPU.
>> + */
>> +enum sensor_id {
>> +    RESERVE =3D 0,
>> +    CPU,
>> +    GPU,
>> +    SENSOR_ID_END,
>> +};
>> +
>> +struct rockchip_thermal_data {
>> +    const struct rockchip_tsadc_platform_data *pdata;
>> +    struct thermal_zone_device *tz[SENSOR_ID_END];
>> +    struct thermal_cooling_device *cdev;
>> +    void __iomem *regs;
>> +
>> +    unsigned long temp_passive;
>> +    unsigned long hw_shut_temp;
>> +    unsigned long alarm_temp;
>> +    bool irq_enabled;
>> +    int irq;
>> +    int reset_mode;
>> +    int chn;
>> +
>> +    struct clk *clk;
>> +    struct clk *pclk;
>> +};
>> +
>> +struct rockchip_tsadc_platform_data {
>> +    unsigned long temp_passive;
>> +    unsigned long hw_shut_temp;
>> +    int reset_mode;
>> +
>> +    void (*irq_handle)(void __iomem *reg);
>> +    void (*initialize)(int reset_mode, int chn, void __iomem *reg,
>> +               unsigned long hw_shut_temp);
>> +    int (*control)(void __iomem *reg, bool on);
>> +    int (*code_to_temp)(u32 code);
>> +    u32 (*temp_to_code)(int temp);
>> +    void (*set_alarm_temp)(int chn, void __iomem *reg,
>> +                   unsigned long alarm_temp);
>> +};
>> +
>> +/* TSADC V2 Sensor info define: */
>> +#define TSADCV2_AUTO_CON            0x04
>> +#define TSADCV2_INT_EN                0x08
>> +#define TSADCV2_INT_PD                0x0c
>> +#define TSADCV2_DATA(chn)            (0x20 + (chn) * 0x04)
>> +#define TSADCV2_COMP_INT(chn)                (0x30 + (chn) * 0x04)
>> +#define TSADCV2_COMP_SHUT(chn)                (0x40 + (chn) * 0x04)
>> +#define TSADCV2_HIGHT_INT_DEBOUNCE        0x60
>> +#define TSADCV2_HIGHT_TSHUT_DEBOUNCE        0x64
>> +#define TSADCV2_AUTO_PERIOD            0x68
>> +#define TSADCV2_AUTO_PERIOD_HT            0x6c
>> +
>> +#define TSADCV2_AUTO_EN                BIT(0)
>> +#define TSADCV2_AUTO_DISABLE            ~BIT(0)
>> +#define TSADCV2_AUTO_SRC_EN(chn)            (0xf << (4 + chn))
>> +#define TSADCV2_AUTO_TSHUT_POLARITY_HIGH    BIT(8)
>> +#define TSADCV2_AUTO_TSHUT_POLARITY_LOW        ~BIT(8)
>> +
>> +#define TSADCV2_INT_SRC_EN(chn)            BIT(chn)
>> +#define TSADCV2_SHUT_2GPIO_SRC_EN(chn)        (0xf << (4 + chn))
>> +#define TSADCV2_SHUT_2CRU_SRC_EN(chn)        (0xf << (8 + chn))
>> +
>> +#define TSADCV2_INT_PD_CLEAR            ~BIT(8)
>> +
>> +#define TSADCV2_DATA_MASK            0xfff
>> +#define TSADCV2_HIGHT_INT_DEBOUNCE_TIME        0x0a
>> +#define TSADCV2_HIGHT_TSHUT_DEBOUNCE_TIME    0x0a
>> +#define TSADCV2_AUTO_PERIOD_TIME        0x03e8
>> +#define TSADCV2_AUTO_PERIOD_HT_TIME        0x64
>> +
>> +struct tsadc_table {
>> +    unsigned long code;
>> +    int temp;
>> +};
>> +
>> +static const struct tsadc_table v2_code_table[] =3D {
>> +    {TSADCV2_DATA_MASK, -40000},
>> +    {3800, -40000},
>> +    {3792, -35000},
>> +    {3783, -30000},
>> +    {3774, -25000},
>> +    {3765, -20000},
>> +    {3756, -15000},
>> +    {3747, -10000},
>> +    {3737, -5000},
>> +    {3728, 0},
>> +    {3718, 5000},
>> +    {3708, 10000},
>> +    {3698, 15000},
>> +    {3688, 20000},
>> +    {3678, 25000},
>> +    {3667, 30000},
>> +    {3656, 35000},
>> +    {3645, 40000},
>> +    {3634, 45000},
>> +    {3623, 50000},
>> +    {3611, 55000},
>> +    {3600, 60000},
>> +    {3588, 65000},
>> +    {3575, 70000},
>> +    {3563, 75000},
>> +    {3550, 80000},
>> +    {3537, 85000},
>> +    {3524, 90000},
>> +    {3510, 95000},
>> +    {3496, 100000},
>> +    {3482, 105000},
>> +    {3467, 110000},
>> +    {3452, 115000},
>> +    {3437, 120000},
>> +    {3421, 125000},
>> +    {0, 125000},
>> +};
>> +
>> +static void rk_tsadcv2_irq_handle(void __iomem *regs)
>> +{
>> +    u32 val;
>> +
>> +    val =3D readl_relaxed(regs + TSADCV2_INT_PD);
>> +    writel_relaxed(val & TSADCV2_INT_PD_CLEAR, regs + TSADCV2_INT_P=
D);
>> +}
>> +
>> +static u32 rk_tsadcv2_temp_to_code(int temp)
>> +{
>> +    int high, low, mid;
>> +
>> +    low =3D 0;
>> +    high =3D ARRAY_SIZE(v2_code_table) - 1;
>> +    mid =3D (high + low) / 2;
>> +
>> +    if (temp < v2_code_table[low].temp || temp >=20
>> v2_code_table[high].temp)
>> +        return 0;
>> +
>> +    while (low <=3D high) {
>> +        if (temp =3D=3D v2_code_table[mid].temp)
>> +            return v2_code_table[mid].code;
>> +        else if (temp < v2_code_table[mid].temp)
>> +            high =3D mid - 1;
>> +        else
>> +            low =3D mid + 1;
>> +        mid =3D (low + high) / 2;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int rk_tsadcv2_code_to_temp(u32 code)
>> +{
>> +    int high, low, mid;
>> +
>> +    low =3D 0;
>> +    high =3D ARRAY_SIZE(v2_code_table) - 1;
>> +    mid =3D (high + low) / 2;
>> +
>> +    if (code > v2_code_table[low].code || code <=20
>> v2_code_table[high].code)
>> +        return 125000; /* No code available,return max temperture *=
/
>> +
>> +    while (low <=3D high) {
>> +        if (code >=3D v2_code_table[mid].code && code <
>> +            v2_code_table[mid - 1].code)
>> +            return v2_code_table[mid].temp;
>> +        else if (code < v2_code_table[mid].code)
>> +            low =3D mid + 1;
>> +        else
>> +            high =3D mid - 1;
>> +        mid =3D (low + high) / 2;
>> +    }
>> +
>> +    return 125000;
>> +}
>> +
>> +/**
>> + * rk_tsadcv2_get_tshut_polarity_high - get the tshut polarity high
>> + * the bit 8 is tshut polarity.
>> + * 0: low active, 1: high active
>> + */
>> +static bool rk_tsadcv2_get_tshut_polarity_high(void __iomem *regs)
>> +{
>> +    u32 val;
>> +    bool tshut_polarity;
>> +
>> +    val =3D readl_relaxed(regs + TSADCV2_AUTO_CON);
>> +    tshut_polarity =3D (val & TSADCV2_AUTO_TSHUT_POLARITY_HIGH) ? t=
rue :
>> +              false;
>> +
>> +    return tshut_polarity;
>> +}
>> +
>> +/**
>> + * rk_tsadcv2_initialize - init configure for TASDC Controller
>> + * with the following step:
>> + * (1) Set TSADCV2_AUTO_PERIOD, configure the interleave between=20
>> every two
>> + * accessing of TSADC in normal operation.
>> + * (2) Set TSADCV2_AUTO_PERIOD_HT, configure the interleave between=
=20
>> every
>> + * two accessing of TSADC after the temperature is higher than COM_=
SHUT
>> + * or COM_INT.
>> + * (3) Set TSADCV2_COMn_SHUT(chn),configure the super high=20
>> temperature level,
>> + * if tsadc output is smaller than the value, means the temperature=
=20
>> is too
>> + * high, TSHUT will be asserted.
>> + * (4) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE=
,=20
>> if the
>> + * temperature is higher than COMP_INT or COMP_SHUT for "debounce"=20
>> times,
>> + * TSADC controller will generate interrupt or TSHUT.
>> + * (5) Set TSADCV2_INT_EN,you can enable the high temperature=20
>> interrupt for
>> + * the channel, and you can set TSHUT output to gpio to reset the=20
>> whole chip;
>> + * and you can set TSHUT output to cru to reset the whole chip.
>> + * (6) sET tsadc_auto_con, enable the TSADC controller.
>> + */
>> +static void rk_tsadcv2_initialize(int reset_mode, int chn, void=20
>> __iomem *regs,
>> +                  unsigned long hw_shut_temp)
>> +{
>> +    u32 shutdown_value;
>> +    bool tshut_polarity;
>> +
>> +    shutdown_value =3D rk_tsadcv2_temp_to_code(hw_shut_temp);
>> +    tshut_polarity =3D rk_tsadcv2_get_tshut_polarity_high(regs);
>> +
>> +    writel_relaxed(0, regs + TSADCV2_AUTO_CON);
>> +    writel_relaxed(TSADCV2_AUTO_PERIOD_TIME, regs +=20
>> TSADCV2_AUTO_PERIOD);
>> +    writel_relaxed(TSADCV2_AUTO_PERIOD_HT_TIME, regs +
>> +               TSADCV2_AUTO_PERIOD_HT);
>> +    writel_relaxed(shutdown_value, regs + TSADCV2_COMP_SHUT(chn));
>> +    writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_TIME, regs +
>> +               TSADCV2_HIGHT_INT_DEBOUNCE);
>> +    writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_TIME, regs +
>> +               TSADCV2_HIGHT_TSHUT_DEBOUNCE);
>> +
>> +    if (reset_mode =3D=3D GPIO)
>> +        writel_relaxed(TSADCV2_SHUT_2GPIO_SRC_EN(chn) |
>> +                   TSADCV2_INT_SRC_EN(chn), regs +
>> +                   TSADCV2_INT_EN);
>> +    else
>> +        writel_relaxed(TSADCV2_SHUT_2CRU_SRC_EN(chn) |
>> +                   TSADCV2_INT_SRC_EN(chn), regs +
>> +                   TSADCV2_INT_EN);
>> +
>> +    if (tshut_polarity)
>> +        writel_relaxed(TSADCV2_AUTO_EN | (TSADCV2_AUTO_SRC_EN(chn) =
&
>> +                   TSADCV2_AUTO_TSHUT_POLARITY_HIGH), regs +
>> +                   TSADCV2_AUTO_CON);
>> +    else
>> +        writel_relaxed(TSADCV2_AUTO_EN | (TSADCV2_AUTO_SRC_EN(chn) =
&
>> +                   TSADCV2_AUTO_TSHUT_POLARITY_LOW), regs +
>> +                   TSADCV2_AUTO_CON);
>> +}
>> +
>> +static int rk_tsadcv2_control(void __iomem *regs, bool on)
>> +{
>> +    u32 val;
>> +
>> +    if (on) {
>> +        val =3D readl_relaxed(regs + TSADCV2_AUTO_CON);
>> +        writel_relaxed(val | TSADCV2_AUTO_EN, regs + TSADCV2_AUTO_C=
ON);
>> +    } else {
>> +        val =3D readl_relaxed(regs + TSADCV2_AUTO_CON);
>> +        writel_relaxed(val & TSADCV2_AUTO_DISABLE,
>> +                   regs + TSADCV2_AUTO_CON);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void rk_tsadcv2_alarm_temp(int chn, void __iomem *regs,
>> +                  unsigned long alarm_temp)
>> +{
>> +    u32 alarm_value;
>> +
>> +    alarm_value =3D rk_tsadcv2_temp_to_code(alarm_temp);
>> +
>> +    writel_relaxed(alarm_value & TSADCV2_DATA_MASK, regs +
>> +               TSADCV2_COMP_INT(chn));
>> +}
>> +
>> +static const struct rockchip_tsadc_platform_data rk3288_tsadc_data =
=3D {
>> +    .reset_mode =3D GPIO, /* default TSHUT via GPIO give PMIC */
>> +    .temp_passive =3D 80000,
>> +    .hw_shut_temp =3D 120000,
>> +    .irq_handle =3D rk_tsadcv2_irq_handle,
>> +    .initialize =3D rk_tsadcv2_initialize,
>> +    .control =3D rk_tsadcv2_control,
>> +    .code_to_temp =3D rk_tsadcv2_code_to_temp,
>> +    .temp_to_code =3D rk_tsadcv2_temp_to_code,
>> +    .set_alarm_temp =3D rk_tsadcv2_alarm_temp,
>> +};
>> +
>> +static const struct of_device_id of_rockchip_thermal_match[] =3D {
>> +    {
>> +        .compatible =3D "rockchip,rk3288-tsadc",
>> +        .data =3D (void *)&rk3288_tsadc_data,
>> +    },
>> +    { /* end */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
>> +
>> +static void rockchip_set_alarm_temp(struct rockchip_thermal_data *d=
ata,
>> +                    int alarm_temp)
>> +{
>> +    const struct rockchip_tsadc_platform_data *tsadc =3D data->pdat=
a;
>> +
>> +    data->alarm_temp =3D alarm_temp;
>> +    if (tsadc->set_alarm_temp)
>> +        tsadc->set_alarm_temp(data->chn, data->regs, alarm_temp);
>> +}
>> +
>> +static int rockchip_thermal_initialize(struct rockchip_thermal_data=
=20
>> *data)
>> +{
>> +    const struct rockchip_tsadc_platform_data *tsadc =3D data->pdat=
a;
>> +
>> +    if (data->chn =3D=3D RESERVE)
>> +        return 0;
>> +
>> +    tsadc->initialize(tsadc->reset_mode, data->chn, data->regs,
>> +              data->hw_shut_temp);
>> +
>> +    rockchip_set_alarm_temp(data, data->temp_passive);
>> +
>> +    return 0;
>> +}
>> +
>> +static void rockchip_thermal_control(struct rockchip_thermal_data=20
>> *data,
>> +                     bool on)
>> +{
>> +    const struct rockchip_tsadc_platform_data *tsadc =3D data->pdat=
a;
>> +
>> +    if (tsadc->control)
>> +        tsadc->control(data->regs, on);
>> +
>> +    if (on) {
>> +        data->irq_enabled =3D true;
>> + data->tz[data->chn]->ops->set_mode(data->tz[data->chn],
>> +        THERMAL_DEVICE_ENABLED);
>> +    } else {
>> +        data->irq_enabled =3D false;
>> + data->tz[data->chn]->ops->set_mode(data->tz[data->chn],
>> +        THERMAL_DEVICE_DISABLED);
>> +    }
>> +}
>> +
>> +static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void=20
>> *dev)
>> +{
>> +    struct rockchip_thermal_data *data =3D dev;
>> +    const struct rockchip_tsadc_platform_data *tsadc =3D data->pdat=
a;
>> +    int chn;
>> +
>> +    tsadc->irq_handle(data->regs);
>> +
>> +    for (chn =3D CPU; chn < SENSOR_ID_END; chn++)
>> +        thermal_zone_device_update(data->tz[chn]);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static int rockchip_thermal_set_trips(void *zone, long low, long hi=
gh)
>> +{
>> +    struct rockchip_thermal_data *data =3D zone;
>> +    const struct rockchip_tsadc_platform_data *tsadc =3D data->pdat=
a;
>> +
>> +    low =3D clamp_val(low, LONG_MIN, LONG_MAX);
>> +    high =3D clamp_val(high, LONG_MIN, LONG_MAX);
>> +
>> +    /* channel0 is RESERVE, not need to set trips*/
>> +    if (data->chn =3D=3D RESERVE)
>> +        return 0;
>> +
>> +    /* Update alarm value to next higher trip point */
>> +    if (data->alarm_temp =3D=3D data->temp_passive && high <=3D
>> +        tsadc->temp_to_code(data->temp_passive))
>> +        high =3D data->hw_shut_temp;
>> +
>> +    if (data->alarm_temp >=3D data->temp_passive && high >
>> +        tsadc->temp_to_code(data->temp_passive)) {
>> +        high =3D data->temp_passive;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int rockchip_thermal_get_temp(void *zone, long *out_temp)
>> +{
>> +    struct rockchip_thermal_data *data =3D zone;
>> +    const struct rockchip_tsadc_platform_data *tsadc =3D data->pdat=
a;
>> +    u32 val;
>> +
>> +    if (data->chn =3D=3D RESERVE)
>> +        return 0;
>> +
>> +    /* the A/D value of the channel last conversion need some time =
*/
>> +    val =3D readl_relaxed(data->regs + TSADCV2_DATA(data->chn));
>> +    if (val =3D=3D 0)
>> +        return -EPROBE_DEFER;
>> +
>> +    *out_temp =3D tsadc->code_to_temp(val);
>> +
>> +    return 0;
>> +}
>> +
>> +static int rockchip_configure_from_dt(struct device *dev,
>> +                      struct device_node *np,
>> +                      struct rockchip_thermal_data *data)
>> +{
>> +    int shut_temp, reset_mode;
>> +
>> +    if (of_property_read_u32(np, "hw-shut-temp", &shut_temp)) {
>> +        dev_warn(dev, "Missing default shutdown temp property\n");
>> +        data->hw_shut_temp =3D data->pdata->hw_shut_temp;
>> +    } else {
>> +        data->hw_shut_temp =3D shut_temp;
>> +    }
>> +
>> +    if (of_property_read_u32(np, "tsadc-ht-reset-mode", &reset_mode=
)) {
>> +        dev_warn(dev, "Missing default reset mode property\n");
>> +        data->reset_mode =3D data->pdata->reset_mode;
>> +    } else {
>> +        data->reset_mode =3D reset_mode;
>> +    }
>> +
>> +    data->temp_passive =3D data->pdata->temp_passive;
>> +
>> +    return 0;
>> +}
>> +
>> +static int rockchip_thermal_probe(struct platform_device *pdev)
>> +{
>> +    struct rockchip_thermal_data *data;
>> +    const struct rockchip_tsadc_platform_data *tsadc;
>> +    const struct of_device_id *match;
>> +
>> +    struct cpumask clip_cpus;
>> +    struct resource *res;
>> +    struct device_node *np =3D pdev->dev.of_node;
>> +
>> +    int ret, err, chn;
>> +
>> +    data =3D devm_kzalloc(&pdev->dev, sizeof(struct=20
>> rockchip_thermal_data),
>> +                GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    data->regs =3D devm_ioremap_resource(&pdev->dev, res);
>> +    if (IS_ERR(data->regs)) {
>> +        dev_err(&pdev->dev, "Could not get tsadc source, %p\n",
>> +            data->regs);
>> +        return PTR_ERR(data->regs);
>> +    }
>> +
>> +    match =3D of_match_node(of_rockchip_thermal_match, np);
>> +    if (!match)
>> +        return -ENXIO;
>> +    data->pdata =3D (const struct rockchip_tsadc_platform_data=20
>> *)match->data;
>> +    if (!data->pdata)
>> +        return -EINVAL;
>> +    tsadc =3D data->pdata;
>> +
>> +    data->clk =3D devm_clk_get(&pdev->dev, "tsadc");
>> +    if (IS_ERR(data->clk)) {
>> +        dev_err(&pdev->dev, "failed to get tsadc clock\n");
>> +        return PTR_ERR(data->clk);
>> +    }
>> +
>> +    data->pclk =3D devm_clk_get(&pdev->dev, "apb_pclk");
>> +    if (IS_ERR(data->pclk)) {
>> +        dev_err(&pdev->dev, "failed to get tsadc pclk\n");
>> +        return PTR_ERR(data->pclk);
>> +    }
>> +
>> +    /**
>> +     * Use a default of 10KHz for the converter clock.
>> +     * This may become user-configurable in the future.
>> +     * Need to judge the data->clk is Divided by xin32k.
>> +     * Need to retry it if the pmic hasn't output the xin32k.
>> +     */
>> +    if (clk_get_rate(data->clk) =3D=3D 0)
>> +        return -EPROBE_DEFER;
>> +    ret =3D clk_set_rate(data->clk, 10000);
>> +    if (ret < 0) {
>> +        dev_err(&pdev->dev, "failed to set tsadc clk rate, %d\n", r=
et);
>> +        return ret;
>> +    }
>> +
>> +    ret =3D clk_prepare_enable(data->clk);
>> +    if (ret < 0) {
>> +        dev_err(&pdev->dev, "failed to enable converter clock\n");
>> +        goto err_clk;
>> +    }
>> +
>> +    ret =3D clk_prepare_enable(data->pclk);
>> +    if (ret < 0) {
>> +        dev_err(&pdev->dev, "failed to enable pclk\n");
>> +        goto err_pclk;
>> +    }
>> +
>> +    cpumask_set_cpu(0, &clip_cpus);
>> +    data->cdev =3D of_cpufreq_cooling_register(np, &clip_cpus);
>> +    if (IS_ERR(data->cdev)) {
>> +        dev_err(&pdev->dev, "failed to register cpufreq cooling=20
>> device\n");
>> +        goto disable_clk;
>> +    }
>> +
>> +    data->irq =3D platform_get_irq(pdev, 0);
>> +    if (data->irq < 0) {
>> +        dev_err(&pdev->dev, "no irq resource?\n");
>> +        goto disable_clk;
>
> From here goto cpufreq_cooling_unregister() line.
>

=46ixed.
>> +    }
>> +
>> +    ret =3D devm_request_threaded_irq(&pdev->dev, data->irq, NULL,
>> +                    &rockchip_thermal_alarm_irq_thread,
>> +                    IRQF_ONESHOT, "rockchip_thermal",
>> +                    data);
>> +    if (ret < 0) {
>> +        dev_err(&pdev->dev,
>> +            "failed to request tsadc irq: %d\n", ret);
>> +        goto disable_clk;
>
> Same as above.
>

Ditto.
>> +    }
>> +
>> +    ret =3D rockchip_configure_from_dt(&pdev->dev, np, data);
>> +    if (ret)
>> +        dev_err(&pdev->dev, "Parsing device tree data error.\n");
>> +
>> +    /* The system three Teperture Sensors be registered */
>> +    for (chn =3D RESERVE; chn < SENSOR_ID_END; chn++) {
>> +        data->chn =3D chn;
>> +
>> +        data->tz[chn] =3D thermal_zone_of_sensor_register(
>> +                &pdev->dev, data->chn,
>> +                data, rockchip_thermal_get_temp,
>> +                NULL,
>> +                rockchip_thermal_set_trips);
>> +        if (IS_ERR(data->tz[chn])) {
>> +            err =3D PTR_ERR(data->tz[chn]);
>> +            dev_err(&pdev->dev, "failed to register sensor: %d\n",
>> +                err);
>> +            chn--;
>> +            goto unregister_tzs;
>> +        }
>> +
>> +        platform_set_drvdata(pdev, data);
>
> Why is platform_set_drvdata() called in the loop? Both pointers are=20
> fixed.
>

Ditto.
>> +
>> +        rockchip_thermal_initialize(data);
>> +        rockchip_thermal_control(data, true);
>
> It looks like "data->chn" is fixed all over the core and I guess it i=
s=20
> (SENSOR_ID_END-1). The whole "data->chn" idea is broken wherever you=20
> it here in the driver's code.
>
It seemed to...

=46ixed.

Thanks your comments.


>> +    }
>> +    return 0;
>> +
>> +unregister_tzs:
>> +    for (; chn >=3D RESERVE; chn--)
>> +        thermal_zone_of_sensor_unregister(&pdev->dev, data->tz[chn]=
);
>> +    cpufreq_cooling_unregister(data->cdev);
>> +
>> +disable_clk:
>> +err_pclk:
>> +    clk_disable_unprepare(data->pclk);
>> +err_clk:
>> +    clk_disable_unprepare(data->clk);
>> +
>> +    return ret;
>> +}
>> +
>> +static int rockchip_thermal_remove(struct platform_device *pdev)
>> +{
>> +    struct rockchip_thermal_data *data =3D platform_get_drvdata(pde=
v);
>> +
>> +    rockchip_thermal_control(data, false);
>> +
>> +    for (; data->chn >=3D RESERVE; data->chn--)
>> +        thermal_zone_of_sensor_unregister(&pdev->dev,
>> +                          data->tz[data->chn]);
>> +    cpufreq_cooling_unregister(data->cdev);
>> +
>> +    clk_disable_unprepare(data->clk);
>> +    clk_disable_unprepare(data->pclk);
>> +
>> +    return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int rockchip_thermal_suspend(struct device *dev)
>> +{
>> +    struct platform_device *pdev =3D to_platform_device(dev);
>> +    struct rockchip_thermal_data *data =3D platform_get_drvdata(pde=
v);
>> +
>> +    rockchip_thermal_control(data, false);
>> +
>> +    clk_disable(data->clk);
>> +    clk_disable(data->pclk);
>> +
>> +    return 0;
>> +}
>> +
>> +static int rockchip_thermal_resume(struct device *dev)
>> +{
>> +    struct platform_device *pdev =3D to_platform_device(dev);
>> +    struct rockchip_thermal_data *data =3D platform_get_drvdata(pde=
v);
>> +    int ret;
>> +
>> +    ret =3D clk_enable(data->pclk);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret =3D clk_enable(data->clk);
>> +    if (ret)
>> +        return ret;
>> +
>> +    rockchip_thermal_initialize(data);
>> +    rockchip_thermal_control(data, true);
>> +
>> +    return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(rockchip_thermal_pm_ops,
>> +             rockchip_thermal_suspend, rockchip_thermal_resume);
>> +
>> +static struct platform_driver rockchip_thermal_driver =3D {
>> +    .driver =3D {
>> +           .name =3D "rockchip-thermal",
>> +           .owner =3D THIS_MODULE,
>> +           .pm =3D &rockchip_thermal_pm_ops,
>> +           .of_match_table =3D of_rockchip_thermal_match,
>> +           },
>> +    .probe =3D rockchip_thermal_probe,
>> +    .remove =3D rockchip_thermal_remove,
>> +};
>> +
>> +module_platform_driver(rockchip_thermal_driver);
>> +
>> +MODULE_DESCRIPTION("ROCKCHIP THERMAL Driver");
>> +MODULE_AUTHOR("Rockchip, Inc.");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:rockchip-thermal");
>>
>
>
>
>

--=20
Best regards,
Caesar



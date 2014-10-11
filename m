From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v8 1/5] thermal: rockchip: add driver for thermal
Date: Sat, 11 Oct 2014 14:01:33 +0800
Message-ID: <5438C7BD.4010308@rock-chips.com>
References: <1412936381-22718-1-git-send-email-caesar.wang@rock-chips.com> <1412936381-22718-2-git-send-email-caesar.wang@rock-chips.com> <20141010174636.GB32974@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20141010174636.GB32974@dtor-ws>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, arnd@arndb.de, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Dear Dmitry,

=E5=9C=A8 2014=E5=B9=B410=E6=9C=8811=E6=97=A5 01:46, Dmitry Torokhov =E5=
=86=99=E9=81=93:
> Hi Caesar,
>
> On Fri, Oct 10, 2014 at 06:19:37PM +0800, Caesar Wang wrote:
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
>>   drivers/thermal/rockchip_thermal.c | 628 +++++++++++++++++++++++++=
++++++++++++
>>   3 files changed, 638 insertions(+)
>>   create mode 100644 drivers/thermal/rockchip_thermal.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index f9a1386..24845ae 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -133,6 +133,15 @@ config SPEAR_THERMAL
>>   	  Enable this to plug the SPEAr thermal sensor driver into the Li=
nux
>>   	  thermal framework.
>>  =20
>> +config ROCKCHIP_THERMAL
>> +	tristate "Rockchip thermal driver"
>> +	depends on ARCH_ROCKCHIP
>> +	help
>> +	  Rockchip thermal driver provides support for Temperature sensor
>> +	  ADC (TS-ADC) found on Rockchip SoCs. It supports one critical
>> +	  trip point. Cpufreq is used as the cooling device and will throt=
tle
>> +	  CPUs when the Temperature crosses the passive trip point.
>> +
>>   config RCAR_THERMAL
>>   	tristate "Renesas R-Car thermal driver"
>>   	depends on ARCH_SHMOBILE || COMPILE_TEST
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index de0636a..930554f 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -19,6 +19,7 @@ thermal_sys-$(CONFIG_CPU_THERMAL)	+=3D cpu_cooling=
=2Eo
>>  =20
>>   # platform thermal drivers
>>   obj-$(CONFIG_SPEAR_THERMAL)	+=3D spear_thermal.o
>> +obj-$(CONFIG_ROCKCHIP_THERMAL)	+=3D rockchip_thermal.o
>>   obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
>>   obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_thermal.o
>>   obj-y				+=3D samsung/
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/ro=
ckchip_thermal.c
>> new file mode 100644
>> index 0000000..ceee2c1
>> --- /dev/null
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -0,0 +1,628 @@
>> +/*
>> + * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms and conditions of the GNU General Public License=
,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but W=
ITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Li=
cense for
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
>> +* If the temperature over a period of time High,
>> +* the resulting TSHUT gave CRU module,let it reset the entire chip,
>> +* or via GPIO give PMIC.
>> +*/
>> +enum reset_mde {
> Can we spare one more letter? ;)
>

OK, maybe fix it as the follows:

enum reset_mde {
     TSADC_HT_RESET_CRU =3D 0,
     TSADC_HT_PULL_GPIO,
};
>> +	CRU =3D 0,
>> +	GPIO,
>> +};
>> +
>> +/**
>> +* The system has three Teperture Sensors.
>> +* channel0 is reserve,channel1 is for CPU,and
>> +* channel channel 2 is for GPU.
>> +*/
>> +enum sensor_id {
>> +	RESERVE =3D 0,
>> +	CPU,
>> +	GPU,
>> +	SENSOR_ID_END,
>> +};
>> +
>> +struct rockchip_thermal_data {
>> +	const struct rockchip_tsadc_platform_data *pdata;
>> +	struct thermal_zone_device *tz[SENSOR_ID_END];
>> +	struct thermal_cooling_device *cdev;
>> +	void __iomem *regs;
>> +
>> +	unsigned long temp_passive;
>> +	unsigned long hw_shut_temp;
>> +	unsigned long alarm_temp;
>> +	bool irq_enabled;
>> +	int irq;
>> +	int reset_mode;
>> +	int chn;
>> +
>> +	struct clk *clk;
>> +	struct clk *pclk;
>> +};
>> +
>> +struct rockchip_tsadc_platform_data {
>> +	unsigned long temp_passive;
>> +	unsigned long hw_shut_temp;
>> +	int reset_mode;
>> +
>> +	int (*irq_handle)(void __iomem *reg);
> Why does it return int and not void? What is the return value of this=
?

=46ixed. instead of using void.
>> +	int (*initialize)(int reset_mode, int chn, void __iomem *reg,
> Why does it return int and not void? What is the return value of this=
?> +			  unsigned long hw_shut_temp);

Ditto.

>> +	int (*control)(void __iomem *reg, bool on);
>> +	int (*code_to_temp)(u32 code);
>> +	u32 (*temp_to_code)(int temp);
>> +	void (*set_alarm_temp)(int chn, void __iomem *reg,
>> +			       unsigned long alarm_temp);
>> +};
>> +
>> +/* TSADC V2 Sensor info define: */
>> +#define TSADCV2_AUTO_CON			0x04
>> +#define TSADCV2_INT_EN				0x08
>> +#define TSADCV2_INT_PD				0x0c
>> +#define TSADCV2_DATA(chn)			(0x20+chn*0x04)
> Unsafe macros. You want to enclose argument in parenthesis.

Yeah.
Hmmm, there is no thought of a good way to deal with it at the moment.

Maybe do that as the follows,but should be a better way to deal.

e.g:
#define TSADCV2_DATA0  0x20
#define TSADCV2_DATA1  0x24
#define TSADCV2_DATA2  0x28
#define TSADCV2_DATA3  0x2c

#define TSADCV2_COMP0_INT  0x30
#define TSADCV2_COMP1_INT  0x34
#define TSADCV2_COMP2_INT  0x38
#define TSADCV2_COMP3_INT  0x3c

#define TSADCV2_COMP0_SHUT  0x40
#define TSADCV2_COMP1_SHUT  0x44
#define TSADCV2_COMP2_SHUT  0x48
#define TSADCV2_COMP3_SHUT  0x4c
>> +#define TSADCV2_COMP_INT(chn)		        (0x30+chn*0x04)
>> +#define TSADCV2_COMP_SHUT(chn)		        (0x40+chn*0x04)
>> +#define TSADCV2_HIGHT_INT_DEBOUNCE		0x60
>> +#define TSADCV2_HIGHT_TSHUT_DEBOUNCE		0x64
>> +#define TSADCV2_AUTO_PERIOD			0x68
>> +#define TSADCV2_AUTO_PERIOD_HT			0x6c
>> +
>> +#define TSADCV2_AUTO_EN				BIT(0)
>> +#define TSADCV2_AUTO_DISABLE			~BIT(0)
>> +#define TSADCV2_AUTO_SRC_EN(chn)	        (0xf << (4 + chn))
>> +#define TSADCV2_AUTO_TSHUT_POLARITY_HIGH	BIT(8)
>> +
>> +#define TSADCV2_INT_SRC_EN(chn)			BIT(chn)
>> +#define TSADCV2_SHUT_2GPIO_SRC_EN(chn)		(0xf << (4 + chn))
>> +#define TSADCV2_SHUT_2CRU_SRC_EN(chn)		(0xf << (8 + chn))
>> +
>> +#define TSADCV2_INT_PD_CLEAR			~BIT(8)
>> +
>> +#define TSADCV2_DATA_MASK			0xfff
>> +#define TSADCV2_HIGHT_INT_DEBOUNCE_TIME		0x0a
>> +#define TSADCV2_HIGHT_TSHUT_DEBOUNCE_TIME	0x0a
>> +#define TSADCV2_AUTO_PERIOD_TIME		0x03e8
>> +#define TSADCV2_AUTO_PERIOD_HT_TIME		0x64
>> +
>> +struct tsadc_table {
>> +	unsigned long code;
>> +	int temp;
>> +};
>> +
>> +static const struct tsadc_table v2_code_table[] =3D {
>> +	{TSADCV2_DATA_MASK, -40000},
>> +	{3800, -40000},
>> +	{3792, -35000},
>> +	{3783, -30000},
>> +	{3774, -25000},
>> +	{3765, -20000},
>> +	{3756, -15000},
>> +	{3747, -10000},
>> +	{3737, -5000},
>> +	{3728, 0},
>> +	{3718, 5000},
>> +	{3708, 10000},
>> +	{3698, 15000},
>> +	{3688, 20000},
>> +	{3678, 25000},
>> +	{3667, 30000},
>> +	{3656, 35000},
>> +	{3645, 40000},
>> +	{3634, 45000},
>> +	{3623, 50000},
>> +	{3611, 55000},
>> +	{3600, 60000},
>> +	{3588, 65000},
>> +	{3575, 70000},
>> +	{3563, 75000},
>> +	{3550, 80000},
>> +	{3537, 85000},
>> +	{3524, 90000},
>> +	{3510, 95000},
>> +	{3496, 100000},
>> +	{3482, 105000},
>> +	{3467, 110000},
>> +	{3452, 115000},
>> +	{3437, 120000},
>> +	{3421, 125000},
>> +	{0, 125000},
>> +};
>> +
>> +static int rk_tsadcv2_irq_handle(void __iomem *regs)
>> +{
>> +	u32 val;
>> +
>> +	val =3D readl_relaxed(regs + TSADCV2_INT_PD);
>> +	writel_relaxed(val & TSADCV2_INT_PD_CLEAR, regs + TSADCV2_INT_PD);
>> +
>> +	return 0;
>> +}
>> +
>> +static u32 rk_tsadcv2_temp_to_code(int temp)
>> +{
>> +	int high, low, mid, ret =3D 0;
>> +
>> +	low =3D 0;
>> +	high =3D ARRAY_SIZE(v2_code_table) - 1;
>> +	mid =3D (high + low) / 2;
>> +
>> +	if (temp < v2_code_table[low].temp || temp > v2_code_table[high].t=
emp) {
>> +		ret =3D -ERANGE;
> The function returns u32, you can't return -ERANGE here.

Yeah,fixed.
>> +		goto exit;
>> +	}
>> +
>> +	while (low <=3D high) {
>> +		if (temp =3D=3D v2_code_table[mid].temp)
>> +			return v2_code_table[mid].code;
>> +		else if (temp < v2_code_table[mid].temp)
>> +			high =3D mid - 1;
>> +		else
>> +			low =3D mid + 1;
>> +		mid =3D (low + high) / 2;
>> +	}
> Hmm, you optimized temp_to_code but not code_to_temp, why?

OK,fixed.
>> +
>> +	return 0;
>> +
>> +exit:
>> +	return ret;
>> +}
>> +
>> +static int rk_tsadcv2_code_to_temp(u32 code)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(v2_code_table) - 1; i++) {
>> +		if (code >=3D v2_code_table[i].code)
>> +			return v2_code_table[i].temp;
>> +	}
>> +
>> +	/* No code available,return max temperture */
>> +	return 125000;
>> +}
>> +
>> +static int rk_tsadcv2_initialize(int reset_mode, int chn, void __io=
mem *regs,
>> +				 unsigned long hw_shut_temp)
>> +{
>> +	u32 shutdown_value;
>> +
>> +	shutdown_value =3D rk_tsadcv2_temp_to_code(hw_shut_temp);
>> +
>> +	/* Enable measurements at ~ 10 Hz */
>> +	writel_relaxed(0 | TSADCV2_AUTO_TSHUT_POLARITY_HIGH, regs +
>> +		       TSADCV2_AUTO_CON);
>> +	writel_relaxed(TSADCV2_AUTO_PERIOD_TIME, regs + TSADCV2_AUTO_PERIO=
D);
>> +	writel_relaxed(TSADCV2_AUTO_PERIOD_HT_TIME, regs +
>> +		       TSADCV2_AUTO_PERIOD_HT);
>> +	writel_relaxed(shutdown_value, regs + TSADCV2_COMP_SHUT(chn));
>> +	writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_TIME, regs +
>> +		       TSADCV2_HIGHT_INT_DEBOUNCE);
>> +	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_TIME, regs +
>> +		       TSADCV2_HIGHT_TSHUT_DEBOUNCE);
>> +
>> +	if (reset_mode =3D=3D GPIO)
>> +		writel_relaxed(TSADCV2_SHUT_2GPIO_SRC_EN(chn) |
>> +			       TSADCV2_INT_SRC_EN(chn), regs +
>> +			       TSADCV2_INT_EN);
>> +	else
>> +		writel_relaxed(TSADCV2_SHUT_2CRU_SRC_EN(chn) |
>> +			       TSADCV2_INT_SRC_EN(chn) , regs +
>> +			       TSADCV2_INT_EN);
>> +
>> +	writel_relaxed(TSADCV2_AUTO_SRC_EN(chn) | TSADCV2_AUTO_EN, regs +
>> +		       TSADCV2_AUTO_CON);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk_tsadcv2_control(void __iomem *regs, bool on)
>> +{
>> +	u32 val;
>> +
>> +	if (on) {
>> +		val =3D readl_relaxed(regs + TSADCV2_AUTO_CON);
>> +		writel_relaxed(val | TSADCV2_AUTO_EN, regs + TSADCV2_AUTO_CON);
>> +	} else {
>> +		val =3D readl_relaxed(regs + TSADCV2_AUTO_CON);
>> +		writel_relaxed(val & TSADCV2_AUTO_DISABLE,
>> +			       regs + TSADCV2_AUTO_CON);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rk_tsadcv2_alarm_temp(int chn, void __iomem *regs,
>> +				  unsigned long alarm_temp)
>> +{
>> +	u32 alarm_value;
>> +
>> +	alarm_value =3D rk_tsadcv2_temp_to_code(alarm_temp);
>> +
>> +	writel_relaxed(alarm_value & TSADCV2_DATA_MASK, regs +
>> +		       TSADCV2_COMP_INT(chn));
>> +}
>> +
>> +static const struct rockchip_tsadc_platform_data rk3288_tsadc_data =
=3D {
>> +	.reset_mode =3D GPIO, /* default TSHUT via GPIO give PMIC */
>> +	.temp_passive =3D 80000,
>> +	.hw_shut_temp =3D 120000,
>> +	.irq_handle =3D rk_tsadcv2_irq_handle,
>> +	.initialize =3D rk_tsadcv2_initialize,
>> +	.control =3D rk_tsadcv2_control,
>> +	.code_to_temp =3D rk_tsadcv2_code_to_temp,
>> +	.temp_to_code =3D rk_tsadcv2_temp_to_code,
>> +	.set_alarm_temp =3D rk_tsadcv2_alarm_temp,
>> +};
>> +
>> +static const struct of_device_id of_rockchip_thermal_match[] =3D {
>> +	{
>> +		.compatible =3D "rockchip,rk3288-tsadc",
>> +		.data =3D (void *)&rk3288_tsadc_data,
>> +	},
>> +	{ /* end */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
>> +
>> +static void rockchip_set_alarm_temp(struct rockchip_thermal_data *d=
ata,
>> +				    int alarm_temp)
>> +{
>> +	const struct rockchip_tsadc_platform_data *tsadc =3D data->pdata;
>> +
>> +	data->alarm_temp =3D alarm_temp;
>> +	if (tsadc->set_alarm_temp)
>> +		tsadc->set_alarm_temp(data->chn, data->regs, alarm_temp);
>> +}
>> +
>> +static int rockchip_thermal_initialize(struct rockchip_thermal_data=
 *data)
>> +{
>> +	const struct rockchip_tsadc_platform_data *tsadc =3D data->pdata;
>> +
>> +	if (data->chn =3D=3D RESERVE)
>> +		return 0;
>> +
>> +	if (tsadc->initialize)
>> +		tsadc->initialize(tsadc->reset_mode, data->chn, data->regs,
>> +				  data->hw_shut_temp);
>> +
>> +	rockchip_set_alarm_temp(data, data->temp_passive);
>> +
>> +	return 0;
>> +}
>> +
>> +static void rockchip_thermal_control(struct rockchip_thermal_data *=
data,
>> +				     bool on)
>> +{
>> +	const struct rockchip_tsadc_platform_data *tsadc =3D data->pdata;
>> +
>> +	if (tsadc->control)
>> +		tsadc->control(data->regs, on);
>> +
>> +	if (on) {
>> +		data->irq_enabled =3D true;
>> +		data->tz[data->chn]->ops->set_mode(data->tz[data->chn],
>> +		THERMAL_DEVICE_ENABLED);
>> +	} else {
>> +		data->irq_enabled =3D false;
>> +		data->tz[data->chn]->ops->set_mode(data->tz[data->chn],
>> +		THERMAL_DEVICE_DISABLED);
>> +	}
>> +}
>> +
>> +static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void =
*dev)
>> +{
>> +	struct rockchip_thermal_data *data =3D dev;
>> +	const struct rockchip_tsadc_platform_data *tsadc =3D data->pdata;
>> +	int chn;
>> +
>> +	if (tsadc->irq_handle)
>> +		tsadc->irq_handle(data->regs);
>> +
>> +	for (chn =3D CPU; chn < SENSOR_ID_END; chn++)
>> +		thermal_zone_device_update(data->tz[chn]);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int rockchip_thermal_set_trips(void *zone, long low, long hi=
gh)
>> +{
>> +	struct rockchip_thermal_data *data =3D zone;
>> +	const struct rockchip_tsadc_platform_data *tsadc =3D data->pdata;
>> +	u32 val;
>> +
>> +	low =3D clamp_val(low, LONG_MIN, LONG_MAX);
>> +	high =3D clamp_val(high, LONG_MIN, LONG_MAX);
>> +
>> +	/* channel0 is RESERVE, not need to set trips*/
>> +	if (data->chn =3D=3D RESERVE)
>> +		return 0;
>> +
>> +	val =3D readl_relaxed(data->regs + TSADCV2_DATA(data->chn));
> I do not think you need to re-read the temperature: you are already
> goivent lower and upper trip points for current temperature, you just
> need to set alarm to the upper one.
>

=46ixed.
>> +	if (val =3D=3D 0)
>> +		return -EPROBE_DEFER;
> What -EPROBE_DEFER means in this context?
>

In general, the A/D value of the channel last conversion need some time=
=2E
There isn't a need in here.
>> +
>> +	/* Update alarm value to next higher trip point */
>> +	if (data->alarm_temp =3D=3D data->temp_passive && val <=3D
>> +		tsadc->temp_to_code(data->temp_passive))
>> +		high =3D data->hw_shut_temp;
>> +
>> +	if (data->alarm_temp >=3D data->temp_passive && val >
>> +		tsadc->temp_to_code(data->temp_passive)) {
>> +		high =3D data->temp_passive;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_thermal_get_temp(void *zone, long *out_temp)
>> +{
>> +	struct rockchip_thermal_data *data =3D zone;
>> +	const struct rockchip_tsadc_platform_data *tsadc =3D data->pdata;
>> +	u32 val;
>> +
>> +	if (data->chn =3D=3D RESERVE)
>> +		return 0;
>> +
>> +	val =3D readl_relaxed(data->regs + TSADCV2_DATA(data->chn));
>> +
>> +	if (val < tsadc->temp_to_code(data->hw_shut_temp))
>> +		*out_temp =3D 120000;
> Why is this needed? If this is really needed please comment the code.

=46ixed.
It's not need.

>> +	else
>> +		*out_temp =3D tsadc->code_to_temp(val);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_configure_from_dt(struct device *dev,
>> +				      struct device_node *np,
>> +				      struct rockchip_thermal_data *data)
>> +{
>> +	int shut_temp, reset_mode;
>> +
>> +	if (of_property_read_u32(np, "hw-shut-temp", &shut_temp)) {
>> +		dev_warn(dev, "Missing default shutdown temp property\n");
>> +		data->hw_shut_temp =3D data->pdata->hw_shut_temp;
> I am still not sure why we want it in DT. I envision the set up as
> follows:
>
> passive trip point - defined in DT
> critical trip point - defined in DT, causes shutdown performed by
> thermal core for us
> hardware critical - hard coded (defined by the hardware, no point in
> changing), shuts down or resets the box automatically by the hardware=
,
> no kernel involved.

Although TSHUT(hardware shutdown temperature value) is not a generic=20
trip point,
TSHUT value is relative fixed and need be init as the tsadc_comp.

hmm..,if  it doeen't define in the DT,we had to get a TSHUT  from data,

as the about:
dev_warn(dev, "Missing default shutdown temp property\n");
		data->hw_shut_temp =3D data->pdata->hw_shut_temp;



>> +	} else {
>> +		data->hw_shut_temp =3D shut_temp;
>> +	}
>> +
>> +	if (of_property_read_u32(np, "tsadc-ht-reset-mode", &reset_mode)) =
{
>> +		dev_warn(dev, "Missing default reset mode property\n");
>> +		data->reset_mode =3D data->pdata->reset_mode;
>> +	} else {
>> +		data->reset_mode =3D reset_mode;
>> +	}
>> +
>> +	data->temp_passive =3D data->pdata->temp_passive;
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_thermal_probe(struct platform_device *pdev)
>> +{
>> +	struct rockchip_thermal_data *data;
>> +	const struct rockchip_tsadc_platform_data *tsadc;
>> +	const struct of_device_id *match;
>> +
>> +	struct cpumask clip_cpus;
>> +	struct resource *res;
>> +	struct device_node *np =3D pdev->dev.of_node;
>> +
>> +	int ret, err, chn;
>> +
>> +	data =3D devm_kzalloc(&pdev->dev, sizeof(struct rockchip_thermal_d=
ata),
>> +			    GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	data->regs =3D devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(data->regs)) {
>> +		dev_err(&pdev->dev, "Could not get tsadc source, %p\n",
>> +			data->regs);
>> +		return PTR_ERR(data->regs);
>> +	}
>> +
>> +	match =3D of_match_node(of_rockchip_thermal_match, np);
>> +	if (!match)
>> +		return -ENXIO;
>> +	data->pdata =3D (const struct rockchip_tsadc_platform_data *)match=
->data;
>> +	if (!data->pdata)
>> +		return -EINVAL;
>> +	tsadc =3D data->pdata;
>> +
>> +	data->clk =3D devm_clk_get(&pdev->dev, "tsadc");
>> +	if (IS_ERR(data->clk)) {
>> +		dev_err(&pdev->dev, "failed to get tsadc clock\n");
>> +		return PTR_ERR(data->clk);
>> +	}
>> +
>> +	data->pclk =3D devm_clk_get(&pdev->dev, "apb_pclk");
>> +	if (IS_ERR(data->pclk)) {
>> +		dev_err(&pdev->dev, "failed to get tsadc pclk\n");
>> +		return PTR_ERR(data->pclk);
>> +	}
>> +
>> +	/**
>> +	* Use a default of 10KHz for the converter clock.
>> +	* This may become user-configurable in the future.
>> +	* Need to judge the data->clk is Divided by xin32k.
>> +	* Need to retry it if the pmic hasn't output the xin32k.
>> +	*/
>> +	if (clk_get_rate(data->clk) =3D=3D 0)
>> +		return -EPROBE_DEFER;
> What would cause the clock to be present but report 0 rate? Are we su=
re
> that it will start reporting different data after binding some more
> drivers?
>

The clk is divided by xin32k from PMIC(rk808_clk_out),
the PMIC output the xin32k seem isn't readied before get the clk.

If the PMIC(rk808) driver is more front loading,I believe it will hasn'=
t=20
this prblem.

>> +	ret =3D clk_set_rate(data->clk, 10000);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to set tsadc clk rate, %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret =3D clk_prepare_enable(data->clk);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to enable converter clock\n");
>> +		goto err_clk;
>> +	}
>> +
>> +	ret =3D clk_prepare_enable(data->pclk);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to enable pclk\n");
>> +		goto err_pclk;
>> +	}
>> +
>> +	cpumask_set_cpu(0, &clip_cpus);
>> +	data->cdev =3D of_cpufreq_cooling_register(np, &clip_cpus);
>> +	if (IS_ERR(data->cdev)) {
>> +		dev_err(&pdev->dev, "failed to register cpufreq cooling device\n"=
);
>> +		goto disable_clk;
>> +	}
>> +
>> +	data->irq =3D platform_get_irq(pdev, 0);
>> +	if (data->irq < 0) {
>> +		dev_err(&pdev->dev, "no irq resource?\n");
>> +		goto disable_clk;
>> +	}
>> +
>> +	ret =3D devm_request_threaded_irq(&pdev->dev, data->irq, NULL,
>> +					&rockchip_thermal_alarm_irq_thread,
>> +					IRQF_ONESHOT, "rockchip_thermal",
>> +					data);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"failed to request tsadc irq: %d\n", ret);
>> +		goto disable_clk;
>> +	}
>> +
>> +	ret =3D rockchip_configure_from_dt(&pdev->dev, np, data);
>> +	if (ret)
>> +		dev_err(&pdev->dev, "Parsing device tree data error.\n");
>> +
>> +	/* The system three Teperture Sensors be registered */
>> +	for (chn =3D RESERVE; chn < SENSOR_ID_END; chn++) {
>> +		data->chn =3D chn;
>> +
>> +		data->tz[chn] =3D thermal_zone_of_sensor_register(
>> +				&pdev->dev, data->chn,
>> +				data, rockchip_thermal_get_temp,
>> +				NULL,
>> +				rockchip_thermal_set_trips);
>> +		if (IS_ERR(data->tz[chn])) {
>> +			err =3D PTR_ERR(data->tz[chn]);
>> +			dev_err(&pdev->dev, "failed to register sensor: %d\n",
>> +				err);
>> +			chn--;
>> +			goto unregister_tzs;
>> +		}
> Do we have to have all zones defined? Why?
>

Yes, I think so.

At least, CPU and GPU zone is need.

As the TRM introduce,this system has three temperature sensors.
>> +
>> +		platform_set_drvdata(pdev, data);
>> +
>> +		rockchip_thermal_initialize(data);
>> +		rockchip_thermal_control(data, true);
>> +	}
>> +	return 0;
>> +
>> +unregister_tzs:
>> +	for (; chn >=3D RESERVE; chn--)
>> +		thermal_zone_of_sensor_unregister(&pdev->dev, data->tz[chn]);
>> +	cpufreq_cooling_unregister(data->cdev);
>> +
>> +disable_clk:
>> +err_pclk:
>> +	clk_disable_unprepare(data->pclk);
>> +err_clk:
>> +	clk_disable_unprepare(data->clk);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rockchip_thermal_remove(struct platform_device *pdev)
>> +{
>> +	struct rockchip_thermal_data *data =3D platform_get_drvdata(pdev);
>> +	int chn;
>> +
>> +	rockchip_thermal_control(data, false);
>> +
>> +	for (; chn >=3D RESERVE; chn--)
> You are not initializing chn, it will blow up.

=46ixed.
>> +		thermal_zone_of_sensor_unregister(&pdev->dev, data->tz[chn]);
>> +	cpufreq_cooling_unregister(data->cdev);
>> +
>> +	clk_disable_unprepare(data->clk);
>> +	clk_disable_unprepare(data->pclk);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int rockchip_thermal_suspend(struct device *dev)
>> +{
>> +	struct platform_device *pdev =3D to_platform_device(dev);
>> +	struct rockchip_thermal_data *data =3D platform_get_drvdata(pdev);
>> +
>> +	rockchip_thermal_control(data, false);
>> +
>> +	clk_disable_unprepare(data->clk);
>> +	clk_disable_unprepare(data->pclk);
> Why do we unpreparing in suspend instead of just disabling?

=46ixed.
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_thermal_resume(struct device *dev)
>> +{
>> +	struct platform_device *pdev =3D to_platform_device(dev);
>> +	struct rockchip_thermal_data *data =3D platform_get_drvdata(pdev);
>> +	int ret;
>> +
>> +	ret =3D clk_prepare_enable(data->pclk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D clk_prepare_enable(data->clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	rockchip_thermal_initialize(data);
>> +	rockchip_thermal_control(data, true);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(rockchip_thermal_pm_ops,
>> +			 rockchip_thermal_suspend, rockchip_thermal_resume);
>> +
>> +static struct platform_driver rockchip_thermal_driver =3D {
>> +	.driver =3D {
>> +		   .name =3D "rockchip-thermal",
>> +		   .owner =3D THIS_MODULE,
>> +		   .pm =3D &rockchip_thermal_pm_ops,
>> +		   .of_match_table =3D of_rockchip_thermal_match,
>> +		   },
>> +	.probe =3D rockchip_thermal_probe,
>> +	.remove =3D rockchip_thermal_remove,
>> +};
>> +
>> +module_platform_driver(rockchip_thermal_driver);
>> +
>> +MODULE_DESCRIPTION("ROCKCHIP THERMAL Driver");
>> +MODULE_AUTHOR("Rockchip, Inc.");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:rockchip-thermal");
>> --=20
>> 1.9.1
>>
>>
> Thanks.
>

--=20
Best regards,
Caesar



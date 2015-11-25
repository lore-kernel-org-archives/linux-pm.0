From: "Josef Gajdusek" <atx-MwjtXicnQwU@public.gmane.org>
Subject: Re: Re: [PATCH v2 3/5] thermal: Add a driver for   the
 Allwinner THS sensor
Date: Wed, 25 Nov 2015 11:02:34 +0000
Message-ID: <0edf1031924124377647dfb0f62ec6c8@rainloop.atalax.net>
References: <20151124084342.GJ32142@lukather>  
 <cover.1448263428.git.atx@atx.name>   
 <ea5d8edefd251f2b76660b43a4ea4dc89c3b2f38.1448263428.git.atx@atx.name>
Reply-To: atx-MwjtXicnQwU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCYM5N4ES4IRBQ5K22ZAKGQENGHUDUY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151124084342.GJ32142@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

November 24 2015 9:43 AM, "Maxime Ripard" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> On Mon, Nov 23, 2015 at 09:02:50AM +0100, Josef Gajdusek wrote:
> 
>> This patch adds support for the Sunxi thermal sensor on the Allwinner H3.
> 
> You can drop the sunxi here.
> 
>> Should be easily extendable for the A33/A83T/... as they have similar but
>> not completely identical sensors.
>> 
>> Signed-off-by: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
>> ---
>> drivers/thermal/Kconfig | 7 +
>> drivers/thermal/Makefile | 1 +
>> drivers/thermal/sun8i_ths.c | 365 ++++++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 373 insertions(+)
>> create mode 100644 drivers/thermal/sun8i_ths.c
>> 
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index c463c89..2b41147 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -365,6 +365,13 @@ config INTEL_PCH_THERMAL
>> Thermal reporting device will provide temperature reading,
>> programmable trip points and other information.
>> 
>> +config SUN8I_THS
>> + tristate "sun8i THS driver"
>> + depends on MACH_SUN8I
>> + depends on OF
>> + help
>> + Enable this to support thermal reporting on some newer Allwinner SoCs.
>> +
>> menu "Texas Instruments thermal drivers"
>> depends on ARCH_HAS_BANDGAP || COMPILE_TEST
>> source "drivers/thermal/ti-soc-thermal/Kconfig"
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index cfae6a6..227e1a1 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -48,3 +48,4 @@ obj-$(CONFIG_INTEL_PCH_THERMAL) += intel_pch_thermal.o
>> obj-$(CONFIG_ST_THERMAL) += st/
>> obj-$(CONFIG_TEGRA_SOCTHERM) += tegra_soctherm.o
>> obj-$(CONFIG_HISI_THERMAL) += hisi_thermal.o
>> +obj-$(CONFIG_SUN8I_THS) += sun8i_ths.o
>> diff --git a/drivers/thermal/sun8i_ths.c b/drivers/thermal/sun8i_ths.c
>> new file mode 100644
>> index 0000000..2c976ac
>> --- /dev/null
>> +++ b/drivers/thermal/sun8i_ths.c
>> @@ -0,0 +1,365 @@
>> +/*
>> + * Sunxi THS driver
> 
> sun8i Thermal Sensor Driver
> 
>> + * Copyright (C) 2015 Josef Gajdusek
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
> 
> Are you using this header?
> 
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
> 
> You probably don't need this one too.
> 
>> +#include <linux/module.h>
>> +#include <linux/nvmem-consumer.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/printk.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +#include <linux/thermal.h>
>> +
>> +#define THS_H3_CTRL0 0x00
>> +#define THS_H3_CTRL1 0x04
>> +#define THS_H3_CDAT 0x14
>> +#define THS_H3_CTRL2 0x40
>> +#define THS_H3_INT_CTRL 0x44
>> +#define THS_H3_STAT 0x48
>> +#define THS_H3_ALARM_CTRL 0x50
>> +#define THS_H3_SHUTDOWN_CTRL 0x60
>> +#define THS_H3_FILTER 0x70
>> +#define THS_H3_CDATA 0x74
>> +#define THS_H3_DATA 0x80
>> +
>> +#define THS_H3_CTRL0_SENSOR_ACQ0_OFFS 0
>> +#define THS_H3_CTRL0_SENSOR_ACQ0(x) \
>> + ((x) << THS_H3_CTRL0_SENSOR_ACQ0_OFFS)
>> +#define THS_H3_CTRL1_ADC_CALI_EN_OFFS 17
>> +#define THS_H3_CTRL1_ADC_CALI_EN \
>> + BIT(THS_H3_CTRL1_ADC_CALI_EN_OFFS)
>> +#define THS_H3_CTRL1_OP_BIAS_OFFS 20
>> +#define THS_H3_CTRL1_OP_BIAS(x) \
>> + ((x) << THS_H3_CTRL1_OP_BIAS_OFFS)
>> +#define THS_H3_CTRL2_SENSE_EN_OFFS 0
>> +#define THS_H3_CTRL2_SENSE_EN \
>> + BIT(THS_H3_CTRL2_SENSE_EN_OFFS)
>> +#define THS_H3_CTRL2_SENSOR_ACQ1_OFFS 16
>> +#define THS_H3_CTRL2_SENSOR_ACQ1(x) \
>> + ((x) << THS_H3_CTRL2_SENSOR_ACQ1_OFFS)
>> +
>> +#define THS_H3_INT_CTRL_ALARM_INT_EN_OFFS 0
>> +#define THS_H3_INT_CTRL_ALARM_INT_EN \
>> + BIT(THS_H3_INT_CTRL_ALARM_INT_EN_OFFS)
>> +#define THS_H3_INT_CTRL_SHUT_INT_EN_OFFS 4
>> +#define THS_H3_INT_CTRL_SHUT_INT_EN \
>> + BIT(THS_H3_INT_CTRL_SHUT_INT_EN_OFFS)
>> +#define THS_H3_INT_CTRL_DATA_IRQ_EN_OFFS 8
>> +#define THS_H3_INT_CTRL_DATA_IRQ_EN \
>> + BIT(THS_H3_INT_CTRL_DATA_IRQ_EN_OFFS)
>> +#define THS_H3_INT_CTRL_THERMAL_PER_OFFS 12
>> +#define THS_H3_INT_CTRL_THERMAL_PER(x) \
>> + ((x) << THS_H3_INT_CTRL_THERMAL_PER_OFFS)
>> +
>> +#define THS_H3_STAT_ALARM_INT_STS_OFFS 0
>> +#define THS_H3_STAT_ALARM_INT_STS \
>> + BIT(THS_H3_STAT_ALARM_INT_STS_OFFS)
>> +#define THS_H3_STAT_SHUT_INT_STS_OFFS 4
>> +#define THS_H3_STAT_SHUT_INT_STS \
>> + BIT(THS_H3_STAT_SHUT_INT_STS_OFFS)
>> +#define THS_H3_STAT_DATA_IRQ_STS_OFFS 8
>> +#define THS_H3_STAT_DATA_IRQ_STS \
>> + BIT(THS_H3_STAT_DATA_IRQ_STS_OFFS)
>> +#define THS_H3_STAT_ALARM_OFF_STS_OFFS 12
>> +#define THS_H3_STAT_ALARM_OFF_STS \
>> + BIT(THS_H3_STAT_ALARM_OFF_STS_OFFS)
>> +
>> +#define THS_H3_ALARM_CTRL_ALARM0_T_HYST_OFFS 0
>> +#define THS_H3_ALARM_CTRL_ALARM0_T_HYST(x) \
>> + ((x) << THS_H3_ALARM_CTRL_ALARM0_T_HYST_OFFS)
>> +#define THS_H3_ALARM_CTRL_ALARM0_T_HOT_OFFS 16
>> +#define THS_H3_ALARM_CTRL_ALARM0_T_HOT(x) \
>> + ((x) << THS_H3_ALARM_CTRL_ALARM0_T_HOT_OFFS)
>> +
>> +#define THS_H3_SHUTDOWN_CTRL_SHUT0_T_HOT_OFFS 16
>> +#define THS_H3_SHUTDOWN_CTRL_SHUT0_T_HOT(x) \
>> + ((x) << THS_H3_SHUTDOWN_CTRL_SHUT0_T_HOT_OFFS)
>> +
>> +#define THS_H3_FILTER_TYPE_OFFS 0
>> +#define THS_H3_FILTER_TYPE(x) \
>> + ((x) << THS_H3_FILTER_TYPE_OFFS)
>> +#define THS_H3_FILTER_EN_OFFS 2
>> +#define THS_H3_FILTER_EN \
>> + BIT(THS_H3_FILTER_EN_OFFS)
> 
> Are you using these offsets anywhere?
>> +
>> +#define THS_H3_CTRL0_SENSOR_ACQ0_VALUE 0xff
>> +#define THS_H3_INT_CTRL_THERMAL_PER_VALUE 0x79
>> +#define THS_H3_FILTER_TYPE_VALUE 0x2
>> +#define THS_H3_CTRL2_SENSOR_ACQ1_VALUE 0x3f
>> +
>> +struct sun8i_ths_data {
>> + struct sun8i_ths_type *type;
>> + struct reset_control *reset;
>> + struct clk *clk;
>> + struct clk *busclk;
>> + void __iomem *regs;
>> + struct nvmem_cell *calcell;
>> + struct platform_device *pdev;
>> + struct thermal_zone_device *tzd;
>> +};
>> +
>> +struct sun8i_ths_type {
>> + int (*init)(struct platform_device *, struct sun8i_ths_data *);
>> + int (*get_temp)(struct sun8i_ths_data *, int *out);
>> + void (*irq)(struct sun8i_ths_data *);
>> + void (*deinit)(struct sun8i_ths_data *);
>> +};
> 
> AFAIK, you never got back on why it was actually needed, instead of
> directly calling these functions.

It is preparation for supporting the other SoCs with THS as they have
slightly different register layouts and thus cannot be controlled by the
same code.

>> +/* Formula and parameters from the Allwinner 3.4 kernel */
>> +static int sun8i_ths_reg_to_temperature(s32 reg, int divisor, int constant)
>> +{
>> + return constant - (reg * 1000000) / divisor;
>> +}
>> +
>> +static int sun8i_ths_get_temp(void *_data, int *out)
>> +{
>> + struct sun8i_ths_data *data = _data;
>> +
>> + return data->type->get_temp(data, out);
>> +}
>> +
>> +static irqreturn_t sun8i_ths_irq_thread(int irq, void *_data)
>> +{
>> + struct sun8i_ths_data *data = _data;
>> +
>> + data->type->irq(data);
>> + thermal_zone_device_update(data->tzd);
>> +
>> + return IRQ_HANDLED;
>> +}
>> +
>> +static int sun8i_ths_h3_init(struct platform_device *pdev,
>> + struct sun8i_ths_data *data)
>> +{
>> + int ret;
>> + size_t callen;
>> + s32 *caldata;
>> +
>> + data->busclk = devm_clk_get(&pdev->dev, "ahb");
>> + if (IS_ERR(data->busclk)) {
>> + ret = PTR_ERR(data->busclk);
>> + dev_err(&pdev->dev, "failed to get ahb clk: %d\n", ret);
>> + return ret;
>> + }
>> +
>> + data->clk = devm_clk_get(&pdev->dev, "ths");
>> + if (IS_ERR(data->clk)) {
>> + ret = PTR_ERR(data->clk);
>> + dev_err(&pdev->dev, "failed to get ths clk: %d\n", ret);
>> + return ret;
>> + }
>> +
>> + data->reset = devm_reset_control_get(&pdev->dev, "ahb");
>> + if (IS_ERR(data->reset)) {
>> + ret = PTR_ERR(data->reset);
>> + dev_err(&pdev->dev, "failed to get reset: %d\n", ret);
>> + return ret;
>> + }
>> +
>> + if (data->calcell) {
>> + caldata = nvmem_cell_read(data->calcell, &callen);
>> + if (IS_ERR(caldata))
>> + return PTR_ERR(caldata);
>> + writel(be32_to_cpu(*caldata), data->regs + THS_H3_CDATA);
>> + kfree(caldata);
>> + }
>> +
>> + ret = clk_prepare_enable(data->busclk);
>> + if (ret) {
>> + dev_err(&pdev->dev, "failed to enable bus clk: %d\n", ret);
>> + return ret;
>> + }
>> +
>> + ret = clk_prepare_enable(data->clk);
>> + if (ret) {
>> + dev_err(&pdev->dev, "failed to enable ths clk: %d\n", ret);
>> + goto err_disable_bus;
>> + }
>> +
>> + ret = reset_control_deassert(data->reset);
>> + if (ret) {
>> + dev_err(&pdev->dev, "reset deassert failed: %d\n", ret);
>> + goto err_disable_ths;
>> + }
>> +
>> + /* The final sample period is calculated as follows:
>> + * (THERMAL_PER + 1) * 4096 / f_clk * 2^(FILTER_TYPE + 1)
>> + *
>> + * This results to about 1Hz with these settings.
>> + */
>> + ret = clk_set_rate(data->clk, 4000000);
> 
> I don't follow you here. You have a complicated math function, that
> has many input variables, and then, you just set the clock rate to a
> constant?

How should this be handled then? I guess the sampling rate could
be set in the device tree and then the values calculated, but none
of the other thermal drivers seem to have configurable sample rate.

>> + if (ret)
>> + goto err_disable_ths;
> 
> A new line here please
> 
>> + writel(THS_H3_CTRL0_SENSOR_ACQ0(THS_H3_CTRL0_SENSOR_ACQ0_VALUE),
>> + data->regs + THS_H3_CTRL0);
>> + writel(THS_H3_INT_CTRL_THERMAL_PER(THS_H3_INT_CTRL_THERMAL_PER_VALUE) |
>> + THS_H3_INT_CTRL_DATA_IRQ_EN,
>> + data->regs + THS_H3_INT_CTRL);
>> + writel(THS_H3_FILTER_EN | THS_H3_FILTER_TYPE(THS_H3_FILTER_TYPE_VALUE),
>> + data->regs + THS_H3_FILTER);
>> + writel(THS_H3_CTRL2_SENSOR_ACQ1(THS_H3_CTRL2_SENSOR_ACQ1_VALUE) |
>> + THS_H3_CTRL2_SENSE_EN,
>> + data->regs + THS_H3_CTRL2);
> 
> And here too.
> 
>> + return 0;
>> +
>> +err_disable_ths:
>> + clk_disable_unprepare(data->clk);
>> +err_disable_bus:
>> + clk_disable_unprepare(data->busclk);
>> +
>> + return ret;
>> +}
>> +
>> +static int sun8i_ths_h3_get_temp(struct sun8i_ths_data *data, int *out)
>> +{
>> + int val = readl(data->regs + THS_H3_DATA);
>> + *out = sun8i_ths_reg_to_temperature(val, 8253, 217000);
>> + return 0;
> 
> Can't you just return the value directly?

I did that in the v1, clabbe.montjoie suggested to use temp variable to
avoid column wrap.

>> +}
>> +
>> +static void sun8i_ths_h3_irq(struct sun8i_ths_data *data)
>> +{
>> + writel(THS_H3_STAT_DATA_IRQ_STS |
>> + THS_H3_STAT_ALARM_INT_STS |
>> + THS_H3_STAT_ALARM_OFF_STS |
>> + THS_H3_STAT_SHUT_INT_STS,
>> + data->regs + THS_H3_STAT);
> 
> So you're always clearing all the interrupts? Shouldn't you just clear
> only the interrupt you received?
> 
>> +}
>> +
>> +static void sun8i_ths_h3_deinit(struct sun8i_ths_data *data)
>> +{
>> + reset_control_assert(data->reset);
>> + clk_disable_unprepare(data->clk);
>> + clk_disable_unprepare(data->busclk);
>> +}
>> +
>> +static const struct thermal_zone_of_device_ops sun8i_ths_thermal_ops = {
>> + .get_temp = sun8i_ths_get_temp,
>> +};
>> +
>> +static const struct sun8i_ths_type sun8i_ths_device_h3 = {
>> + .init = sun8i_ths_h3_init,
>> + .get_temp = sun8i_ths_h3_get_temp,
>> + .irq = sun8i_ths_h3_irq,
>> + .deinit = sun8i_ths_h3_deinit,
>> +};
>> +
>> +static const struct of_device_id sun8i_ths_id_table[] = {
>> + {
>> + .compatible = "allwinner,sun8i-h3-ths",
>> + .data = &sun8i_ths_device_h3,
>> + },
>> + {
>> + /* sentinel */
>> + },
>> +};
>> +MODULE_DEVICE_TABLE(of, sun8i_ths_id_table);
>> +
>> +static int sun8i_ths_probe(struct platform_device *pdev)
>> +{
>> + struct device_node *np = pdev->dev.of_node;
>> + const struct of_device_id *match;
>> + struct sun8i_ths_data *data;
>> + struct resource *res;
>> + int ret;
>> + int irq;
>> +
>> + match = of_match_node(sun8i_ths_id_table, np);
> 
> If you *really* need to (but I still don't really see why), you can
> use of_device_get_match_data here.
> 
>> +
>> + data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> + if (!data)
>> + return -ENOMEM;
>> +
>> + data->type = (struct sun8i_ths_type *)match->data;
>> + data->pdev = pdev;
>> +
>> + data->calcell = devm_nvmem_cell_get(&pdev->dev, "calibration");
>> + if (IS_ERR(data->calcell)) {
>> + if (PTR_ERR(data->calcell) == -EPROBE_DEFER)
>> + return PTR_ERR(data->calcell);
> 
> New line
> 
>> + data->calcell = NULL; /* No calibration register */
> 
> s/register/data/ ?
> 
>> + }
>> +
>> + res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + data->regs = devm_ioremap_resource(&pdev->dev, res);
>> + if (IS_ERR(data->regs)) {
>> + ret = PTR_ERR(data->regs);
>> + dev_err(&pdev->dev,
>> + "failed to ioremap THS registers: %d\n", ret);
>> + return ret;
>> + }
>> +
>> + irq = platform_get_irq(pdev, 0);
>> + if (irq < 0) {
>> + dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
>> + return irq;
>> + }
>> +
>> + ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>> + sun8i_ths_irq_thread, IRQF_ONESHOT,
>> + dev_name(&pdev->dev), data);
> 
> Why a threaded irq?

I thought threaded IRQs are preferred? Other thermal drivers
use them too. I am also not really sure thermal_zone_device_update()
can even be called in interrupt context.

>> + if (ret)
>> + return ret;
>> +
>> + ret = data->type->init(pdev, data);
>> + if (ret)
>> + return ret;
>> +
>> + data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
>> + &sun8i_ths_thermal_ops);
>> + if (IS_ERR(data->tzd)) {
>> + ret = PTR_ERR(data->tzd);
>> + dev_err(&pdev->dev, "failed to register thermal zone: %d\n",
>> + ret);
>> + goto err_deinit;
>> + }
>> +
>> + platform_set_drvdata(pdev, data);
>> + return 0;
>> +
>> +err_deinit:
>> + data->type->deinit(data);
>> + return ret;
>> +}
>> +
>> +static int sun8i_ths_remove(struct platform_device *pdev)
>> +{
>> + struct sun8i_ths_data *data = platform_get_drvdata(pdev);
>> +
>> + thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
>> + data->type->deinit(data);
>> + return 0;
>> +}
>> +
>> +static struct platform_driver sun8i_ths_driver = {
>> + .probe = sun8i_ths_probe,
>> + .remove = sun8i_ths_remove,
>> + .driver = {
>> + .name = "sun8i_ths",
>> + .of_match_table = sun8i_ths_id_table,
>> + },
>> +};
>> +
>> +module_platform_driver(sun8i_ths_driver);
>> +
>> +MODULE_AUTHOR("Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>");
>> +MODULE_DESCRIPTION("Sunxi THS driver");
> 
> Please change the description here too to match the header.
> 
> Thanks!
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> 
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to
> linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.


Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>

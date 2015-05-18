From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH RESEND v4 2/2] thermal: hisilicon: add new hisilicon thermal
 sensor driver
Date: Mon, 18 May 2015 12:03:11 +0800
Message-ID: <5559647F.1060209@hisilicon.com>
References: <1430707940-14468-1-git-send-email-kong.kongxinwei@hisilicon.com> <1430707940-14468-3-git-send-email-kong.kongxinwei@hisilicon.com> <20150512012926.GD4810@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:5974 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbbEREFj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 00:05:39 -0400
In-Reply-To: <20150512012926.GD4810@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, rui.zhuang@intel.com
Cc: amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, devicetree@vger.kernel.org, dan.zhao@hisilicon.com, liguozhu@hisilicon.com, mporter@konsulko.com, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, leo.yan@linaro.org, zhenwei.wang@hisilicon.com, zhangfei.gao@linaro.org, z.liuxinliang@huawei.com, xuwei5@hisilicon.com, w.f@huawei.com, yuanzhichang@hisilicon.com, mark.rutland@arm.com, bintian.wang@huawei.com

hi Eduardo,

this following review log is from our min systerm patchset. this thermal
sensor driver is important part for 96boards. If our thermal sensor can't
be merged into kernel and the min systerm be merged. the board is not safe
for using man (causing fire). So i wish you can accept this patchset before
the min systerm patchset is accepted.

thanks
Xinwei


On 2015/5/7 17:02, Will Deacon wrote:> Hi Bintian,
>
> On Tue, May 05, 2015 at 01:06:34PM +0100, Bintian Wang wrote:
>> PSCI is enabled in device tree and there is no problem to boot all the
>> octal cores, and the CPU hotplug is also working now, you can download
>> and compile the latest firmware based on the following link to run this
>> patch set:
>> https://github.com/96boards/documentation/wiki/UEFI
>>
>> Changes v4:
>> * Rebase to kernel 4.1-rc1
>> * Delete "arm,cortex-a15-gic" from the gic node in dts
>
> I gave these patches a go on top of -rc2 using the ATF and UEFI you link to
> above.
>
> The good news is that the thing booted and all the cores entered at EL2.
> Thanks!
>
> The bad news is that running hackbench quickly got the *heatsink*
> temperature to 73 degress C and rising (measured with an infrared
> thermometer).
>
> So my question is, does this SoC have an automatic thermal cut out? Whilst
> I'm all for merging enabling code into the kernel, if it really relies on
> the kernel to stop it from catching fire, maybe it's not a great idea
> putting these patches into people's hands just yet.
>
> Will
>
> .
>

On 2015/5/12 9:29, Eduardo Valentin wrote:
> Dear Kongxinwei,
> 
> 
> Apologize for late answer. I really missed this one. Let's make it for
> the next merge window!
> 
> Please find a couple of comments as follows.
> 
> 
> On Mon, May 04, 2015 at 10:52:20AM +0800, Xinwei Kong wrote:
>> From: kongxinwei <kong.kongxinwei@hisilicon.com>
>>
>> This patch adds the support for hisilicon thermal sensor, within
>> hisilicon SoC. there will register sensors for thermal framework
>> and use device tree to bind cooling device.
>>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
>> ---
>>  drivers/thermal/Kconfig        |   8 +
>>  drivers/thermal/Makefile       |   1 +
>>  drivers/thermal/hisi_thermal.c | 437 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 446 insertions(+)
>>  create mode 100644 drivers/thermal/hisi_thermal.c
> 
> 
> Please, make sure you have a clean ./checkpatch.pl --strict output.
> Today, in this version, I see the following summary:
> 
> # ./scripts/checkpatch.pl --strict /tmp/a
> total: 0 errors, 2 warnings, 7 checks, 455 lines checked
> 
> /tmp/a has style problems, please review.
> 
> If any of these errors are false positives, please report
> them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> Can you please clean them up?
> 
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index af40db0..81aee01 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -136,6 +136,14 @@ config THERMAL_EMULATION
>>  	  because userland can easily disable the thermal policy by simply
>>  	  flooding this sysfs node with low temperature values.
>>  
>> +config HISI_THERMAL
>> +	tristate "Hisilicon thermal driver"
>> +	depends on ARCH_HISI && CPU_THERMAL && OF
>> +	help
>> +	  Enable this to plug hisilicon's thermal sensor driver into the Linux
>> +	  thermal framework. cpufreq is used as the cooling device to throttle
>> +	  CPUs when the passive trip is crossed.
>> +
>>  config IMX_THERMAL
>>  	tristate "Temperature sensor driver for Freescale i.MX SoCs"
>>  	depends on CPU_THERMAL
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index fa0dc48..08ae7ac 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -39,3 +39,4 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
>>  obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
>>  obj-$(CONFIG_ST_THERMAL)	+= st/
>>  obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
>> +obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
>> new file mode 100644
>> index 0000000..255c71b
>> --- /dev/null
>> +++ b/drivers/thermal/hisi_thermal.c
>> @@ -0,0 +1,437 @@
>> +/*
>> + * Hisilicon thermal sensor driver
>> + *
>> + * Copyright (c) 2014-2015 Hisilicon Limited.
>> + * Copyright (c) 2014-2015 Linaro Limited.
>> + *
>> + * Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> + * Leo Yan <leo.yan@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/cpufreq.h>
> 
> I don't see why you need this header.
> 
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/syscon.h>
> 
> neither this
> 
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
> 
> or this
> 
>> +#include <linux/slab.h>
>> +#include <linux/thermal.h>
>> +#include <linux/types.h>
>> +
>> +#include "thermal_core.h"
> 
> 
> Please review the above includes. Leave only those you are using.
> 
>> +
>> +#define TEMP0_TH			(0x4)
>> +#define TEMP0_RST_TH			(0x8)
>> +#define TEMP0_CFG			(0xC)
>> +#define TEMP0_EN			(0x10)
>> +#define TEMP0_INT_EN			(0x14)
>> +#define TEMP0_INT_CLR			(0x18)
>> +#define TEMP0_RST_MSK			(0x1C)
>> +#define TEMP0_VALUE			(0x28)
>> +
>> +#define HISI_TEMP_BASE			(-60)
>> +#define HISI_TEMP_RESET			(100000)
>> +
>> +#define HISI_MAX_SENSORS		4
>> +
>> +struct hisi_thermal_sensor {
>> +	struct hisi_thermal_data *thermal;
>> +	struct thermal_zone_device *tzd;
>> +	const struct thermal_trip *trip;
>> +
>> +	uint32_t id;
>> +	uint32_t thres_temp;
>> +	uint32_t reset_temp;
> 
> reset_temp is never used in this driver.
> 
>> +};
>> +
>> +struct hisi_thermal_data {
>> +	struct mutex thermal_lock;
>> +	struct platform_device *pdev;
>> +	struct clk *clk;
>> +
>> +	int irq, irq_bind_sensor;
>> +	bool irq_enabled;
>> +
>> +	unsigned int sensors_num;
>> +	long sensor_temp[HISI_MAX_SENSORS];
>> +	struct hisi_thermal_sensor sensors[HISI_MAX_SENSORS];
> 
> Does it make sense to make sensor_temp part of hisi_thermal_sensors?
> 
> Then you would access it through sensors.sensor_temp
> 
>> +
>> +	void __iomem *regs;
>> +};
>> +
>> +/* in millicelsius */
>> +static inline int _step_to_temp(int step)
>> +{
>> +	/*
>> +	 * Every step equals (1 * 200) / 255 celsius, and finally
>> +	 * need convert to millicelsius.
>> +	 */
>> +	return (HISI_TEMP_BASE + (step * 200 / 255)) * 1000;
>> +}
>> +
>> +static inline int _temp_to_step(int temp)
>> +{
>> +	return ((temp / 1000 - HISI_TEMP_BASE) * 255 / 200);
>> +}
>> +
>> +static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
>> +					 struct hisi_thermal_sensor *sensor)
>> +{
>> +	int val;
>> +
>> +	mutex_lock(&data->thermal_lock);
>> +
>> +	/* disable interrupt */
>> +	writel(0x0, data->regs + TEMP0_INT_EN);
>> +	writel(0x1, data->regs + TEMP0_INT_CLR);
>> +
>> +	/* disable module firstly */
>> +	writel(0x0, data->regs + TEMP0_EN);
>> +
>> +	/* select sensor id */
>> +	writel((sensor->id << 12), data->regs + TEMP0_CFG);
>> +
>> +	/* enable module */
>> +	writel(0x1, data->regs + TEMP0_EN);
>> +
>> +	usleep_range(3000, 5000);
>> +
>> +	val = readl(data->regs + TEMP0_VALUE);
>> +	val = _step_to_temp(val);
>> +
>> +	/* adjust for negative value */
>> +	val = (val < 0) ? 0 : val;
> 
> Why?
> 
> What does val < 0 mean here? Does it mean negative temperature or an
> error?
> 
> BTW, There is ongoing work to allow, at least representing, negative
> temperature.
> 
> 
>> +
>> +	mutex_unlock(&data->thermal_lock);
>> +
>> +	return val;
>> +}
>> +
>> +static void hisi_thermal_bind_irq(struct hisi_thermal_data *data)
>> +{
>> +	struct hisi_thermal_sensor *sensor;
>> +
>> +	sensor = &data->sensors[data->irq_bind_sensor];
>> +
>> +	mutex_lock(&data->thermal_lock);
>> +
>> +	/* setting the hdak time */
>> +	writel(0x0, data->regs + TEMP0_CFG);
>> +
>> +	/* disable module firstly */
>> +	writel(0x0, data->regs + TEMP0_RST_MSK);
>> +	writel(0x0, data->regs + TEMP0_EN);
>> +
> 
> Sorry, I get confused when you tell me you need to disable the module
> every time you need to read temp / change irq configuration.
> 
> Is this really required?
> 
>> +	/* select sensor id */
>> +	writel((sensor->id << 12), data->regs + TEMP0_CFG);
>> +
>> +	/* enable for interrupt */
>> +	writel(_temp_to_step(sensor->thres_temp)
>> +			| 0x0FFFFFF00, data->regs + TEMP0_TH);
> 
> 
> nit: break after the | operator.
> 
>> +
>> +	writel(_temp_to_step(HISI_TEMP_RESET), data->regs + TEMP0_RST_TH);
>> +
>> +	/* enable module */
>> +	writel(0x1, data->regs + TEMP0_RST_MSK);
>> +	writel(0x1, data->regs + TEMP0_EN);
>> +
>> +	writel(0x0, data->regs + TEMP0_INT_CLR);
>> +	writel(0x1, data->regs + TEMP0_INT_EN);
>> +
>> +	usleep_range(3000, 5000);
>> +
>> +	mutex_unlock(&data->thermal_lock);
>> +
> nit: remove empty line.
> 
>> +}
>> +
>> +static void hisi_thermal_enable_sensor(struct hisi_thermal_data *data)
>> +{
>> +	hisi_thermal_bind_irq(data);
>> +}
>> +
>> +static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
>> +{
>> +
>> +	mutex_lock(&data->thermal_lock);
>> +
>> +	/* disable sensor module */
>> +	writel(0x0, data->regs + TEMP0_INT_EN);
>> +	writel(0x0, data->regs + TEMP0_RST_MSK);
>> +	writel(0x0, data->regs + TEMP0_EN);
>> +
>> +	mutex_unlock(&data->thermal_lock);
>> +
> 
> nit: remove empty line.
> 
>> +}
>> +
>> +static int hisi_thermal_get_temp(void *_sensor, long *temp)
>> +{
>> +	struct hisi_thermal_sensor *sensor = _sensor;
>> +	struct hisi_thermal_data *data = sensor->thermal;
>> +
>> +	int sensor_id = 0, i;
>> +	long max_temp = 0;
>> +
>> +	*temp = hisi_thermal_get_sensor_temp(data, sensor);
>> +
>> +	data->sensor_temp[sensor->id] = *temp;
>> +
>> +	for (i = 0; i < HISI_MAX_SENSORS; i++) {
>> +		if (data->sensor_temp[i] >= max_temp) {
>> +			max_temp = data->sensor_temp[i];
>> +			sensor_id = i;
>> +		}
>> +	}
>> +
>> +	data->irq_bind_sensor = sensor_id;
> 
> I believe this irq_bind_sensor needs to be protected by a lock.
> 
> You read it in t_irq context, write it here while getting temp, and read
> it in bind irq.
> 
> I still don't follow why you need it though, can you please explain?
> 
> In any case, seams to be racy, given that it is shared by the four
> sensors, but you don't lock it to use it.
> 
>> +
>> +	dev_dbg(&data->pdev->dev, "id=%d, irq=%d, temp=%ld, thres=%d\n",
>> +		sensor->id, data->irq_enabled, *temp, sensor->thres_temp);
>> +	/*
>> +	 * Bind irq to sensor for two cases:
>> +	 *   Reenable alarm IRQ if temperature below threshold;
>> +	 *   if irq has been enabled, always set it;
>> +	 */
>> +	if (data->irq_enabled) {
>> +		hisi_thermal_bind_irq(data);
>> +		return 0;
>> +	}
>> +
>> +	if (max_temp < sensor->thres_temp) {
>> +		data->irq_enabled = true;
>> +		hisi_thermal_bind_irq(data);
>> +		enable_irq(data->irq);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
>> +	.get_temp = hisi_thermal_get_temp,
>> +};
>> +
>> +static irqreturn_t hisi_thermal_alarm_irq(int irq, void *dev)
>> +{
>> +	struct hisi_thermal_data *data = dev;
>> +
>> +	disable_irq_nosync(irq);
>> +	data->irq_enabled = false;
>> +
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>> +static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
>> +{
>> +	struct hisi_thermal_data *data = dev;
>> +	struct hisi_thermal_sensor *sensor;
>> +	int i;
>> +
>> +	sensor = &data->sensors[data->irq_bind_sensor];
>> +
>> +	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
>> +		 sensor->thres_temp / 1000);
> 
> Do you really want to be printing this every time you receive an IRQ?
> 
>> +
>> +	for (i = 0; i < data->sensors_num; i++)
>> +		thermal_zone_device_update(data->sensors[i].tzd);
> 
> 
> Can you please educate me on how this chip works?
> 
> You receive a thermal alarm from the chip, does it really  mean you have
> to update all thermal zones? Or do you have a way to check which sensor
> generated the alarm irq?
> 
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int hisi_thermal_register_sensor(struct platform_device *pdev,
>> +					struct hisi_thermal_data *data,
>> +					struct hisi_thermal_sensor *sensor,
>> +					int index)
>> +{
>> +	int ret, i;
>> +
>> +	sensor->id = index;
>> +	sensor->thermal = data;
>> +
>> +	sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev, sensor->id,
>> +				sensor, &hisi_of_thermal_ops);
>> +	if (IS_ERR(sensor->tzd)) {
>> +		ret = PTR_ERR(sensor->tzd);
>> +		dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
>> +			sensor->id, ret);
>> +		return ret;
>> +	}
>> +
>> +	sensor->trip = of_thermal_get_trip_points(sensor->tzd);
>> +
>> +	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
>> +		if (sensor->trip[i].type == THERMAL_TRIP_PASSIVE) {
> 
> what if you have more than one passive trip? You just care about the
> first?
> 
>> +			sensor->thres_temp = sensor->trip[i].temperature;
> 
> Looks like you use sensor->trip only for filling thres_temp here. Does
> it make sense to use a local variable in this function, given you won't
> use sensor->trip anywhere else?
> 
>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id of_hisi_thermal_match[] = {
>> +	{ .compatible = "hisilicon,tsensor" },
>> +	{ /* end */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
>> +
>> +static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
>> +				       bool on)
>> +{
>> +	struct thermal_zone_device *tzd = sensor->tzd;
>> +
>> +	tzd->ops->set_mode(tzd,
>> +		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
>> +}
>> +
>> +static int hisi_thermal_probe(struct platform_device *pdev)
>> +{
>> +	struct hisi_thermal_data *data;
>> +	struct resource *res;
>> +	int i;
>> +	int ret;
>> +
>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&data->thermal_lock);
>> +	data->pdev = pdev;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	data->regs = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(data->regs)) {
>> +		dev_err(&pdev->dev, "failed to get io address\n");
>> +		return PTR_ERR(data->regs);
>> +	}
>> +
>> +	data->irq = platform_get_irq(pdev, 0);
>> +	if (data->irq < 0)
>> +		return data->irq;
>> +
>> +	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
>> +			hisi_thermal_alarm_irq, hisi_thermal_alarm_irq_thread,
>> +			0, "hisi_thermal", data);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, data);
>> +
>> +	data->clk = devm_clk_get(&pdev->dev, "thermal_clk");
>> +	if (IS_ERR(data->clk)) {
>> +		ret = PTR_ERR(data->clk);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(&pdev->dev,
>> +				"failed to get thermal clk: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* enable clock for thermal */
>> +	ret = clk_prepare_enable(data->clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
>> +		ret = hisi_thermal_register_sensor(pdev, data,
>> +					&data->sensors[i], i);
>> +		if (ret) {
>> +			dev_err(&pdev->dev,
>> +			"failed to register thermal sensor: %d\n", ret);
>> +			goto err_get_sensor_data;
>> +		}
>> +	}
>> +
>> +	hisi_thermal_enable_sensor(data);
>> +	data->irq_enabled = true;
>> +
>> +	for (i = 0; i < data->sensors_num; i++)
>> +		hisi_thermal_toggle_sensor(&data->sensors[i], true);
>> +
>> +	return 0;
>> +
>> +err_get_sensor_data:
>> +	clk_disable_unprepare(data->clk);
> 
> nit: empty line here to follow your pattern.
> 
>> +	return ret;
>> +}
>> +
>> +static int hisi_thermal_remove(struct platform_device *pdev)
>> +{
>> +	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
>> +	int i;
>> +
>> +	for (i = 0; i < data->sensors_num; i++) {
>> +		struct hisi_thermal_sensor *sensor = &data->sensors[i];
>> +
>> +		hisi_thermal_toggle_sensor(sensor, false);
>> +		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
>> +	}
>> +
>> +	hisi_thermal_disable_sensor(data);
>> +	clk_disable_unprepare(data->clk);
> 
> nit: empty line here to follow your pattern.
> 
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int hisi_thermal_suspend(struct device *dev)
>> +{
>> +	struct hisi_thermal_data *data = dev_get_drvdata(dev);
>> +
>> +	hisi_thermal_disable_sensor(data);
>> +	data->irq_enabled = false;
>> +
>> +	clk_disable_unprepare(data->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_thermal_resume(struct device *dev)
>> +{
>> +	struct hisi_thermal_data *data = dev_get_drvdata(dev);
>> +
>> +	clk_prepare_enable(data->clk);
>> +
>> +	data->irq_enabled = true;
>> +	hisi_thermal_enable_sensor(data);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
>> +			 hisi_thermal_suspend, hisi_thermal_resume);
>> +
>> +static struct platform_driver hisi_thermal_driver = {
>> +	.driver = {
>> +		.name	= "hisi_thermal",
>> +		.owner  = THIS_MODULE,
>> +		.pm	= &hisi_thermal_pm_ops,
>> +		.of_match_table = of_hisi_thermal_match,
> 
> 
> nit: align on the '=' operator.
> 
>> +	},
>> +	.probe		= hisi_thermal_probe,
>> +	.remove		= hisi_thermal_remove,
>> +};
>> +
>> +module_platform_driver(hisi_thermal_driver);
>> +
>> +MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
>> +MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
>> +MODULE_DESCRIPTION("Hisilicon thermal driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 1.9.1
>>
>>


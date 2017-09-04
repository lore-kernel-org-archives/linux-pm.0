From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Subject: Re: [PATCH v4 2/3] thermal: hisilicon: add thermal sensor driver for
 Hi3660
Date: Mon, 4 Sep 2017 15:56:27 +0800
Message-ID: <b884f2ca-86e1-0df3-0cbf-99b13232ee03@hisilicon.com>
References: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
 <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1503994666-13954-3-git-send-email-kevin.wangtao@hisilicon.com>
 <77ceb395-57bb-8de7-7b1a-3218baa5d5f3@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <77ceb395-57bb-8de7-7b1a-3218baa5d5f3@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, kevin.wangtao@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com
List-Id: linux-pm@vger.kernel.org



在 2017/9/1 5:17, Daniel Lezcano 写道:
> 
> Hi Kevin,
> 
> 
> On 29/08/2017 10:17, Tao Wang wrote:
>> From: Tao Wang <kevin.wangtao@linaro.org>
>>
>> This patch adds the support for thermal sensor of Hi3660 SoC.
> 
> for the Hi3660 SoC thermal sensor.
> 
>> this will register sensors for thermal framework and use device
>> tree to bind cooling device.
> 
> Is it possible to give a pointer to some documentation or to describe
> the hardware?
Yes, there used to be on patch V3, I removed it on V4.
> 
> An explanation of the adc min max coef[] range[] conversion would be nice.
OK
> 
> In addition, having the rational behind the average and the max would be
> nice. Do we really need both avg and max as virtual sensor?
We only need max currently.
> 
>> Signed-off-by: Tao Wang <kevin.wangtao@linaro.org>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> ---
>>   drivers/thermal/Kconfig        |  13 +++
>>   drivers/thermal/Makefile       |   1 +
>>   drivers/thermal/hisi_tsensor.c | 209 +++++++++++++++++++++++++++++++++++++++++
> 
> 
> IMO, we don't need a new file, but merge this code with the current
> hisi_thermal.c driver. BTW, the hi6220 has also a tsensor which is
> different from this one.
> 
> I suggest to base the hi3660 thermal driver on top of the cleanup I sent
> for the hi6220.
The tsensor of hi3660 is a different one, merging the code with hi6220 will need a lot of change.
> 
>>   3 files changed, 223 insertions(+)
>>   create mode 100644 drivers/thermal/hisi_tsensor.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index b5b5fac..32f582d 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -203,6 +203,19 @@ config HISI_THERMAL
>>   	  thermal framework. cpufreq is used as the cooling device to throttle
>>   	  CPUs when the passive trip is crossed.
>>   
>> +config HISI_TSENSOR
>> +	tristate "Hisilicon tsensor driver"
>> +	depends on ARCH_HISI || COMPILE_TEST
>> +	depends on HAS_IOMEM
>> +	depends on OF
>> +	default y
>> +	help
>> +	  Enable this to plug Hisilicon's tsensor driver into the Linux thermal
>> +	  framework. Besides all the hardware sensors, this also support two
>> +	  virtual sensors, one for maximum of all the hardware sensor, and
>> +	  one for average of all the hardware sensor.
>> +	  Compitable with Hi3660 or higher.
> 
> s/Compitable/Compatible/
OK
> 
>> +
>>   config IMX_THERMAL
>>   	tristate "Temperature sensor driver for Freescale i.MX SoCs"
>>   	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 094d703..8a16bd4 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -56,6 +56,7 @@ obj-$(CONFIG_ST_THERMAL)	+= st/
>>   obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>>   obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
>>   obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>> +obj-$(CONFIG_HISI_TSENSOR)	+= hisi_tsensor.o
>>   obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
>>   obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>>   obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
>> diff --git a/drivers/thermal/hisi_tsensor.c b/drivers/thermal/hisi_tsensor.c
>> new file mode 100644
>> index 0000000..34cf2ba
>> --- /dev/null
>> +++ b/drivers/thermal/hisi_tsensor.c
>> @@ -0,0 +1,209 @@
>> +/*
>> + *  linux/drivers/thermal/hisi_tsensor.c
>> + *
>> + *  Copyright (c) 2017 Hisilicon Limited.
>> + *  Copyright (c) 2017 Linaro Limited.
>> + *
>> + *  Author: Tao Wang <kevin.wangtao@linaro.org>
>> + *  Author: Leo Yan <leo.yan@linaro.org>
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; version 2 of the License.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/thermal.h>
>> +
>> +#include "thermal_core.h"
>> +
>> +#define VIRTUAL_SENSORS		2
>> +
>> +/* hisi Thermal Sensor Dev Structure */
>> +struct hisi_thermal_sensor {
>> +	struct hisi_thermal_data *thermal;
>> +	struct thermal_zone_device *tzd;
>> +	void __iomem *sensor_reg;
>> +	unsigned int id;
>> +};
>> +
>> +struct hisi_thermal_data {
>> +	struct platform_device *pdev;
>> +	struct hisi_thermal_sensor *sensors;
>> +	unsigned int range[2];
>> +	unsigned int coef[2];
>> +	unsigned int max_hw_sensor;
>> +};
>> +
>> +static int hisi_thermal_get_temp(void *_sensor, int *temp)
>> +{
>> +	struct hisi_thermal_sensor *sensor = _sensor;
>> +	struct hisi_thermal_data *data = sensor->thermal;
>> +	unsigned int idx, adc_min, adc_max, max_sensor;
>> +	int val, average = 0, max = 0;
>> +
>> +	adc_min = data->range[0];
>> +	adc_max = data->range[1];
>> +	max_sensor = data->max_hw_sensor;
>> +
>> +	if (sensor->id < max_sensor) {
>> +		val = readl(sensor->sensor_reg);
>> +		val = clamp_val(val, adc_min, adc_max);
> 
> That looks a bit fuzzy. Why not create a get_temp for physical sensor
> and another one for the virtual? So there will be a clear distinction
> between both.
make sense
> 
>> +	} else {
>> +		for (idx = 0; idx < max_sensor; idx++) {
>> +			val = readl(data->sensors[idx].sensor_reg);
> 
> Below, it is assumed thermal_zone_of_sensor_register() can fail and
> sensor->tzd becomes NULL. But no check is done here with the sensor's
> tzd. Shall the code assume we take all the sensors even if a thermal
> zone failed to register ?
Yes, thermal zone failed to register didn't impact the code here. If the tzone only bind to the max SoC temperature, all the physical sensor will failed to register tzone.
> 
>> +			val = clamp_val(val, adc_min, adc_max);
>> +			average += val;
>> +			if (val > max)
>> +				max = val;
>> +		}
>> +
>> +		if (sensor->id == max_sensor)
>> +			val = max;
>> +		else
>> +			val = average / max_sensor;
>> +	}
>>
>> +	*temp = ((val - adc_min) * data->coef[0]) / (adc_max - adc_min)
>> +		+ data->coef[1];
> 
> Pre-compute (adc_max - adc_min) at init time and check it is greater
> than zero, otherwise for a bad DT configuration we can end up with
> division by zero and crash the kernel (assuming having adc ranges in the
> DT is what we want).
OK
> 
>> +	return 0;
>> +}
>> +
>> +static struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
>> +	.get_temp = hisi_thermal_get_temp,
>> +};
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
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct hisi_thermal_data *data;
>> +	struct hisi_thermal_sensor *sensor;
>> +	struct resource *res;
>> +	unsigned int max_sensor;
>> +	int ret, i;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->pdev = pdev;
>> +	ret = of_property_read_u32(np, "hisi,tsensors", &max_sensor);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get max sensor\n");
>> +		return -EINVAL;
>> +	}
>> +	data->max_hw_sensor = max_sensor;
> 
> Do we really need a max sensor definition in the DT? Isn't it something
> we can deduce by looping with platform_get_resource below ?
> 
> eg.
> 
> while ((res = platform_get_resource(..., num_sensor++)) {
> 	...
> }
> 
> That said, I think we can assume there are 3 sensors always, no?
If we have three CPU cluster or two cluster share the same sensor in future, that number is certain on hi3660
> 
>> +	data->sensors = devm_kzalloc(dev,
>> +		sizeof(*data->sensors) * (max_sensor + VIRTUAL_SENSORS),
>> +		GFP_KERNEL);
>> +	if (IS_ERR(data->sensors)) {
> 
> s/IS_ERR(data->sensors)/!data->sensors/
> 
>> +		dev_err(dev, "failed to alloc sensors\n");
> 
> No message on memory allocation failure, there is already one from the
> mm framework.
OK
> 
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = of_property_read_u32_array(np, "hisi,coef", data->coef, 2);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get coef\n");
>> +		return -EINVAL;
> 
> return ret;
> 
>> +	}
>> +
>> +	ret = of_property_read_u32_array(np, "hisi,adc-range", data->range, 2);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get range\n");
>> +		return -EINVAL;
> 
> return ret;
OK
> 
>> +	}
> 
> Are these data really needed through DT? Isn't it something we can hardcode?
> 
>> +	platform_set_drvdata(pdev, data);
>> +
>> +	for (i = 0; i < max_sensor + VIRTUAL_SENSORS; ++i) {
>> +		sensor = &data->sensors[i];
>> +		if (i < max_sensor) {
>> +			res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> 
> Error check?
devm_ioremap_resource will handle it
> 
>> +			sensor->sensor_reg = devm_ioremap_resource(dev, res);
>> +			if (IS_ERR(sensor->sensor_reg)) {
>> +				dev_err(dev, "failed to get reg base\n");
>> +				return -ENOMEM;
> 
> s/-ENOMEM/PTR_ERR(sensor->sensor_reg)/
OK
> 
>> +			}
>> +		}
>> +
>> +		sensor->id = i;
> 
> How can we deal with holes in the DT?Do you mean the holes of sensor id?
> 
>> +		sensor->thermal = data;
>> +		sensor->tzd = thermal_zone_of_sensor_register(dev,
>> +				i, sensor, &hisi_of_thermal_ops);
>> +		if (IS_ERR(sensor->tzd)) {
>> +			sensor->tzd = NULL;
>> +		} else {
>> +			hisi_thermal_toggle_sensor(sensor, true);
>> +			dev_info(dev, "thermal sensor%d registered\n", i);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_thermal_exit(struct platform_device *pdev)
>> +{
>> +	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
>> +	int i;
>> +
>> +	for (i = 0; i < data->max_hw_sensor + VIRTUAL_SENSORS; i++) {
>> +		struct hisi_thermal_sensor *sensor = &data->sensors[i];
>> +
>> +		if (!sensor->tzd)
>> +			continue;
>> +
>> +		hisi_thermal_toggle_sensor(sensor, false);
>> +		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id hisi_thermal_id_table[] = {
>> +	{ .compatible = "hisilicon,hi3660-tsensor" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, hisi_thermal_id_table);
>> +
>> +static struct platform_driver hisi_thermal_driver = {
>> +	.probe = hisi_thermal_probe,
>> +	.remove = hisi_thermal_exit,
>> +	.driver = {
>> +		.name = "hisi_tsensor",
>> +		.of_match_table = hisi_thermal_id_table,
>> +	},
>> +};
>> +
>> +module_platform_driver(hisi_thermal_driver);
>> +
>> +MODULE_AUTHOR("Tao Wang <kevin.wangtao@linaro.org>");
>> +MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
>> +MODULE_DESCRIPTION("hisi tsensor driver");
>> +MODULE_LICENSE("GPL v2");
>>
> 
> 

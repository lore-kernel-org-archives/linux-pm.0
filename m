From: Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH 2/3] thermal: hisilicon: add thermal sensor driver for
 Hi3660
Date: Tue, 20 Jun 2017 11:31:31 +0100
Message-ID: <5948F983.5060902@hisilicon.com>
References: <1497930035-60894-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1497930035-60894-2-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497930035-60894-2-git-send-email-kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tao Wang <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sunzhaosheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Tao Wang,

On 2017/6/20 4:40, Tao Wang wrote:
> This patch adds the support for thermal sensor of Hi3660 SoC.
> this will register sensors for thermal framework and use device
> tree to bind cooling device.
> 
> Signed-off-by: Tao Wang <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/thermal/Kconfig          |   10 ++
>  drivers/thermal/Makefile         |    1 +
>  drivers/thermal/hi3660_thermal.c |  198 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 209 insertions(+)
>  create mode 100644 drivers/thermal/hi3660_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b5b5fac..3e7fa95 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -203,6 +203,16 @@ config HISI_THERMAL
>  	  thermal framework. cpufreq is used as the cooling device to throttle
>  	  CPUs when the passive trip is crossed.
>  
> +config HI3660_THERMAL

Please keep alphabet order and swap the order
between HI3660_THERMAL and HISI_THERMAL.

Thanks!

BR,
Wei

> +	tristate "Hi3660 thermal driver"
> +	depends on ARCH_HISI || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on OF
> +	default y
> +	help
> +	  Enable this to plug Hi3660 thermal driver into the Linux thermal
> +	  framework.
> +
>  config IMX_THERMAL
>  	tristate "Temperature sensor driver for Freescale i.MX SoCs"
>  	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 094d703..f29d0a5 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
>  obj-$(CONFIG_ST_THERMAL)	+= st/
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>  obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
> +obj-$(CONFIG_HI3660_THERMAL)	+= hi3660_thermal.o
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
> diff --git a/drivers/thermal/hi3660_thermal.c b/drivers/thermal/hi3660_thermal.c
> new file mode 100644
> index 0000000..a538721
> --- /dev/null
> +++ b/drivers/thermal/hi3660_thermal.c
> @@ -0,0 +1,198 @@
> +/*
> + *  linux/drivers/thermal/hi3660_thermal.c
> + *
> + *  Copyright (c) 2017 Hisilicon Limited.
> + *  Copyright (c) 2017 Linaro Limited.
> + *
> + *  Author: Tao Wang <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> + *  Author: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#include "thermal_core.h"
> +
> +#define HW_MAX_SENSORS			4
> +#define HISI_MAX_SENSORS		6
> +#define SENSOR_MAX			4
> +#define SENSOR_AVG			5
> +
> +#define ADC_MIN		116
> +#define ADC_MAX		922
> +
> +/* hi3660 Thermal Sensor Dev Structure */
> +struct hi3660_thermal_sensor {
> +	struct hi3660_thermal_data *thermal;
> +	struct thermal_zone_device *tzd;
> +
> +	uint32_t id;
> +};
> +
> +struct hi3660_thermal_data {
> +	struct platform_device *pdev;
> +	struct hi3660_thermal_sensor sensors[HISI_MAX_SENSORS];
> +	void __iomem *thermal_base;
> +};
> +
> +unsigned int sensor_reg_offset[HW_MAX_SENSORS] = { 0x1c, 0x5c, 0x9c, 0xdc };
> +
> +
> +static int hi3660_thermal_get_temp(void *_sensor, int *temp)
> +{
> +	struct hi3660_thermal_sensor *sensor = _sensor;
> +	struct hi3660_thermal_data *data = sensor->thermal;
> +	unsigned int idx;
> +	int val, average = 0, max = 0;
> +
> +	if (sensor->id < HW_MAX_SENSORS) {
> +		val = readl(data->thermal_base + sensor_reg_offset[sensor->id]);
> +		val = clamp_val(val, ADC_MIN, ADC_MAX);
> +	} else {
> +		for (idx = 0; idx < HW_MAX_SENSORS; idx++) {
> +			val = readl(data->thermal_base
> +					+ sensor_reg_offset[idx]);
> +			val = clamp_val(val, ADC_MIN, ADC_MAX);
> +			average += val;
> +			if (val > max)
> +				max = val;
> +		}
> +
> +		if (sensor->id == SENSOR_MAX)
> +			val = max;
> +		else if (sensor->id == SENSOR_AVG)
> +			val = average / HW_MAX_SENSORS;
> +	}
> +
> +	*temp = ((val - ADC_MIN) * 165000) / (ADC_MAX - ADC_MIN) - 40000;
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops hi3660_of_thermal_ops = {
> +	.get_temp = hi3660_thermal_get_temp,
> +};
> +
> +static int hi3660_thermal_register_sensor(struct platform_device *pdev,
> +		struct hi3660_thermal_data *data,
> +		struct hi3660_thermal_sensor *sensor,
> +		int index)
> +{
> +	int ret = 0;
> +
> +	sensor->id = index;
> +	sensor->thermal = data;
> +
> +	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +				sensor->id, sensor, &hi3660_of_thermal_ops);
> +	if (IS_ERR(sensor->tzd)) {
> +		ret = PTR_ERR(sensor->tzd);
> +		sensor->tzd = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void hi3660_thermal_toggle_sensor(struct hi3660_thermal_sensor *sensor,
> +				       bool on)
> +{
> +	struct thermal_zone_device *tzd = sensor->tzd;
> +
> +	tzd->ops->set_mode(tzd,
> +		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
> +}
> +
> +static int hi3660_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hi3660_thermal_data *data;
> +	struct resource *res;
> +	int ret = 0;
> +	int i;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->pdev = pdev;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->thermal_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(data->thermal_base)) {
> +		dev_err(dev, "failed get reg base\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
> +		ret = hi3660_thermal_register_sensor(pdev, data,
> +						     &data->sensors[i], i);
> +		if (ret)
> +			dev_err(&pdev->dev,
> +				"failed to register thermal sensor%d: %d\n",
> +				i, ret);
> +		else
> +			hi3660_thermal_toggle_sensor(&data->sensors[i], true);
> +	}
> +
> +	dev_info(&pdev->dev, "Thermal Sensor Loaded\n");
> +	return 0;
> +}
> +
> +static int hi3660_thermal_exit(struct platform_device *pdev)
> +{
> +	struct hi3660_thermal_data *data = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < HISI_MAX_SENSORS; i++) {
> +		struct hi3660_thermal_sensor *sensor = &data->sensors[i];
> +
> +		if (!sensor->tzd)
> +			continue;
> +
> +		hi3660_thermal_toggle_sensor(sensor, false);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id hi3660_thermal_id_table[] = {
> +	{ .compatible = "hisilicon,thermal-hi3660" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, hi3660_thermal_id_table);
> +
> +static struct platform_driver hi3660_thermal_driver = {
> +	.probe = hi3660_thermal_probe,
> +	.remove = hi3660_thermal_exit,
> +	.driver = {
> +		.name = "hi3660_thermal",
> +		.of_match_table = hi3660_thermal_id_table,
> +	},
> +};
> +
> +module_platform_driver(hi3660_thermal_driver);
> +
> +MODULE_AUTHOR("Tao Wang <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>");
> +MODULE_AUTHOR("Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
> +MODULE_DESCRIPTION("hi3660 thermal driver");
> +MODULE_LICENSE("GPL v2");
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/3] thermal: zx2967: add thermal driver for ZTE's
 zx2967 family
Date: Thu, 2 Feb 2017 09:56:13 -0700
Message-ID: <20170202165613.GB15052@linaro.org>
References: <1486048086-3431-1-git-send-email-baoyou.xie@linaro.org>
 <1486048086-3431-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486048086-3431-3-git-send-email-baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, wang.qiang01-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 02, 2017 at 11:08:06PM +0800, Baoyou Xie wrote:
> This patch adds thermal driver for ZTE's zx2967 family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/thermal/Kconfig          |   8 ++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/zx2967_thermal.c | 265 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 274 insertions(+)
>  create mode 100644 drivers/thermal/zx2967_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 18f2de6..f64bd50 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -444,4 +444,12 @@ config BCM2835_THERMAL
>  	help
>  	  Support for thermal sensors on Broadcom bcm2835 SoCs.
>  
> +config ZX2967_THERMAL
> +	tristate "Thermal sensors on zx2967 SoC"
> +	depends on ARCH_ZX || COMPILE_TEST
> +	help
> +	  Enable the zx2967 thermal sensors driver, which supports
> +	  the primitive temperature sensor embedded in zx2967 SoCs.
> +	  This sensor generates the real time die temperature.
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 677c6d9..c00c05e 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>  obj-$(CONFIG_BCM2835_THERMAL)	+= bcm2835_thermal.o
> +obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
> diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
> new file mode 100644
> index 0000000..d8642cf
> --- /dev/null
> +++ b/drivers/thermal/zx2967_thermal.c
> @@ -0,0 +1,265 @@
> +/*
> + * ZTE's zx2967 family thermal sensor driver
> + *
> + * Copyright (C) 2017 ZTE Ltd.
> + *
> + * Author: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +/* Power Mode: 0->low 1->high */
> +#define ZX2967_THERMAL_POWER_MODE	0
> +
> +/* DCF Control Register */
> +#define ZX2967_THERMAL_DCF		0x4
> +
> +/* Selection Register */
> +#define ZX2967_THERMAL_SEL		0x8
> +
> +/* Control Register */
> +#define ZX2967_THERMAL_CTRL		0x10
> +
> +#define ZX2967_THERMAL_READY		0x1000
> +#define ZX2967_THERMAL_TEMP_MASK	0xfff
> +#define ZX2967_THERMAL_ID_MASK		0x18
> +#define ZX2967_THERMAL_ID0		0x8
> +#define ZX2967_THERMAL_ID1		0x10
> +
> +struct zx2967_thermal_sensor {
> +	struct zx2967_thermal_priv *priv;
> +	struct thermal_zone_device *tzd;
> +	int id;
> +};
> +
> +#define NUM_SENSORS	1
> +
> +struct zx2967_thermal_priv {
> +	struct zx2967_thermal_sensor	sensors[NUM_SENSORS];

Do we really need an array here if there's only 1 sensor?

> +	/* Prevents reads sensor in parallel */
> +	struct mutex			lock;
> +	struct clk			*clk_gate;
> +	struct clk			*pclk;
> +	s32				slope;
> +	s32				offset;
> +	void __iomem			*regs;
> +	struct device			*dev;
> +};

Please add proper kernel style documentation for both structure.  And as far as
I can tell the stuctures could be merged into a single one. 

> +
> +static int zx2967_thermal_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +
> +	if (priv && priv->pclk)
> +		clk_disable_unprepare(priv->pclk);
> +
> +	if (priv && priv->clk_gate)
> +		clk_disable_unprepare(priv->clk_gate);
> +
> +	return 0;
> +}
> +
> +static int zx2967_thermal_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +	int error;
> +
> +	error = clk_prepare_enable(priv->clk_gate);
> +	if (error)
> +		return error;
> +
> +	error = clk_prepare_enable(priv->pclk);
> +	if (error) {
> +		clk_disable_unprepare(priv->clk_gate);
> +		return error;
> +	}
> +
> +	return 0;
> +}

The above two function need to be enclosed with CONFIG_PM_SLEEP.  Have a look at
other drivers that are using SIMPLE_DEV_PM_OPS.

> +
> +static int zx2967_thermal_get_temp(void *data, int *temp)
> +{
> +	void __iomem *regs;
> +	struct zx2967_thermal_sensor *sensor = data;
> +	struct zx2967_thermal_priv *priv = sensor->priv;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
> +	u32 val, sel_id;
> +
> +	regs = priv->regs;
> +	mutex_lock(&priv->lock);
> +
> +	writel_relaxed(0, regs + ZX2967_THERMAL_POWER_MODE);
> +	writel_relaxed(2, regs + ZX2967_THERMAL_DCF);
> +
> +	val = readl_relaxed(regs + ZX2967_THERMAL_SEL);
> +	val &= ~ZX2967_THERMAL_ID_MASK;
> +	sel_id = sensor->id ? ZX2967_THERMAL_ID0 : ZX2967_THERMAL_ID1;
> +	val |= sel_id;
> +	writel_relaxed(val, regs + ZX2967_THERMAL_SEL);
> +
> +	usleep_range(100, 300);

Polling (like below) can't be use here?  If not provide a good explanation as to
why that is the case.

> +	val = readl_relaxed(regs + ZX2967_THERMAL_CTRL);
> +	while (!(val & ZX2967_THERMAL_READY)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(priv->dev, "Thermal sensor %d data timeout\n",
> +				sensor->id);
> +			mutex_unlock(&priv->lock);
> +			return -ETIMEDOUT;
> +		}
> +		usleep_range(100, 300);
> +		val = readl_relaxed(regs + ZX2967_THERMAL_CTRL);
> +	}

See if you can use readx_poll_timeout()

> +
> +	writel_relaxed(3, regs + ZX2967_THERMAL_DCF);
> +	val = readl_relaxed(regs + ZX2967_THERMAL_CTRL)
> +			 & ZX2967_THERMAL_TEMP_MASK;
> +	writel_relaxed(1, regs + ZX2967_THERMAL_POWER_MODE);

Please add a #define (along with an explanation) for the values used with
writel_relaxed().  Otherwise reviewers are left guessing. 

> +
> +	/* Calculate temperature */
> +	*temp = DIV_ROUND_CLOSEST(((s32)val + priv->offset) * 1000,
> +				  priv->slope);

Same here, I have to guess why 1000 is used.

> +
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops zx2967_of_thermal_ops = {
> +	.get_temp = zx2967_thermal_get_temp,
> +};
> +
> +static int zx2967_thermal_probe(struct platform_device *pdev)
> +{
> +	struct zx2967_thermal_priv *priv;
> +	struct resource *res;
> +	u32 buf[2];
> +	int ret, i;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->regs))
> +		return PTR_ERR(priv->regs);
> +
> +	ret = of_property_read_u32_array(pdev->dev.of_node,
> +					 "coefficients", buf, 2);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to read coefficients\n");
> +		return ret;
> +	}
> +	priv->slope = (s32)buf[0];
> +	priv->offset = (s32)buf[1];

Are you sure you don't want to check the values of ->slope and ->offset?  I
certainly wouldn't trust the DT...

> +
> +	priv->clk_gate = devm_clk_get(&pdev->dev, "gate");
> +	if (IS_ERR(priv->clk_gate)) {
> +		ret = PTR_ERR(priv->clk_gate);
> +		dev_err(&pdev->dev, "failed to get clock gate: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(priv->clk_gate);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	priv->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(priv->pclk)) {
> +		ret = PTR_ERR(priv->pclk);
> +		clk_disable_unprepare(priv->clk_gate);

An error path is already defined below - add a 'goto' statement that jumps to
it.  That way it consolidates the exit point for the function and avoid code
duplication.  

> +		dev_err(&pdev->dev, "failed to get apb clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(priv->pclk);
> +	if (ret) {
> +		clk_disable_unprepare(priv->clk_gate);

Same comment a above.

> +		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&priv->lock);
> +	for (i = 0; i < NUM_SENSORS; i++) {
> +		struct zx2967_thermal_sensor *sensor = &priv->sensors[i];
> +
> +		sensor->priv = priv;
> +		sensor->id = i;
> +		sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev,
> +					i, sensor, &zx2967_of_thermal_ops);
> +		if (IS_ERR(sensor->tzd)) {
> +			ret = PTR_ERR(sensor->tzd);
> +			dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
> +				i, ret);
> +			goto remove_ts;
> +		}
> +	}
> +	priv->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +remove_ts:
> +	clk_disable_unprepare(priv->clk_gate);
> +	clk_disable_unprepare(priv->pclk);
> +	for (i--; i >= 0; i--)
> +		thermal_zone_of_sensor_unregister(&pdev->dev,
> +						  priv->sensors[i].tzd);
> +
> +	return ret;
> +}
> +
> +static int zx2967_thermal_exit(struct platform_device *pdev)
> +{
> +	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < NUM_SENSORS; i++) {
> +		struct zx2967_thermal_sensor *sensor = &priv->sensors[i];
> +
> +		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
> +	}
> +	clk_disable_unprepare(priv->pclk);
> +	clk_disable_unprepare(priv->clk_gate);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id zx2967_thermal_id_table[] = {
> +	{ .compatible = "zte,zx296718-thermal" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, zx2967_thermal_id_table);
> +
> +static SIMPLE_DEV_PM_OPS(zx2967_thermal_pm_ops,
> +			 zx2967_thermal_suspend, zx2967_thermal_resume);
> +
> +static struct platform_driver zx2967_thermal_driver = {
> +	.probe = zx2967_thermal_probe,
> +	.remove = zx2967_thermal_exit,
> +	.driver = {
> +		.name = "zx2967_thermal",
> +		.of_match_table = zx2967_thermal_id_table,
> +		.pm = &zx2967_thermal_pm_ops,
> +	},
> +};
> +module_platform_driver(zx2967_thermal_driver);
> +
> +MODULE_AUTHOR("Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
> +MODULE_DESCRIPTION("ZTE zx2967 thermal driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

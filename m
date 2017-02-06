From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v8 3/3] thermal: zx2967: add thermal driver for ZTE's
 zx2967 family
Date: Mon, 6 Feb 2017 10:23:53 -0700
Message-ID: <20170206172353.GC11391@linaro.org>
References: <1486179597-30953-1-git-send-email-baoyou.xie@linaro.org>
 <1486179597-30953-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38833 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdBFRX6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 12:23:58 -0500
Received: by mail-it0-f52.google.com with SMTP id c7so61504812itd.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 09:23:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1486179597-30953-3-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: jun.nie@linaro.org, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

On Sat, Feb 04, 2017 at 11:39:57AM +0800, Baoyou Xie wrote:
> This patch adds thermal driver for ZTE's zx2967 family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  drivers/thermal/Kconfig          |   8 ++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/zx2967_thermal.c | 255 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
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
> index 0000000..d177238
> --- /dev/null
> +++ b/drivers/thermal/zx2967_thermal.c
> @@ -0,0 +1,255 @@
> +/*
> + * ZTE's zx2967 family thermal sensor driver
> + *
> + * Copyright (C) 2017 ZTE Ltd.
> + *
> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +/* Power Mode: 0->low 1->high */
> +#define ZX2967_THERMAL_POWER_MODE	0
> +#define ZX2967_POWER_MODE_LOW		0
> +#define ZX2967_POWER_MODE_HIGH		1
> +
> +/* DCF Control Register */
> +#define ZX2967_THERMAL_DCF		0x4
> +#define ZX2967_DCF_EN			BIT(1)
> +#define ZX2967_DCF_FREEZE		BIT(0)
> +
> +/* Selection Register */
> +#define ZX2967_THERMAL_SEL		0x8
> +
> +/* Control Register */
> +#define ZX2967_THERMAL_CTRL		0x10
> +
> +#define ZX2967_THERMAL_READY		BIT(12)
> +#define ZX2967_THERMAL_TEMP_MASK	GENMASK(11, 0)
> +#define ZX2967_THERMAL_ID_MASK		0x18
> +#define ZX2967_THERMAL_ID		0x10
> +
> +#define ZX2967_GET_TEMP_TIMEOUT_US	(100 * 1024)
> +
> +/* zx2967 Thermal Sensor Private Structure */
> +struct zx2967_thermal_priv {
> +	/* struct thermal_zone_device where the sensor is registered */
> +	struct thermal_zone_device	*tzd;
> +	/* prevents reads sensor in parallel */
> +	struct mutex			lock;
> +	/* topcrm clk structure */
> +	struct clk			*clk_topcrm;
> +	/* apb clk structure */
> +	struct clk			*clk_apb;
> +	/* pointer to base address of the thermal sensor */
> +	void __iomem			*regs;
> +	struct device			*dev;
> +};

Apologies for not being clearer before.  The proper way to document a structure
can be found here [1].

[1]. http://lxr.free-electrons.com/source/drivers/thermal/of-thermal.c#L39

> +
> +static int zx2967_thermal_get_temp(void *data, int *temp)
> +{
> +	void __iomem *regs;
> +	struct zx2967_thermal_priv *priv = data;
> +	u32 val;
> +	int ret;
> +
> +	if (!priv->tzd)
> +		return -EAGAIN;
> +
> +	regs = priv->regs;
> +	mutex_lock(&priv->lock);
> +	writel_relaxed(ZX2967_POWER_MODE_LOW,
> +		       regs + ZX2967_THERMAL_POWER_MODE);
> +	writel_relaxed(ZX2967_DCF_EN, regs + ZX2967_THERMAL_DCF);
> +
> +	val = readl_relaxed(regs + ZX2967_THERMAL_SEL);
> +	val &= ~ZX2967_THERMAL_ID_MASK;
> +	val |= ZX2967_THERMAL_ID;
> +	writel_relaxed(val, regs + ZX2967_THERMAL_SEL);
> +
> +	/*
> +	 * Must wait for a while, surely it's a bit odd.
> +	 * otherwise temperature value we got has a few deviation, even if
> +	 * the THERMAL_READY bit is set.
> +	 */
> +	usleep_range(100, 300);
> +	ret = readx_poll_timeout(readl, regs + ZX2967_THERMAL_CTRL,
> +				 val, val & ZX2967_THERMAL_READY, 300,
> +				 ZX2967_GET_TEMP_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(priv->dev, "Thermal sensor data timeout\n");
> +		goto unlock;
> +	}
> +
> +	writel_relaxed(ZX2967_DCF_FREEZE | ZX2967_DCF_EN,
> +		       regs + ZX2967_THERMAL_DCF);
> +	val = readl_relaxed(regs + ZX2967_THERMAL_CTRL)
> +			 & ZX2967_THERMAL_TEMP_MASK;
> +	writel_relaxed(ZX2967_POWER_MODE_HIGH,
> +		       regs + ZX2967_THERMAL_POWER_MODE);
> +
> +	/*
> +	 * Calculate temperature
> +	 * In dts, slope is multiplied by 1000.
> +	 */
> +	*temp = DIV_ROUND_CLOSEST(((s32)val + priv->tzd->tzp->offset) * 1000,
> +				  priv->tzd->tzp->slope);
> +
> +unlock:
> +	mutex_unlock(&priv->lock);
> +	return ret;
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
> +	int ret;
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
> +	priv->clk_topcrm = devm_clk_get(&pdev->dev, "topcrm");
> +	if (IS_ERR(priv->clk_topcrm)) {
> +		ret = PTR_ERR(priv->clk_topcrm);
> +		dev_err(&pdev->dev, "failed to get topcrm clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(priv->clk_topcrm);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable topcrm clock: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	priv->clk_apb = devm_clk_get(&pdev->dev, "apb");
> +	if (IS_ERR(priv->clk_apb)) {
> +		ret = PTR_ERR(priv->clk_apb);
> +		dev_err(&pdev->dev, "failed to get apb clock: %d\n", ret);
> +		goto disable_clk_topcrm;
> +	}
> +
> +	ret = clk_prepare_enable(priv->clk_apb);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable apb clock: %d\n",
> +			ret);
> +		goto disable_clk_topcrm;
> +	}
> +
> +	mutex_init(&priv->lock);
> +	priv->tzd = thermal_zone_of_sensor_register(&pdev->dev,
> +					0, priv, &zx2967_of_thermal_ops);
> +
> +	if (IS_ERR(priv->tzd)) {
> +		ret = PTR_ERR(priv->tzd);
> +		dev_err(&pdev->dev, "failed to register sensor: %d\n", ret);
> +		goto disable_clk_all;
> +	}
> +
> +	if (priv->tzd->tzp->slope == 0) {
> +		thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
> +		dev_err(&pdev->dev, "coefficients of sensor is invalid\n");
> +		ret = -EINVAL;
> +		goto disable_clk_all;
> +	}
> +
> +	priv->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +disable_clk_all:
> +	clk_disable_unprepare(priv->clk_apb);
> +disable_clk_topcrm:
> +	clk_disable_unprepare(priv->clk_topcrm);
> +	return ret;
> +}
> +
> +static int zx2967_thermal_exit(struct platform_device *pdev)
> +{
> +	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +
> +	thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
> +	clk_disable_unprepare(priv->clk_topcrm);
> +	clk_disable_unprepare(priv->clk_apb);
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
> +#ifdef CONFIG_PM_SLEEP
> +static int zx2967_thermal_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +
> +	if (priv && priv->clk_topcrm)
> +		clk_disable_unprepare(priv->clk_topcrm);
> +
> +	if (priv && priv->clk_apb)
> +		clk_disable_unprepare(priv->clk_apb);
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
> +	error = clk_prepare_enable(priv->clk_topcrm);
> +	if (error)
> +		return error;
> +
> +	error = clk_prepare_enable(priv->clk_apb);
> +	if (error) {
> +		clk_disable_unprepare(priv->clk_topcrm);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +#endif
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
> +MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
> +MODULE_DESCRIPTION("ZTE zx2967 thermal driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 

From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 2/4] thermal: rcar_gen3_thermal: Add R-Car Gen3
 thermal driver
Date: Tue, 6 Dec 2016 17:01:20 -0800
Message-ID: <20161207010119.GB12562@localhost.localdomain>
References: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
 <20161201220442.22057-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36853 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbcLGBBZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:01:25 -0500
Content-Disposition: inline
In-Reply-To: <20161201220442.22057-3-wsa+renesas@sang-engineering.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>

On Thu, Dec 01, 2016 at 11:04:40PM +0100, Wolfram Sang wrote:
> Add support for R-Car Gen3 thermal sensors. Polling only for now,
> interrupts will be added incrementally. Same goes for reading fuses.
> This is documented already, but no hardware available for now.
> 
> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
> Signed-off-by: Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Would you please check the following from checkpatch too?
That is how the patch would apply. Enter to continue

WARNING: please write a paragraph that describes the config symbol fully
#82: FILE: drivers/thermal/Kconfig:248:
+config RCAR_GEN3_THERMAL

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#107: 
new file mode 100644

CHECK: struct mutex definition without comment
#186: FILE: drivers/thermal/rcar_gen3_thermal.c:75:
+	struct mutex lock;

WARNING: line over 80 characters
#204: FILE: drivers/thermal/rcar_gen3_thermal.c:93:
+static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc, u32 reg)

CHECK: Alignment should match open parenthesis
#210: FILE: drivers/thermal/rcar_gen3_thermal.c:99:
+static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
+				     u32 reg, u32 data)

WARNING: line over 80 characters
#219: FILE: drivers/thermal/rcar_gen3_thermal.c:108:
+	round_offs = temp >= 0 ? RCAR3_THERMAL_GRAN / 2 : -RCAR3_THERMAL_GRAN / 2;

CHECK: Alignment should match open parenthesis
#254: FILE: drivers/thermal/rcar_gen3_thermal.c:143:
+static int _linear_temp_converter(struct equation_coefs *coef,
+					int temp_code)

CHECK: Alignment should match open parenthesis
#304: FILE: drivers/thermal/rcar_gen3_thermal.c:193:
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
+			   CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);

CHECK: Alignment should match open parenthesis
#309: FILE: drivers/thermal/rcar_gen3_thermal.c:198:
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
+			  CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN |

WARNING: line over 80 characters
#361: FILE: drivers/thermal/rcar_gen3_thermal.c:250:
+	const struct rcar_gen3_thermal_data *match_data = of_device_get_match_data(dev);

CHECK: Alignment should match open parenthesis
#406: FILE: drivers/thermal/rcar_gen3_thermal.c:295:
+		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
+					&rcar_gen3_tz_of_ops);

total: 0 errors, 5 warnings, 6 checks, 346 lines checked



> ---
> 
> Changes since v3:
> 
> * call 'init' callback a tad earlier, avoids need for locking
> * converted spinlock to mutex and simplified locking (only done against
>   concurrent access in rcar_gen3_thermal_get_temp() now)
> * use usleep_range instead of udelay
> * use s64 instead of long (int didn't work)
> * fixed an error path
> * simplified rcar_gen3_thermal_update_temp() and its use
> 
> Thanks a lot to Eduardo and Geert for the prompt reviews!
> 
>  drivers/thermal/Kconfig             |   9 +
>  drivers/thermal/Makefile            |   1 +
>  drivers/thermal/rcar_gen3_thermal.c | 324 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/thermal/rcar_gen3_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index c2c056cc7ea52e..3912d24a07b10f 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -245,6 +245,15 @@ config RCAR_THERMAL
>  	  Enable this to plug the R-Car thermal sensor driver into the Linux
>  	  thermal framework.
>  
> +config RCAR_GEN3_THERMAL
> +	tristate "Renesas R-Car Gen3 thermal driver"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on OF
> +	help
> +	  Enable this to plug the R-Car Gen3 thermal sensor driver into the Linux
> +	  thermal framework.
> +
>  config KIRKWOOD_THERMAL
>  	tristate "Temperature sensor on Marvell Kirkwood SoCs"
>  	depends on MACH_KIRKWOOD || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index c92eb22a41ff89..1216fb31ed4036 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
>  obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
>  obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
>  obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
> +obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
>  obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
>  obj-y				+= samsung/
>  obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> new file mode 100644
> index 00000000000000..ef30d84b0f56a2
> --- /dev/null
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -0,0 +1,324 @@
> +/*
> + *  R-Car Gen3 THS thermal sensor driver
> + *  Based on rcar_thermal.c and work from Hien Dang and Khiem Nguyen.
> + *
> + * Copyright (C) 2016 Renesas Electronics Corporation.
> + * Copyright (C) 2016 Sang Engineering
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + */
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/thermal.h>
> +
> +/* Register offsets */
> +#define REG_GEN3_IRQSTR		0x04
> +#define REG_GEN3_IRQMSK		0x08
> +#define REG_GEN3_IRQCTL		0x0C
> +#define REG_GEN3_IRQEN		0x10
> +#define REG_GEN3_IRQTEMP1	0x14
> +#define REG_GEN3_IRQTEMP2	0x18
> +#define REG_GEN3_IRQTEMP3	0x1C
> +#define REG_GEN3_CTSR		0x20
> +#define REG_GEN3_THCTR		0x20
> +#define REG_GEN3_TEMP		0x28
> +#define REG_GEN3_THCODE1	0x50
> +#define REG_GEN3_THCODE2	0x54
> +#define REG_GEN3_THCODE3	0x58
> +
> +/* CTSR bits */
> +#define CTSR_PONM	BIT(8)
> +#define CTSR_AOUT	BIT(7)
> +#define CTSR_THBGR	BIT(5)
> +#define CTSR_VMEN	BIT(4)
> +#define CTSR_VMST	BIT(1)
> +#define CTSR_THSST	BIT(0)
> +
> +/* THCTR bits */
> +#define THCTR_PONM	BIT(6)
> +#define THCTR_THSST	BIT(0)
> +
> +#define CTEMP_MASK	0xFFF
> +
> +#define MCELSIUS(temp)	((temp) * 1000)
> +#define GEN3_FUSE_MASK	0xFFF
> +
> +#define TSC_MAX_NUM	3
> +
> +/* Structure for thermal temperature calculation */
> +struct equation_coefs {
> +	s64 a1;
> +	s64 b1;
> +	s64 a2;
> +	s64 b2;

Can you please elaborate again why these could not be int?

> +};
> +
> +struct rcar_gen3_thermal_tsc {
> +	void __iomem *base;
> +	struct thermal_zone_device *zone;
> +	struct equation_coefs coef;
> +	struct mutex lock;
> +	u32 ctemp;
> +};
> +
> +struct rcar_gen3_thermal_priv {
> +	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
> +};
> +
> +struct rcar_gen3_thermal_data {
> +	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
> +};
> +
> +/* Temperature calculation  */
> +#define RCAR3_THERMAL_GRAN 500
> +#define CODETSD(x) ((x) * 1000)
> +#define TJ_1 96000L
> +#define TJ_3 (-41000L)
> +
> +static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc, u32 reg)
> +{
> +	return ioread32(tsc->base + reg);
> +}
> +
> +static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
> +				     u32 reg, u32 data)
> +{
> +	iowrite32(data, tsc->base + reg);
> +}
> +
> +static int _round_temp(int temp)
> +{
> +	int result, round_offs;
> +
> +	round_offs = temp >= 0 ? RCAR3_THERMAL_GRAN / 2 : -RCAR3_THERMAL_GRAN / 2;
> +	result = (temp + round_offs) / RCAR3_THERMAL_GRAN;
> +	return result * RCAR3_THERMAL_GRAN;
> +}
> +
> +static void _linear_coefficient_calculation(struct rcar_gen3_thermal_tsc *tsc,
> +					    int *ptat, int *thcode)
> +{
> +	int tj_2;
> +	s64 a1, b1;
> +	s64 a2, b2;
> +	s64 a1_num, a1_den;
> +	s64 a2_num, a2_den;
> +
> +	tj_2 = (CODETSD((ptat[1] - ptat[2]) * 137)
> +		/ (ptat[0] - ptat[2])) - CODETSD(41);
> +
> +	/* calculate coefficients for linear equation */
> +	a1_num = CODETSD(thcode[1] - thcode[2]);
> +	a1_den = tj_2 - TJ_3;
> +	a1 = (10000 * a1_num) / a1_den;
> +	b1 = (10000 * thcode[2]) - ((a1 * TJ_3) / 1000);
> +
> +	a2_num = CODETSD(thcode[1] - thcode[0]);
> +	a2_den = tj_2 - TJ_1;
> +	a2 = (10000 * a2_num) / a2_den;
> +	b2 = (10000 * thcode[0]) - ((a2 * TJ_1) / 1000);
> +
> +	tsc->coef.a1 = DIV_ROUND_CLOSEST(a1, 10);
> +	tsc->coef.b1 = DIV_ROUND_CLOSEST(b1, 10);
> +	tsc->coef.a2 = DIV_ROUND_CLOSEST(a2, 10);
> +	tsc->coef.b2 = DIV_ROUND_CLOSEST(b2, 10);

What is a a1, b1, a2, b2 typical values?

are you sure they do not fit into int? Looks like you start from pretty small values,
but multiply by 10^3 on num and den to get better precision?

> +}
> +
> +static int _linear_temp_converter(struct equation_coefs *coef,
> +					int temp_code)
> +{
> +	int temp, temp1, temp2;
> +
> +	temp1 = MCELSIUS((CODETSD(temp_code) - coef->b1)) / coef->a1;
> +	temp2 = MCELSIUS((CODETSD(temp_code) - coef->b2)) / coef->a2;

aren't we overflowing the result of this 64 bit math assigned into an int?

besides, again, temp_code fits into an int, why coef->[ab][12] do not ?

even if you do have a valid reason to use 64bit, that probably needs to be doc into the driver
code.

> +	temp = (temp1 + temp2) / 2;
> +
> +	return _round_temp(temp);
> +}
> +
> +static void rcar_gen3_thermal_update_temp(struct rcar_gen3_thermal_tsc *tsc)
> +{
> +	tsc->ctemp = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
> +}
> +
> +static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
> +{
> +	struct rcar_gen3_thermal_tsc *tsc = devdata;
> +	int ctemp;
> +
> +	mutex_lock(&tsc->lock);

much better now.

> +
> +	rcar_gen3_thermal_update_temp(tsc);
> +	ctemp = _linear_temp_converter(&tsc->coef, tsc->ctemp);
> +
> +	mutex_unlock(&tsc->lock);
> +
> +	if ((ctemp < MCELSIUS(-40)) || (ctemp > MCELSIUS(125)))
> +		return -EIO;


> +
> +	*temp = ctemp;
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
> +	.get_temp	= rcar_gen3_thermal_get_temp,
> +};
> +
> +static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> +{
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
> +
> +	usleep_range(1000, 2000);

good

> +
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR, CTSR_PONM);
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
> +			   CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
> +
> +	usleep_range(100, 200);
> +
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
> +			  CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN |
> +			  CTSR_VMST | CTSR_THSST);
> +}
> +
> +static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> +{
> +	u32 reg_val;
> +
> +	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
> +	reg_val &= ~THCTR_PONM;
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
> +
> +	usleep_range(1000, 2000);
> +
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
> +	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
> +	reg_val |= THCTR_THSST;
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
> +}
> +
> +static const struct rcar_gen3_thermal_data r8a7795_data = {
> +	.thermal_init = r8a7795_thermal_init,
> +};
> +
> +static const struct rcar_gen3_thermal_data r8a7796_data = {
> +	.thermal_init = r8a7796_thermal_init,
> +};
> +
> +static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
> +	{ .compatible = "renesas,r8a7795-thermal", .data = &r8a7795_data},
> +	{ .compatible = "renesas,r8a7796-thermal", .data = &r8a7796_data},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
> +
> +static int rcar_gen3_thermal_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +
> +	return 0;
> +}
> +
> +static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> +{
> +	struct rcar_gen3_thermal_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct thermal_zone_device *zone;
> +	int ret, i;
> +	const struct rcar_gen3_thermal_data *match_data = of_device_get_match_data(dev);
> +
> +	/* default values if FUSEs are missing */
> +	int ptat[3] = { 2351, 1509, 435 };
> +	int thcode[TSC_MAX_NUM][3] = {
> +		{ 3248, 2800, 2221 },
> +		{ 3245, 2795, 2216 },
> +		{ 3250, 2805, 2237 },
> +	};

see, these seam to be small numbers, that apparently, after some 10^3 math, should still
fit into an int, no?

> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
> +	for (i = 0; i < TSC_MAX_NUM; i++) {
> +		struct rcar_gen3_thermal_tsc *tsc;
> +
> +		tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
> +		if (!tsc) {
> +			ret = -ENOMEM;
> +			goto error_unregister;
> +		}
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res)
> +			break;
> +
> +		tsc->base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(tsc->base)) {
> +			ret = PTR_ERR(tsc->base);
> +			goto error_unregister;
> +		}
> +
> +		priv->tscs[i] = tsc;
> +		mutex_init(&tsc->lock);
> +
> +		match_data->thermal_init(tsc);
> +		_linear_coefficient_calculation(tsc, ptat, thcode[i]);
> +
> +		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
> +					&rcar_gen3_tz_of_ops);
> +		if (IS_ERR(zone)) {
> +			dev_err(dev, "Can't register thermal zone\n");
> +			ret = PTR_ERR(zone);
> +			goto error_unregister;
> +		}
> +		tsc->zone = zone;
> +	}
> +
> +	return 0;
> +
> +error_unregister:
> +	rcar_gen3_thermal_remove(pdev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver rcar_gen3_thermal_driver = {
> +	.driver	= {
> +		.name	= "rcar_gen3_thermal",
> +		.of_match_table = rcar_gen3_thermal_dt_ids,
> +	},
> +	.probe		= rcar_gen3_thermal_probe,
> +	.remove		= rcar_gen3_thermal_remove,
> +};
> +module_platform_driver(rcar_gen3_thermal_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("R-Car Gen3 THS thermal sensor driver");
> +MODULE_AUTHOR("Wolfram Sang <wsa+renesas@sang-engineering.com>");
> -- 
> 2.10.2
> 

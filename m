From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v6 3/3] thermal: zx2967: add thermal driver for ZTE's
 zx2967 family
Date: Thu, 2 Feb 2017 08:00:16 -0800
Message-ID: <20170202160014.GA2419@localhost.localdomain>
References: <1486048086-3431-1-git-send-email-baoyou.xie@linaro.org>
 <1486048086-3431-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34007 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdBBQAW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2017 11:00:22 -0500
Content-Disposition: inline
In-Reply-To: <1486048086-3431-3-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: jun.nie@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

Helllo Baoyou,

Sorry I was not clear enough in my previous comment.

Please find the explanation below:


On Thu, Feb 02, 2017 at 11:08:06PM +0800, Baoyou Xie wrote:
> This patch adds thermal driver for ZTE's zx2967 family.
> 

<cut>

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

What I meant in my previous comment is that of-thermal already does the
above parsing for you. Therefore, the above line is not needed. And...

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to read coefficients\n");
> +		return ret;
> +	}
> +	priv->slope = (s32)buf[0];
> +	priv->offset = (s32)buf[1];
> +

You should also not need to have priv data for storing the slope and
offset.

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
> +		dev_err(&pdev->dev, "failed to get apb clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(priv->pclk);
> +	if (ret) {
> +		clk_disable_unprepare(priv->clk_gate);
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

After calling the above function, if it succeeds, and you have the
coefficients property in your DTS, then

> +		if (IS_ERR(sensor->tzd)) {
> +			ret = PTR_ERR(sensor->tzd);
> +			dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
> +				i, ret);
> +			goto remove_ts;
> +		}

Right here, you should be able to access sensor->tzd->tzp->slope and
sensor->tzd->tzp->offset, if you added the entry:
		coefficients = <SLOPE OFFSET>;

		in you thermal zone in DT.

I hope this clarifies.

Let me know if you are able to use the parsing from of-thermal, instead
of in your driver.

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
> +MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
> +MODULE_DESCRIPTION("ZTE zx2967 thermal driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 

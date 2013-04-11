From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [v2,02/14] thermal: mvebu: Rename symbols 'kirkwood' -> 'mvebu'
Date: Thu, 11 Apr 2013 12:18:35 -0400
Message-ID: <5166E25B.7070307@ti.com>
References: <1363991114-4225-3-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42642 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3DKQTL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 12:19:11 -0400
In-Reply-To: <1363991114-4225-3-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, eduardo.valentin@ti.com

On 22-03-2013 18:25, Ezequiel Garcia wrote:
> This driver will be used to support Marvell EBU SoC thermal
> sensors. Therefore, we change every symbol and comment
> accordingly, before we make any functionality change.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Rui,

This patch looks fine to me. You can add my:

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

>
> ---
> drivers/thermal/mvebu_thermal.c |   42 +++++++++++++++++++-------------------
>   1 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> index 19320dd..9ba9e4d 100644
> --- a/drivers/thermal/mvebu_thermal.c
> +++ b/drivers/thermal/mvebu_thermal.c
> @@ -1,5 +1,5 @@
>   /*
> - * Kirkwood thermal sensor driver
> + * Marvell EBU thermal sensor driver
>    *
>    * Copyright (C) 2012 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>    *
> @@ -27,16 +27,16 @@
>   #define KIRKWOOD_THERMAL_TEMP_OFFSET	10
>   #define KIRKWOOD_THERMAL_TEMP_MASK	0x1FF
>
> -/* Kirkwood Thermal Sensor Dev Structure */
> -struct kirkwood_thermal_priv {
> +/* Marvell EBU Thermal Sensor Dev Structure */
> +struct mvebu_thermal_priv {
>   	void __iomem *sensor;
>   };
>
> -static int kirkwood_get_temp(struct thermal_zone_device *thermal,
> +static int mvebu_get_temp(struct thermal_zone_device *thermal,
>   			  unsigned long *temp)
>   {
>   	unsigned long reg;
> -	struct kirkwood_thermal_priv *priv = thermal->devdata;
> +	struct mvebu_thermal_priv *priv = thermal->devdata;
>
>   	reg = readl_relaxed(priv->sensor);
>
> @@ -61,18 +61,18 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
>   }
>
>   static struct thermal_zone_device_ops ops = {
> -	.get_temp = kirkwood_get_temp,
> +	.get_temp = mvebu_get_temp,
>   };
>
> -static const struct of_device_id kirkwood_thermal_id_table[] = {
> +static const struct of_device_id mvebu_thermal_id_table[] = {
>   	{ .compatible = "marvell,kirkwood-thermal" },

The device tree node will still be kept kirkwood?

>   	{}
>   };
>
> -static int kirkwood_thermal_probe(struct platform_device *pdev)
> +static int mvebu_thermal_probe(struct platform_device *pdev)
>   {
>   	struct thermal_zone_device *thermal = NULL;
> -	struct kirkwood_thermal_priv *priv;
> +	struct mvebu_thermal_priv *priv;
>   	struct resource *res;
>
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -91,7 +91,7 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
>   		return -EADDRNOTAVAIL;
>   	}
>
> -	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
> +	thermal = thermal_zone_device_register("mvebu_thermal", 0, 0,
>   					       priv, &ops, NULL, 0, 0);
>   	if (IS_ERR(thermal)) {
>   		dev_err(&pdev->dev,
> @@ -104,31 +104,31 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
>   	return 0;
>   }
>
> -static int kirkwood_thermal_exit(struct platform_device *pdev)
> +static int mvebu_thermal_exit(struct platform_device *pdev)
>   {
> -	struct thermal_zone_device *kirkwood_thermal =
> +	struct thermal_zone_device *mvebu_thermal =
>   		platform_get_drvdata(pdev);
>
> -	thermal_zone_device_unregister(kirkwood_thermal);
> +	thermal_zone_device_unregister(mvebu_thermal);
>   	platform_set_drvdata(pdev, NULL);
>
>   	return 0;
>   }
>
> -MODULE_DEVICE_TABLE(of, kirkwood_thermal_id_table);
> +MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
>
> -static struct platform_driver kirkwood_thermal_driver = {
> -	.probe = kirkwood_thermal_probe,
> -	.remove = kirkwood_thermal_exit,
> +static struct platform_driver mvebu_thermal_driver = {
> +	.probe = mvebu_thermal_probe,
> +	.remove = mvebu_thermal_exit,
>   	.driver = {
> -		.name = "kirkwood_thermal",
> +		.name = "mvebu_thermal",
>   		.owner = THIS_MODULE,
> -		.of_match_table = of_match_ptr(kirkwood_thermal_id_table),
> +		.of_match_table = of_match_ptr(mvebu_thermal_id_table),
>   	},
>   };
>
> -module_platform_driver(kirkwood_thermal_driver);
> +module_platform_driver(mvebu_thermal_driver);
>
>   MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
> -MODULE_DESCRIPTION("kirkwood thermal driver");
> +MODULE_DESCRIPTION("mvebu thermal driver");
>   MODULE_LICENSE("GPL");
>


From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 14/15] thermal: Add Mediatek thermal controller support
Date: Thu, 14 May 2015 11:52:26 +0200
Message-ID: <1431597146.2650.59.camel@x220>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
	 <1431507163-19933-15-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lb3-smtp-cloud3.xs4all.net ([194.109.24.30]:50987 "EHLO
	lb3-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932301AbbENJwd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 05:52:33 -0400
In-Reply-To: <1431507163-19933-15-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>

On Wed, 2015-05-13 at 10:52 +0200, Sascha Hauer wrote:
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig

> +config MTK_THERMAL
> +	tristate "Temperature sensor driver for mediatek SoCs"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	default y
> +	help
> +	  Enable this option if you want to have support for thermal management
> +	  controller present in Mediatek SoCs

> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile

> +obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o

> --- /dev/null
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -0,0 +1,728 @@

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

> +#include <linux/module.h>

> +static const struct of_device_id mtk_thermal_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt8173-thermal",
> +	}, {
> +	},
> +};
> +
> +static struct platform_driver mtk_thermal_driver = {
> +	.probe = mtk_thermal_probe,
> +	.remove = mtk_thermal_remove,
> +	.driver = {
> +		.name = THERMAL_NAME,
> +		.of_match_table = mtk_thermal_of_match,
> +	},
> +};
> +
> +module_platform_driver(mtk_thermal_driver);

If MTK_THERMAL is set to 'm' a mtk_thermal.ko module will be built. I
didn't spot a MODULE_LICENSE() macro in this file. So I think that, if
mtk_thermal.ko gets loaded - I guess through the of_match_table magic -
a warning will be issued and the kernel will be tainted.

(I didn't actually test any of this, so I've wasted your time if I've
overlooked something here.)


Paul Bolle


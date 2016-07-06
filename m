From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v9 2/4] power: reset: add reboot mode driver
Date: Wed, 06 Jul 2016 15:39:43 +0200
Message-ID: <577D0A1F.9070007@samsung.com>
References: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
 <1466404696-3464-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53244 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbcGFNjs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2016 09:39:48 -0400
In-reply-to: <1466404696-3464-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>, robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at

On 06/20/2016 08:38 AM, Andy Yan wrote:
> This driver parses the reboot commands like "reboot bootloader"
> and "reboot recovery" to get a boot mode described in the
> device tree , then call the write interfae to store the boot
> mode in some place like special register or sram, which can
> be read by the bootloader after system reboot, then the bootloader
> can take different action according to the mode stored.
> 
> This is commonly used on Android based devices, in order to
> reboot the device into fastboot or recovery mode.
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
> Tested-by: John Stultz <john.stultz@linaro.org>
> Acked-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v9:
> - select MFD_SYSCON when syscon-reboot-mode driver enabled
> - refactoring error handling in reboot_mode_register
> 
> Changes in v8:
> - do some cleanup when driver ubind
> 
> Changes in v7:
> - address some suggestions from Krzysztof, make syscon-reboot-mode driver data self-contained.
> 
> Changes in v6: None
> Changes in v5:
> - use two blank space under help in Kconfig
> - use unsigned int instead of int for member magic in struct mode_info
> 
> Changes in v4:
> - make this driver depends on OF to avoid kbuild test error
> 
> Changes in v3:
> - scan multi properities
> - add mask value for some platform which only use some bits of the register
>   to store boot mode magic value
> 
> Changes in v2:
> - move to dir drivers/power/reset/
> - make syscon-reboot-mode a generic driver
> 
> Changes in v1:
> - fix the embarrassed compile warning
> - correct the maskrom magic number
> - check for the normal reboot
> 
>  drivers/power/reset/Kconfig              |  14 ++++
>  drivers/power/reset/Makefile             |   2 +
>  drivers/power/reset/reboot-mode.c        | 128 +++++++++++++++++++++++++++++++
>  drivers/power/reset/reboot-mode.h        |  14 ++++
>  drivers/power/reset/syscon-reboot-mode.c | 100 ++++++++++++++++++++++++
>  5 files changed, 258 insertions(+)
>  create mode 100644 drivers/power/reset/reboot-mode.c
>  create mode 100644 drivers/power/reset/reboot-mode.h
>  create mode 100644 drivers/power/reset/syscon-reboot-mode.c

One minor whitespace issue at the end but beside that:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

(...)

> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
> new file mode 100644
> index 0000000..22e0685
> --- /dev/null
> +++ b/drivers/power/reset/syscon-reboot-mode.c
> @@ -0,0 +1,100 @@
> +/*
> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include "reboot-mode.h"
> +
> +struct syscon_reboot_mode {
> +	struct regmap *map;
> +	struct reboot_mode_driver reboot;
> +	u32 offset;
> +	u32 mask;
> +};
> +
> +static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
> +				    unsigned int magic)
> +{
> +	struct syscon_reboot_mode *syscon_rbm;
> +	int ret;
> +
> +	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
> +
> +	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
> +				 syscon_rbm->mask, magic);
> +	if (ret < 0)
> +		dev_err(reboot->dev, "update reboot mode bits failed\n");
> +
> +	return ret;
> +}
> +
> +static int syscon_reboot_mode_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct syscon_reboot_mode *syscon_rbm;
> +
> +	syscon_rbm = devm_kzalloc(&pdev->dev, sizeof(*syscon_rbm), GFP_KERNEL);
> +	if (!syscon_rbm)
> +		return -ENOMEM;
> +
> +	syscon_rbm->reboot.dev = &pdev->dev;
> +	syscon_rbm->reboot.write = syscon_reboot_mode_write;
> +	syscon_rbm->mask = 0xffffffff;
> +
> +	dev_set_drvdata(&pdev->dev, syscon_rbm);
> +
> +	syscon_rbm->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
> +	if (IS_ERR(syscon_rbm->map))
> +		return PTR_ERR(syscon_rbm->map);
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "offset",
> +	    &syscon_rbm->offset))
> +		return -EINVAL;
> +
> +	of_property_read_u32(pdev->dev.of_node, "mask", &syscon_rbm->mask);
> +
> +

Just one new line.

Best regards,
Krzysztof

> +	ret = reboot_mode_register(&syscon_rbm->reboot);
> +	if (ret)
> +		dev_err(&pdev->dev, "can't register reboot mode\n");
> +
> +	return ret;
> +}
> +
> +static int syscon_reboot_mode_remove(struct platform_device *pdev)
> +{
> +	struct syscon_reboot_mode *syscon_rbm = dev_get_drvdata(&pdev->dev);
> +
> +	return reboot_mode_unregister(&syscon_rbm->reboot);
> +}
> +
> +static const struct of_device_id syscon_reboot_mode_of_match[] = {
> +	{ .compatible = "syscon-reboot-mode" },
> +	{}
> +};
> +
> +static struct platform_driver syscon_reboot_mode_driver = {
> +	.probe = syscon_reboot_mode_probe,
> +	.remove = syscon_reboot_mode_remove,
> +	.driver = {
> +		.name = "syscon-reboot-mode",
> +		.of_match_table = syscon_reboot_mode_of_match,
> +	},
> +};
> +module_platform_driver(syscon_reboot_mode_driver);
> +
> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
> +MODULE_DESCRIPTION("SYSCON reboot mode driver");
> +MODULE_LICENSE("GPL v2");
> 


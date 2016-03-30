From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 2/4] power: reset: add reboot mode driver
Date: Wed, 30 Mar 2016 12:36:19 +0900
Message-ID: <56FB49B3.2040505@samsung.com>
References: <1459304304-9713-1-git-send-email-andy.yan@rock-chips.com>
 <1459304443-9811-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59614 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbcC3Dgd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 23:36:33 -0400
In-reply-to: <1459304443-9811-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>, robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de
Cc: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com

On 30.03.2016 11:20, Andy Yan wrote:
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
> Changes in v7:
> - address some suggestions from Krzysztof, make syscon-reboot-mode driver data self-contained.
> 

Thanks for changes, few comments below.

(...)

> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> new file mode 100644
> index 0000000..ae6f931
> --- /dev/null
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -0,0 +1,115 @@
> +/*
> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/reboot.h>
> +#include "reboot-mode.h"
> +
> +#define PREFIX "mode-"
> +
> +struct mode_info {
> +	const char *mode;
> +	unsigned int magic;
> +	struct list_head list;
> +};
> +
> +struct reboot_mode_driver {
> +	struct device *dev;
> +	struct list_head head;
> +	int (*write)(struct device *dev, int magic);
> +	struct notifier_block reboot_notifier;
> +};
> +
> +static int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
> +				 const char *cmd)
> +{
> +	const char *normal = "normal";
> +	int magic = 0;
> +	struct mode_info *info;
> +
> +	if (!cmd)
> +		cmd = normal;
> +
> +	list_for_each_entry(info, &reboot->head, list) {
> +		if (!strcmp(info->mode, cmd)) {
> +			magic = info->magic;
> +			break;
> +		}
> +	}
> +
> +	return magic;
> +}
> +
> +static int reboot_mode_notify(struct notifier_block *this,
> +			      unsigned long mode, void *cmd)
> +{
> +	struct reboot_mode_driver *reboot;
> +	int magic;
> +
> +	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
> +	magic = get_reboot_mode_magic(reboot, cmd);
> +	if (magic)
> +		reboot->write(reboot->dev, magic);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +int reboot_mode_register(struct device *dev, int (*write)(struct device *, int))
> +{
> +	struct reboot_mode_driver *reboot;
> +	struct mode_info *info;
> +	struct property *prop;
> +	struct device_node *np;
> +	size_t len = strlen(PREFIX);
> +	int ret;
> +
> +	reboot = devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
> +	if (!reboot)
> +		return -ENOMEM;
> +
> +	reboot->dev = dev;
> +	reboot->write = write;
> +	INIT_LIST_HEAD(&reboot->head);
> +
> +	np = of_node_get(dev->of_node);
> +	for_each_property_of_node(np, prop) {
> +		if (len > strlen(prop->name) || strncmp(prop->name, PREFIX, len))
> +			continue;
> +
> +		info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +		if (!info)

Clean up needed: of_node_put() and kfree_const() for items stored on the
list from previous iterations.

> +			return -ENOMEM;
> +
> +		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> +		if (of_property_read_u32(np, prop->name, &info->magic)) {
> +			dev_err(dev, "reboot mode %s without magic number\n",
> +				info->mode);
> +			devm_kfree(dev, info);
> +			continue;
> +		}
> +		list_add_tail(&info->list, &reboot->head);
> +	}
> +	of_node_put(np);

If you of_node_put() here, there is no sense in getting it before. I
mentioned of_node_get() only because I am not sure about life-cycle of
nodes in case of DT overlays and you are storing the pointer to string
from DT.

The doubts I have are concerning only the case of freeing nodes from
overlay.

I don't know if of_node_get() is needed but of_node_get()+of_node_put()
seems useless.

> +
> +	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
> +	ret = register_reboot_notifier(&reboot->reboot_notifier);
> +	if (ret)
> +		dev_err(dev, "can't register reboot notifier\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(reboot_mode_register);
> +
> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
> +MODULE_DESCRIPTION("System reboot mode driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/power/reset/reboot-mode.h b/drivers/power/reset/reboot-mode.h
> new file mode 100644
> index 0000000..c861129
> --- /dev/null
> +++ b/drivers/power/reset/reboot-mode.h
> @@ -0,0 +1,6 @@
> +#ifndef __REBOOT_MODE_H__
> +#define __REBOOT_MODE_H__
> +
> +int reboot_mode_register(struct device *dev, int (*write)(struct device *, int));
> +
> +#endif
> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
> new file mode 100644
> index 0000000..f1b8072
> --- /dev/null
> +++ b/drivers/power/reset/syscon-reboot-mode.c
> @@ -0,0 +1,86 @@
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
> +	struct device *dev;

'dev' looks unused (only set).

> +	struct regmap *map;
> +	u32 offset;
> +	u32 mask;
> +};
> +
> +static int syscon_reboot_mode_write(struct device *dev, int magic)
> +{
> +	struct syscon_reboot_mode *syscon_rbm = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
> +				 syscon_rbm->mask, magic);
> +	if (ret < 0)
> +		dev_err(dev, "update reboot mode bits failed\n");
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
> +	syscon_rbm->dev = &pdev->dev;
> +	syscon_rbm->mask = 0xffffffff;
> +
> +	syscon_rbm->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
> +	if (IS_ERR(syscon_rbm->map))
> +		return PTR_ERR(syscon_rbm->map);
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "offset", &syscon_rbm->offset))
> +		return -EINVAL;
> +
> +	of_property_read_u32(pdev->dev.of_node, "mask", &syscon_rbm->mask);
> +
> +	dev_set_drvdata(&pdev->dev, syscon_rbm);
> +
> +	ret = reboot_mode_register(&pdev->dev, syscon_reboot_mode_write);
> +	if (ret)
> +		dev_err(&pdev->dev, "can't register reboot mode\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id syscon_reboot_mode_of_match[] = {
> +	{ .compatible = "syscon-reboot-mode" },
> +	{}
> +};
> +
> +static struct platform_driver syscon_reboot_mode_driver = {
> +	.probe = syscon_reboot_mode_probe,

Cleanup needed. What will happen after device unbind? Memory will be
released (devm-*()) but reboot notifier won't thus leading to OOPS on
reboot.

Best regards,
Krzysztof

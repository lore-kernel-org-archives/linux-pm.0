From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 2/4] power: reset: add reboot mode driver
Date: Wed, 6 Apr 2016 08:50:51 +0800
Message-ID: <57045D6B.2080907@rock-chips.com>
References: <1459304304-9713-1-git-send-email-andy.yan@rock-chips.com>
 <1459304443-9811-1-git-send-email-andy.yan@rock-chips.com>
 <56FB49B3.2040505@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:46401 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbcDFAv0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 20:51:26 -0400
In-Reply-To: <56FB49B3.2040505@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, alexandre.belloni@free-electrons.com, f.fainelli@gmail.com, linux@arm.linux.org.uk, dbaryshkov@gmail.com, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, wxt@rock-chips.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, lorenzo.pieralisi@arm.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, moritz.fischer@ettus.com, mbrugger@suse.com, linux-kernel@vger.kernel.org, galak@codeaurora.org, olof@lixom.net, jun.nie@linaro.org, dwmw2@infradead.org

Hi Krzysztof:

     Thanks for you comments.

On 2016=E5=B9=B403=E6=9C=8830=E6=97=A5 11:36, Krzysztof Kozlowski wrote=
:
> On 30.03.2016 11:20, Andy Yan wrote:
>> This driver parses the reboot commands like "reboot bootloader"
>> and "reboot recovery" to get a boot mode described in the
>> device tree , then call the write interfae to store the boot
>> mode in some place like special register or sram, which can
>> be read by the bootloader after system reboot, then the bootloader
>> can take different action according to the mode stored.
>>
>> This is commonly used on Android based devices, in order to
>> reboot the device into fastboot or recovery mode.
>>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
>> Tested-by: John Stultz <john.stultz@linaro.org>
>> Acked-by: John Stultz <john.stultz@linaro.org>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> ---
>>
>> Changes in v7:
>> - address some suggestions from Krzysztof, make syscon-reboot-mode d=
river data self-contained.
>>
> Thanks for changes, few comments below.
>
> (...)
>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset=
/reboot-mode.c
>> new file mode 100644
>> index 0000000..ae6f931
>> --- /dev/null
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -0,0 +1,115 @@
>> +/*
>> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/reboot.h>
>> +#include "reboot-mode.h"
>> +
>> +#define PREFIX "mode-"
>> +
>> +struct mode_info {
>> +	const char *mode;
>> +	unsigned int magic;
>> +	struct list_head list;
>> +};
>> +
>> +struct reboot_mode_driver {
>> +	struct device *dev;
>> +	struct list_head head;
>> +	int (*write)(struct device *dev, int magic);
>> +	struct notifier_block reboot_notifier;
>> +};
>> +
>> +static int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>> +				 const char *cmd)
>> +{
>> +	const char *normal =3D "normal";
>> +	int magic =3D 0;
>> +	struct mode_info *info;
>> +
>> +	if (!cmd)
>> +		cmd =3D normal;
>> +
>> +	list_for_each_entry(info, &reboot->head, list) {
>> +		if (!strcmp(info->mode, cmd)) {
>> +			magic =3D info->magic;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return magic;
>> +}
>> +
>> +static int reboot_mode_notify(struct notifier_block *this,
>> +			      unsigned long mode, void *cmd)
>> +{
>> +	struct reboot_mode_driver *reboot;
>> +	int magic;
>> +
>> +	reboot =3D container_of(this, struct reboot_mode_driver, reboot_no=
tifier);
>> +	magic =3D get_reboot_mode_magic(reboot, cmd);
>> +	if (magic)
>> +		reboot->write(reboot->dev, magic);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +int reboot_mode_register(struct device *dev, int (*write)(struct de=
vice *, int))
>> +{
>> +	struct reboot_mode_driver *reboot;
>> +	struct mode_info *info;
>> +	struct property *prop;
>> +	struct device_node *np;
>> +	size_t len =3D strlen(PREFIX);
>> +	int ret;
>> +
>> +	reboot =3D devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
>> +	if (!reboot)
>> +		return -ENOMEM;
>> +
>> +	reboot->dev =3D dev;
>> +	reboot->write =3D write;
>> +	INIT_LIST_HEAD(&reboot->head);
>> +
>> +	np =3D of_node_get(dev->of_node);
>> +	for_each_property_of_node(np, prop) {
>> +		if (len > strlen(prop->name) || strncmp(prop->name, PREFIX, len))
>> +			continue;
>> +
>> +		info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> +		if (!info)
> Clean up needed: of_node_put() and kfree_const() for items stored on =
the
> list from previous iterations.

     Okay, I will add it in V8.
>> +			return -ENOMEM;
>> +
>> +		info->mode =3D kstrdup_const(prop->name + len, GFP_KERNEL);
>> +		if (of_property_read_u32(np, prop->name, &info->magic)) {
>> +			dev_err(dev, "reboot mode %s without magic number\n",
>> +				info->mode);
>> +			devm_kfree(dev, info);
>> +			continue;
>> +		}
>> +		list_add_tail(&info->list, &reboot->head);
>> +	}
>> +	of_node_put(np);
> If you of_node_put() here, there is no sense in getting it before. I
> mentioned of_node_get() only because I am not sure about life-cycle o=
f
> nodes in case of DT overlays and you are storing the pointer to strin=
g
> from DT.
>
> The doubts I have are concerning only the case of freeing nodes from
> overlay.
>
> I don't know if of_node_get() is needed but of_node_get()+of_node_put=
()
> seems useless.


  I am also not sure about it. Maybe just drop of_node_get/put ?
>> +
>> +	reboot->reboot_notifier.notifier_call =3D reboot_mode_notify;
>> +	ret =3D register_reboot_notifier(&reboot->reboot_notifier);
>> +	if (ret)
>> +		dev_err(dev, "can't register reboot notifier\n");
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(reboot_mode_register);
>> +
>> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
>> +MODULE_DESCRIPTION("System reboot mode driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/power/reset/reboot-mode.h b/drivers/power/reset=
/reboot-mode.h
>> new file mode 100644
>> index 0000000..c861129
>> --- /dev/null
>> +++ b/drivers/power/reset/reboot-mode.h
>> @@ -0,0 +1,6 @@
>> +#ifndef __REBOOT_MODE_H__
>> +#define __REBOOT_MODE_H__
>> +
>> +int reboot_mode_register(struct device *dev, int (*write)(struct de=
vice *, int));
>> +
>> +#endif
>> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/powe=
r/reset/syscon-reboot-mode.c
>> new file mode 100644
>> index 0000000..f1b8072
>> --- /dev/null
>> +++ b/drivers/power/reset/syscon-reboot-mode.c
>> @@ -0,0 +1,86 @@
>> +/*
>> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reboot.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +#include "reboot-mode.h"
>> +
>> +struct syscon_reboot_mode {
>> +	struct device *dev;
> 'dev' looks unused (only set).

     This will be removed.
>
>> +	struct regmap *map;
>> +	u32 offset;
>> +	u32 mask;
>> +};
>> +
>> +static int syscon_reboot_mode_write(struct device *dev, int magic)
>> +{
>> +	struct syscon_reboot_mode *syscon_rbm =3D dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret =3D regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
>> +				 syscon_rbm->mask, magic);
>> +	if (ret < 0)
>> +		dev_err(dev, "update reboot mode bits failed\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int syscon_reboot_mode_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct syscon_reboot_mode *syscon_rbm;
>> +
>> +	syscon_rbm =3D devm_kzalloc(&pdev->dev, sizeof(*syscon_rbm), GFP_K=
ERNEL);
>> +	if (!syscon_rbm)
>> +		return -ENOMEM;
>> +
>> +	syscon_rbm->dev =3D &pdev->dev;
>> +	syscon_rbm->mask =3D 0xffffffff;
>> +
>> +	syscon_rbm->map =3D syscon_node_to_regmap(pdev->dev.parent->of_nod=
e);
>> +	if (IS_ERR(syscon_rbm->map))
>> +		return PTR_ERR(syscon_rbm->map);
>> +
>> +	if (of_property_read_u32(pdev->dev.of_node, "offset", &syscon_rbm-=
>offset))
>> +		return -EINVAL;
>> +
>> +	of_property_read_u32(pdev->dev.of_node, "mask", &syscon_rbm->mask)=
;
>> +
>> +	dev_set_drvdata(&pdev->dev, syscon_rbm);
>> +
>> +	ret =3D reboot_mode_register(&pdev->dev, syscon_reboot_mode_write)=
;
>> +	if (ret)
>> +		dev_err(&pdev->dev, "can't register reboot mode\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id syscon_reboot_mode_of_match[] =3D =
{
>> +	{ .compatible =3D "syscon-reboot-mode" },
>> +	{}
>> +};
>> +
>> +static struct platform_driver syscon_reboot_mode_driver =3D {
>> +	.probe =3D syscon_reboot_mode_probe,
> Cleanup needed. What will happen after device unbind? Memory will be
> released (devm-*()) but reboot notifier won't thus leading to OOPS on
> reboot.

     From the kernel_restart_prepare function, the reboot notifier will=
=20
be called before device_shutdown. Is there any other case the device=20
unbind before reboot notifier
called?
> Best regards,
> Krzysztof
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>
>



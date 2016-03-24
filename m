From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v6 2/4] power: reset: add reboot mode driver
Date: Thu, 24 Mar 2016 16:03:02 +0800
Message-ID: <56F39F36.5050702@rock-chips.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646642-591-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPcKzGTAicbsXK-cC9WQT0vBhpSG_q2GCn37+72x2hdhsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:38801 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbcCXID3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 04:03:29 -0400
In-Reply-To: <CAJKOXPcKzGTAicbsXK-cC9WQT0vBhpSG_q2GCn37+72x2hdhsQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com

Hi Krzystof:

On 2016=E5=B9=B403=E6=9C=8824=E6=97=A5 10:50, Krzysztof Kozlowski wrote=
:
> Cool work! Few comments below.
>
>
> On Tue, Mar 22, 2016 at 8:37 PM, Andy Yan <andy.yan@rock-chips.com> w=
rote:
>> This driver parse the reboot commands like "reboot loader"
>> and "reboot recovery" to get a boot mode described in the
>> device tree , then call the write interfae to store the boot
>> mode in some place like special register or sram , which can
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
>> Changes in v6: None
>> Changes in v5:
>> - use two blank space under help in Kconfig
>> - use unsigned int instead of int for member magic in struct mode_in=
fo
>>
>> Changes in v4:
>> - make this driver depends on OF to avoid kbuild test error
>>
>> Changes in v3:
>> - scan multi properities
>> - add mask value for some platform which only use some bits of the r=
egister
>>    to store boot mode magic value
>>
>> Changes in v2:
>> - move to dir drivers/power/reset/
>> - make syscon-reboot-mode a generic driver
>>
>> Changes in v1:
>> - fix the embarrassed compile warning
>> - correct the maskrom magic number
>> - check for the normal reboot
>>
>>   drivers/power/reset/Kconfig              |  13 ++++
>>   drivers/power/reset/Makefile             |   2 +
>>   drivers/power/reset/reboot-mode.c        | 106 +++++++++++++++++++=
++++++++++++
>>   drivers/power/reset/reboot-mode.h        |   6 ++
>>   drivers/power/reset/syscon-reboot-mode.c |  65 +++++++++++++++++++
>>   5 files changed, 192 insertions(+)
>>   create mode 100644 drivers/power/reset/reboot-mode.c
>>   create mode 100644 drivers/power/reset/reboot-mode.h
>>   create mode 100644 drivers/power/reset/syscon-reboot-mode.c
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconf=
ig
>> index 1131cf7..cf50630 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -173,5 +173,18 @@ config POWER_RESET_ZX
>>          help
>>            Reboot support for ZTE SoCs.
>>
>> +config REBOOT_MODE
>> +       tristate
>> +
>> +config SYSCON_REBOOT_MODE
>> +       bool "Generic SYSCON regmap reboot mode driver"
>> +       depends on OF
>> +       select REBOOT_MODE
>> +       help
>> +         Say y here will enable reboot mode driver. This will
>> +         get reboot mode arguments and store it in SYSCON mapped
>> +         register, then the bootloader can read it to take differen=
t
>> +         action according to the mode.
>> +
>>   endif
>>
>> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Make=
file
>> index 096fa67..a63865b 100644
>> --- a/drivers/power/reset/Makefile
>> +++ b/drivers/power/reset/Makefile
>> @@ -20,3 +20,5 @@ obj-$(CONFIG_POWER_RESET_SYSCON) +=3D syscon-reboo=
t.o
>>   obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) +=3D syscon-poweroff.o
>>   obj-$(CONFIG_POWER_RESET_RMOBILE) +=3D rmobile-reset.o
>>   obj-$(CONFIG_POWER_RESET_ZX) +=3D zx-reboot.o
>> +obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
>> +obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset=
/reboot-mode.c
>> new file mode 100644
>> index 0000000..9aa7b80
>> --- /dev/null
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -0,0 +1,106 @@
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
>> +       char mode[32];
>> +       unsigned int magic;
>> +       struct list_head list;
>> +};
>> +
>> +struct reboot_mode_driver {
>> +       struct list_head head;
>> +       int (*write)(int magic);
>> +       struct notifier_block reboot_notifier;
>> +};
>> +
>> +static int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>> +                                const char *cmd)
>> +{
>> +       const char *normal =3D "normal";
>> +       int magic =3D 0;
>> +       struct mode_info *info;
>> +
>> +       if (!cmd)
>> +               cmd =3D normal;
>> +
>> +       list_for_each_entry(info, &reboot->head, list) {
>> +               if (!strcmp(info->mode, cmd)) {
>> +                       magic =3D info->magic;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       return magic;
> In absence of 'normal' mode (it is not described as required property=
)
> the magic will be '0'. It would be nice to document that in bindings.
> Imagine someone forgets about this and will wonder why 0x0 is written
> to his precious register on normal reboot...

     If the magic value is '0', we won't touch the register, please see=
=20
reboot_mode_notify bellow.
> It would be nice to document that 'mode-normal' has a special
> (hard-coded) meaning.
>
>> +}
>> +
>> +static int reboot_mode_notify(struct notifier_block *this,
>> +                             unsigned long mode, void *cmd)
>> +{
>> +       struct reboot_mode_driver *reboot;
>> +       int magic;
>> +
>> +       reboot =3D container_of(this, struct reboot_mode_driver, reb=
oot_notifier);
>> +       magic =3D get_reboot_mode_magic(reboot, cmd);
>> +       if (magic)
>> +               reboot->write(magic);
>> +
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +int reboot_mode_register(struct device *dev, int (*write)(int))
>> +{
>> +       struct reboot_mode_driver *reboot;
>> +       struct mode_info *info;
>> +       struct property *prop;
>> +       size_t len =3D strlen(PREFIX);
>> +       int ret;
>> +
>> +       reboot =3D devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
>> +       if (!reboot)
>> +               return -ENOMEM;
>> +
>> +       reboot->write =3D write;
>> +       INIT_LIST_HEAD(&reboot->head);
>> +       for_each_property_of_node(dev->of_node, prop) {
>> +               if (len > strlen(prop->name) || strncmp(prop->name, =
PREFIX, len))
>> +                       continue;
> New line please for readability.

     Okay
>
>> +               info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL=
);
>> +               if (!info)
>> +                       return -ENOMEM;
> Ditto.

     Okay
>
>> +               strcpy(info->mode, prop->name + len);
> Ehm, and how do you protect that name of mode is shorter than 32 char=
acters?

     How about info->mode =3D prop->name + len ?
>
>> +               if (of_property_read_u32(dev->of_node, prop->name, &=
info->magic)) {
>> +                       dev_err(dev, "reboot mode %s without magic n=
umber\n",
>> +                               info->mode);
>> +                       devm_kfree(dev, info);
>> +                       continue;
>> +               }
>> +               list_add_tail(&info->list, &reboot->head);
>> +       }
>> +       reboot->reboot_notifier.notifier_call =3D reboot_mode_notify=
;
>> +       ret =3D register_reboot_notifier(&reboot->reboot_notifier);
>> +       if (ret)
>> +               dev_err(dev, "can't register reboot notifier\n");
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(reboot_mode_register);
>> +
>> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
>> +MODULE_DESCRIPTION("System reboot mode driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/power/reset/reboot-mode.h b/drivers/power/reset=
/reboot-mode.h
>> new file mode 100644
>> index 0000000..44ed34f
>> --- /dev/null
>> +++ b/drivers/power/reset/reboot-mode.h
>> @@ -0,0 +1,6 @@
>> +#ifndef __REBOOT_MODE_H__
>> +#define __REBOOT_MODE_H__
>> +
>> +int reboot_mode_register(struct device *dev, int (*write)(int));
> Documentation would be appreciated. Although it is local header but
> you decoupled them and you are exporting the function.

     I think I should remove the EXPORT_SYMBOL_GPL.
>
>> +
>> +#endif
>> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/powe=
r/reset/syscon-reboot-mode.c
>> new file mode 100644
>> index 0000000..d1521d8
>> --- /dev/null
>> +++ b/drivers/power/reset/syscon-reboot-mode.c
>> @@ -0,0 +1,65 @@
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
>> +#include <linux/of_address.h>
> I don't see the need of of_address or am I missing something?

     Yes, it useless, I will remove it.
>
>> +#include <linux/platform_device.h>
>> +#include <linux/reboot.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +#include "reboot-mode.h"
>> +
>> +static struct regmap *map;
>> +static u32 offset;
>> +static u32 mask =3D 0xffffffff;
> Why this cannot be part of state container? I suppose usually there
> will be only one reboot mode handler, but:
> 1. It is always nice to make things self-contained, so code could be
> easily used in different contexts. Depending on static variables
> prevents that.
> 2. How do you protect against double binding (two reboot mode device
> nodes in DT)? The second binding (put by mistake... or whatever
> reason) will overwrite data used by previous device.

     Okay, I will make this self-contained.
>> +
>> +static int syscon_reboot_mode_write(int magic)
>> +{
>> +       regmap_update_bits(map, offset, mask, magic);
>> +
>> +       return 0;
> Why ignoring return value of regmap_update_bits?

     Okay, I will check it.
>
>> +}
>> +
>> +static int syscon_reboot_mode_probe(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +
>> +       map =3D syscon_node_to_regmap(pdev->dev.parent->of_node);
>> +       if (IS_ERR(map))
>> +               return PTR_ERR(map);
> Empty line for readability.
     ok
>> +       if (of_property_read_u32(pdev->dev.of_node, "offset", &offse=
t))
>> +               return -EINVAL;
> Empty line for readability.
     ok
>
> Best regards,
> Krzysztof
>
>
>
>




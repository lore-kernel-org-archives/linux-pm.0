From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v8 2/4] power: reset: add reboot mode driver
Date: Mon, 25 Apr 2016 19:29:52 +0800
Message-ID: <571DFFB0.4010409@rock-chips.com>
References: <1461567051-21734-1-git-send-email-andy.yan@rock-chips.com>
 <1461567336-21834-1-git-send-email-andy.yan@rock-chips.com>
 <571DF49F.6000706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <571DF49F.6000706-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof:

On 2016=E5=B9=B404=E6=9C=8825=E6=97=A5 18:42, Krzysztof Kozlowski wrote=
:
> On 04/25/2016 08:55 AM, Andy Yan wrote:
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
>> Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Reviewed-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
>> Tested-by: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Acked-by: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>
>> ---
>>
>> Changes in v8:
>> - do some cleanup when driver ubind
>>
>> Changes in v7:
>> - address some suggestions from Krzysztof, make syscon-reboot-mode d=
river data self-contained.
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
>>   drivers/power/reset/reboot-mode.c        | 118 +++++++++++++++++++=
++++++++++++
>>   drivers/power/reset/reboot-mode.h        |  14 ++++
>>   drivers/power/reset/syscon-reboot-mode.c |  99 +++++++++++++++++++=
+++++++
>>   5 files changed, 246 insertions(+)
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
>>   	help
>>   	  Reboot support for ZTE SoCs.
>>  =20
>> +config REBOOT_MODE
>> +	tristate
>> +
>> +config SYSCON_REBOOT_MODE
>> +	bool "Generic SYSCON regmap reboot mode driver"
>> +	depends on OF
>> +	select REBOOT_MODE
>> +	help
>> +	  Say y here will enable reboot mode driver. This will
>> +	  get reboot mode arguments and store it in SYSCON mapped
>> +	  register, then the bootloader can read it to take different
>> +	  action according to the mode.
>> +
>>   endif
>>  =20
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
>> index 0000000..cdc4d72
>> --- /dev/null
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -0,0 +1,118 @@
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
>> +		reboot->write(reboot, magic);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +int reboot_mode_register(struct reboot_mode_driver *reboot)
>> +{
>> +	struct mode_info *info;
>> +	struct property *prop;
>> +	struct device_node *np =3D reboot->dev->of_node;
>> +	size_t len =3D strlen(PREFIX);
>> +	int ret;
>> +
>> +	INIT_LIST_HEAD(&reboot->head);
>> +
>> +	for_each_property_of_node(np, prop) {
>> +		if (len > strlen(prop->name) || strncmp(prop->name, PREFIX, len))
>> +			continue;
>> +
>> +		info =3D devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
>> +		if (!info) {
>> +			ret =3D -ENOMEM;
>> +			goto error;
>> +		}
>> +
>> +		info->mode =3D kstrdup_const(prop->name + len, GFP_KERNEL);
>> +		if (of_property_read_u32(np, prop->name, &info->magic)) {
>> +			dev_err(reboot->dev, "reboot mode %s without magic number\n",
>> +				info->mode);
>> +			devm_kfree(reboot->dev, info);
> kfree_const(). The duplicated string won't be added to the list so it
> won't be freed in error path or in unregister().

    Each mode has a mode_info,  if one of them gets an error whith=20
devm_kzalloc, they other mode_info add to the list before should be fre=
ed.
>
>> +			continue;
>> +		}
>> +		list_add_tail(&info->list, &reboot->head);
>> +	}
>> +
>> +	reboot->reboot_notifier.notifier_call =3D reboot_mode_notify;
>> +	ret =3D register_reboot_notifier(&reboot->reboot_notifier);
>> +	if (ret)
>> +		dev_err(reboot->dev, "can't register reboot notifier\n");
> I don't understand your error paths. In previous patches they were
> buggy... they still look buggy, I think. It's 8th iteration and such
> basic things are still present.
>
> If this is an error then shouldn't everything be cleaned up? You are
> returning error code thus the reboot_mode_register() caller will fail=
=2E
> This means the probe will fail. So you need to clean up - go to error=
?

     If this is an error, I think only the duplicated string should be=20
clean up,because other resources allocated by devm. If there is=20
something else, please let me know.

  thanks.


> Best regards,
> Krzysztof
>
>
>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

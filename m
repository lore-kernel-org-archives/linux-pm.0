From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
Date: Sat, 14 Jun 2014 00:43:00 +0200
Message-ID: <539B7E74.7000605@linaro.org>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org> <1402476643.32147.6.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:49106 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbaFMWnE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 18:43:04 -0400
Received: by mail-wi0-f175.google.com with SMTP id r20so1618006wiv.8
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2014 15:43:02 -0700 (PDT)
In-Reply-To: <1402476643.32147.6.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: kgene.kim@samsung.com, t.figa@samsung.com, ccross@google.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com

On 06/11/2014 10:50 AM, Krzysztof Kozlowski wrote:
> On pi=C4=85, 2014-04-04 at 11:48 +0200, Daniel Lezcano wrote:
>> The following driver is for exynos4210. I did not yet finished the o=
ther boards, so
>> I created a specific driver for 4210 which could be merged later.
>>
>> The driver is based on Colin Cross's driver found at:
>>
>> https://android.googlesource.com/kernel/exynos/+/e686b1ec67423c40b4f=
df811f9a4dfa3b393a010%5E%5E!/
>>
>> This one was based on a 3.4 kernel and an old API.
>>
>> It has been refreshed, simplified and based on the recent code clean=
up I sent
>> today.
>>
>> The AFTR could be entered when all the cpus (except cpu0) are down. =
In order to
>> reach this situation, the couple idle states are used.
>>
>> There is a sync barrier at the entry and the exit of the low power f=
unction. So
>> all cpus will enter and exit the function at the same time.
>>
>> At this point, CPU0 knows the other cpu will power down itself. CPU0=
 waits for
>> the CPU1 to be powered down and then initiate the AFTR power down se=
quence.
>>
>> No interrupts are handled by CPU1, this is why we switch to the time=
r broadcast
>> even if the local timer is not impacted by the idle state.
>>
>> When CPU0 wakes up, it powers up CPU1 and waits for it to boot. Then=
 they both
>> exit the idle function.
>>
>> This driver allows the exynos4210 to have the same power consumption=
 at idle
>> time than the one when we have to unplug CPU1 in order to let CPU0 t=
o reach
>> the AFTR state.
>>
>> This patch is a RFC because, we have to find a way to remove the mac=
ros
>> definitions and cpu powerdown function without pulling the arch depe=
ndent
>> headers.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-exynos/common.c        |   11 +-
>>   drivers/cpuidle/Kconfig.arm          |    8 ++
>>   drivers/cpuidle/Makefile             |    1 +
>>   drivers/cpuidle/cpuidle-exynos4210.c |  226 ++++++++++++++++++++++=
++++++++++++
>>   4 files changed, 245 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/cpuidle/cpuidle-exynos4210.c
>
> (...)
>
>> diff --git a/drivers/cpuidle/cpuidle-exynos4210.c b/drivers/cpuidle/=
cpuidle-exynos4210.c
>> new file mode 100644
>> index 0000000..56f6d51
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-exynos4210.c
>> @@ -0,0 +1,226 @@
>> +/*
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * Copyright (c) 2014 Linaro : Daniel Lezcano <daniel.lezcano@linar=
o.org>
>> + *		http://www.linaro.org
>> + *
>> + * Based on the work of Colin Cross <ccross@android.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/cpuidle.h>
>> +#include <linux/cpu_pm.h>
>> +#include <linux/io.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <asm/proc-fns.h>
>> +#include <asm/suspend.h>
>> +#include <asm/cpuidle.h>
>> +
>> +#include <plat/pm.h>
>> +#include <plat/cpu.h>
>> +#include <plat/map-base.h>
>> +#include <plat/map-s5p.h>
>> +
>> +static atomic_t exynos_idle_barrier;
>
> Hi,
>
> Shouldn't the exynos_idle_barrier be initialized here?

As it is a static data it will be initialized to zero.

> I know you sent the patch almost 2 months ago but I stomped on this
> while testing it on Exynos3250.

No problem. And what results on exynos3250 ?

Thanks !

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


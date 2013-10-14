From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] ARM: at91: cpuidle: convert to platform driver
Date: Mon, 14 Oct 2013 16:18:25 +0200
Message-ID: <525BFD31.3020406@linaro.org>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org> <20131014140406.GH11420@ns203013.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34936 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab3JNOS3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 10:18:29 -0400
Received: by mail-wi0-f175.google.com with SMTP id hm4so1264309wib.14
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2013 07:18:27 -0700 (PDT)
In-Reply-To: <20131014140406.GH11420@ns203013.ovh.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 10/14/2013 04:04 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:51 Sat 12 Oct     , Daniel Lezcano wrote:
>> Use the platform driver model to separate the cpuidle specific code =
from
>> the low level pm code. It allows to remove the dependency between
>> these two components.
>>
>> Tested-on usb-a9263 (at91sam9263)
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-at91/cpuidle.c |   29 +++++++++++++++--------------
>>   arch/arm/mach-at91/pm.c      |   16 +++++++++++++++-
>>   2 files changed, 30 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuid=
le.c
>> index 4ec6a6d..6cdc76d 100644
>> --- a/arch/arm/mach-at91/cpuidle.c
>> +++ b/arch/arm/mach-at91/cpuidle.c
>> @@ -21,26 +21,17 @@
>>   #include <linux/export.h>
>>   #include <asm/proc-fns.h>
>>   #include <asm/cpuidle.h>
>> -#include <mach/cpu.h>
>> -
>> -#include "pm.h"
>>
>>   #define AT91_MAX_STATES	2
>>
>> +static void (*at91_standby)(void);
>> +
>>   /* Actual code that puts the SoC in different idle states */
>>   static int at91_enter_idle(struct cpuidle_device *dev,
>>   			struct cpuidle_driver *drv,
>>   			       int index)
>>   {
>> -	if (cpu_is_at91rm9200())
>> -		at91rm9200_standby();
>> -	else if (cpu_is_at91sam9g45())
>> -		at91sam9g45_standby();
>> -	else if (cpu_is_at91sam9263())
>> -		at91sam9263_standby();
>> -	else
>> -		at91sam9_standby();
>> -
>> +	at91_standby();
>>   	return index;
>>   }
>>
>> @@ -60,9 +51,19 @@ static struct cpuidle_driver at91_idle_driver =3D=
 {
>>   };
>>
>>   /* Initialize CPU idle by registering the idle states */
>> -static int __init at91_init_cpuidle(void)
>> +static int __init at91_cpuidle_probe(struct platform_device *dev)
>>   {
>> +	at91_standby =3D (void *)(dev->dev.platform_data);
>> +=09
>>   	return cpuidle_register(&at91_idle_driver, NULL);
>>   }
>>
>> -device_initcall(at91_init_cpuidle);
>> +static struct platform_driver at91_cpuidle_driver =3D {
>> +	.driver =3D {
>> +		.name =3D "cpuidle-at91",
>> +		.owner =3D THIS_MODULE,
>> +	},
>> +	.probe =3D at91_cpuidle_probe,
>> +};
>> +
>> +module_platform_driver(at91_cpuidle_driver);
>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>> index 15afb5d..debdbf8 100644
>> --- a/arch/arm/mach-at91/pm.c
>> +++ b/arch/arm/mach-at91/pm.c
>> @@ -314,6 +314,10 @@ static const struct platform_suspend_ops at91_p=
m_ops =3D {
>>   	.end	=3D at91_pm_end,
>>   };
>>
>> +static struct platform_device at91_cpuidle_device =3D {
>> +	.name =3D "cpuidle-at91",
>> +};
>> +
>>   static int __init at91_pm_init(void)
>>   {
>>   #ifdef CONFIG_AT91_SLOW_CLOCK
>> @@ -323,8 +327,18 @@ static int __init at91_pm_init(void)
>>   	pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow =
clock mode)" : ""));
>>
>>   	/* AT91RM9200 SDRAM low-power mode cannot be used with self-refre=
sh. */
>> -	if (cpu_is_at91rm9200())
>> +	if (cpu_is_at91rm9200()) {
>> +		at91_cpuidle_device.dev.platform_data =3D at91rm9200_standby;
>>   		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
>> +	} else if (cpu_is_at91sam9g45()) {
>> +		at91_cpuidle_device.dev.platform_data =3D at91sam9g45_standby;
>> +	} else if (cpu_is_at91sam9263()) {
>> +		at91_cpuidle_device.dev.platform_data =3D at91sam9263_standby;
>> +	} else {
>> +		at91_cpuidle_device.dev.platform_data =3D at91sam9_standby;
> no this is too dangerous when adding new SoC
>
> you must list the supported SoC
>
> and I prefer to move this code to the SoC init structure

Do you mean register the platform_device in eg. at91rm9200_initialize=20
with the right platform data ?


> so we can drop the if/else if/elsee
>
> and drop the issue of adding new and the arch_initcall
>
> Best Regards,
> J.
>> +	}
>> +=09
>> +	platform_device_register(&at91_cpuidle_device);
>>
>>   	suspend_set_ops(&at91_pm_ops);
>>
>> --
>> 1.7.9.5
>>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


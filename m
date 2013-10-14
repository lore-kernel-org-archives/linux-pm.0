From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] ARM: at91: cpuidle: convert to platform driver
Date: Mon, 14 Oct 2013 19:59:28 +0200
Message-ID: <525C3100.40407@linaro.org>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org> <20131014140406.GH11420@ns203013.ovh.net> <525BFD31.3020406@linaro.org> <20131014142719.GI11420@ns203013.ovh.net> <525C1C40.7010508@linaro.org> <20131014171831.GK11420@ns203013.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:58315 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab3JNR7c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 13:59:32 -0400
Received: by mail-we0-f175.google.com with SMTP id t61so7326304wes.20
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2013 10:59:31 -0700 (PDT)
In-Reply-To: <20131014171831.GK11420@ns203013.ovh.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 10/14/2013 07:18 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:30 Mon 14 Oct     , Daniel Lezcano wrote:
>> On 10/14/2013 04:27 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 16:18 Mon 14 Oct     , Daniel Lezcano wrote:
>>>> On 10/14/2013 04:04 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>> On 17:51 Sat 12 Oct     , Daniel Lezcano wrote:
>>>>>> Use the platform driver model to separate the cpuidle specific c=
ode from
>>>>>> the low level pm code. It allows to remove the dependency betwee=
n
>>>>>> these two components.
>>>>>>
>>>>>> Tested-on usb-a9263 (at91sam9263)
>>>>>>
>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> [ ... ]
>>
>>>>>> ---
>>>>>>   	/* AT91RM9200 SDRAM low-power mode cannot be used with self-r=
efresh. */
>>>>>> -	if (cpu_is_at91rm9200())
>>>>>> +	if (cpu_is_at91rm9200()) {
>>>>>> +		at91_cpuidle_device.dev.platform_data =3D at91rm9200_standby;
>>>>>>   		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
>>>>>> +	} else if (cpu_is_at91sam9g45()) {
>>>>>> +		at91_cpuidle_device.dev.platform_data =3D at91sam9g45_standby=
;
>>>>>> +	} else if (cpu_is_at91sam9263()) {
>>>>>> +		at91_cpuidle_device.dev.platform_data =3D at91sam9263_standby=
;
>>>>>> +	} else {
>>>>>> +		at91_cpuidle_device.dev.platform_data =3D at91sam9_standby;
>>>>> no this is too dangerous when adding new SoC
>>>>>
>>>>> you must list the supported SoC
>>>>>
>>>>> and I prefer to move this code to the SoC init structure
>>>>
>>>> Do you mean register the platform_device in eg.
>>>> at91rm9200_initialize with the right platform data ?
>>>>
>>> yes as example
>>>
>>> Best Regards,
>>
>> Hi Jean-Christophe,
>>
>> I did the changes but there are different drawbacks with the approac=
h.
>> The first one is the AT91_SOC_START is too early to call the
>> platform_device_register. The second one is we have multiple
>> declaration of the platform_device which is not really nice.
>>
>> I found the following solution:
>>
>> The platform_device is static in pm.c, there is a
>> at91_pm_set_standby function. All AT91_SOC_START call
>> at91_pm_set_standby with the right standby function callback, which
>> in turns set the platform data for the cpuidle platform device. When
>> the init call for pm is made, it registers the platform device.
>>
>> That has the benefit to encapsulate the platform device and having
>> it in a single place and also we have the information to remove the
>> { if then else } statements we have in 'at91_pm_enter's case block
>> for PM_SUSPEND_STANDBY.
> why not
>
> but some comment
>
> and that was one of the reason why the else in the previous implement=
ation was
> wrong

Ok, I see.

I will send a V2.

Thanks for the review !

   -- Daniel

>>
>> Does it sound ok for you ?
>>
>> Thanks
>>    -- Daniel
>>
>> diff --git a/arch/arm/mach-at91/at91rm9200.c
>> b/arch/arm/mach-at91/at91rm9200.c
>> index 4aad93d..0d234f2 100644
>> --- a/arch/arm/mach-at91/at91rm9200.c
>> +++ b/arch/arm/mach-at91/at91rm9200.c
>> @@ -27,6 +27,7 @@
>>   #include "generic.h"
>>   #include "clock.h"
>>   #include "sam9_smc.h"
>> +#include "pm.h"
>>
>>   /* ---------------------------------------------------------------=
-----
>>    *  Clocks
>> @@ -337,6 +338,8 @@ static void __init at91rm9200_initialize(void)
>>   	/* Initialize GPIO subsystem */
>>   	at91_gpio_init(at91rm9200_gpio,
>>   		cpu_is_at91rm9200_bga() ? AT91RM9200_BGA : AT91RM9200_PQFP);
>> +
>> +	at91_pm_set_standby(at91rm9200_standby);
>>   }
>>
>>
>> diff --git a/arch/arm/mach-at91/at91sam9260.c
>> b/arch/arm/mach-at91/at91sam9260.c
>> index 5de6074..9fd7aa6 100644
>> --- a/arch/arm/mach-at91/at91sam9260.c
>> +++ b/arch/arm/mach-at91/at91sam9260.c
>> @@ -28,6 +28,7 @@
>>   #include "generic.h"
>>   #include "clock.h"
>>   #include "sam9_smc.h"
>> +#include "pm.h"
>>
>>   /* ---------------------------------------------------------------=
-----
>>    *  Clocks
>> @@ -307,7 +308,6 @@ static struct at91_gpio_bank at91sam9260_gpio[]
>> __initdata =3D {
>>   /* ---------------------------------------------------------------=
-----
>>    *  AT91SAM9260 processor initialization
>>    * ---------------------------------------------------------------=
----- */
>> -
>>   static void __init at91sam9xe_map_io(void)
>>   {
>>   	unsigned long sram_size;
>> @@ -351,6 +351,8 @@ static void __init at91sam9260_initialize(void)
>>
>>   	/* Register GPIO subsystem */
>>   	at91_gpio_init(at91sam9260_gpio, 3);
>> +
>> +	at91_pm_set_standby(at91sam9_standby);
>>   }
>>
>>   /* ---------------------------------------------------------------=
-----
>> diff --git a/arch/arm/mach-at91/at91sam9261.c
>> b/arch/arm/mach-at91/at91sam9261.c
>> index 0e07932..1edbb6f 100644
>> --- a/arch/arm/mach-at91/at91sam9261.c
>> +++ b/arch/arm/mach-at91/at91sam9261.c
>> @@ -27,6 +27,7 @@
>>   #include "generic.h"
>>   #include "clock.h"
>>   #include "sam9_smc.h"
>> +#include "pm.h"
>>
>>   /* ---------------------------------------------------------------=
-----
>>    *  Clocks
>> @@ -293,6 +294,8 @@ static void __init at91sam9261_initialize(void)
>>
>>   	/* Register GPIO subsystem */
>>   	at91_gpio_init(at91sam9261_gpio, 3);
>> +
>> +	at91_pm_set_sandby(at91sam9_standby);
>>   }
>>
>>   /* ---------------------------------------------------------------=
-----
>> diff --git a/arch/arm/mach-at91/at91sam9263.c
>> b/arch/arm/mach-at91/at91sam9263.c
>> index 6ce7d18..b222d59 100644
>> --- a/arch/arm/mach-at91/at91sam9263.c
>> +++ b/arch/arm/mach-at91/at91sam9263.c
>> @@ -26,6 +26,7 @@
>>   #include "generic.h"
>>   #include "clock.h"
>>   #include "sam9_smc.h"
>> +#include "pm.h"
>>
>>   /* ---------------------------------------------------------------=
-----
>>    *  Clocks
>> @@ -304,7 +305,6 @@ static struct at91_gpio_bank at91sam9263_gpio[]
>> __initdata =3D {
>>   /* ---------------------------------------------------------------=
-----
>>    *  AT91SAM9263 processor initialization
>>    * ---------------------------------------------------------------=
----- */
>> -
>>   static void __init at91sam9263_map_io(void)
>>   {
>>   	at91_init_sram(0, AT91SAM9263_SRAM0_BASE, AT91SAM9263_SRAM0_SIZE)=
;
>> @@ -330,6 +330,8 @@ static void __init at91sam9263_initialize(void)
>>
>>   	/* Register GPIO subsystem */
>>   	at91_gpio_init(at91sam9263_gpio, 5);
>> +
>> +	at91_pm_set_standby(at91sam9263_standby);
>>   }
>>
>>   /* ---------------------------------------------------------------=
-----
>> diff --git a/arch/arm/mach-at91/at91sam9g45.c
>> b/arch/arm/mach-at91/at91sam9g45.c
>> index 474ee04..4186f37 100644
>> --- a/arch/arm/mach-at91/at91sam9g45.c
>> +++ b/arch/arm/mach-at91/at91sam9g45.c
>> @@ -26,6 +26,7 @@
>>   #include "generic.h"
>>   #include "clock.h"
>>   #include "sam9_smc.h"
>> +#include "pm.h"
>>
>>   /* ---------------------------------------------------------------=
-----
>>    *  Clocks
>> @@ -355,7 +356,6 @@ static struct at91_gpio_bank at91sam9g45_gpio[]
>> __initdata =3D {
>>   /* ---------------------------------------------------------------=
-----
>>    *  AT91SAM9G45 processor initialization
>>    * ---------------------------------------------------------------=
----- */
>> -
>>   static void __init at91sam9g45_map_io(void)
>>   {
>>   	at91_init_sram(0, AT91SAM9G45_SRAM_BASE, AT91SAM9G45_SRAM_SIZE);
>> @@ -379,6 +379,8 @@ static void __init at91sam9g45_initialize(void)
>>
>>   	/* Register GPIO subsystem */
>>   	at91_gpio_init(at91sam9g45_gpio, 5);
>> +
>> +	at91_pm_set_standby(at91sam9g45_standby);
>>   }
>>
>>   /* ---------------------------------------------------------------=
-----
>> diff --git a/arch/arm/mach-at91/at91sam9n12.c
>> b/arch/arm/mach-at91/at91sam9n12.c
>> index c7d670d..cc61e09 100644
>> --- a/arch/arm/mach-at91/at91sam9n12.c
>> +++ b/arch/arm/mach-at91/at91sam9n12.c
>> @@ -21,6 +21,7 @@
>>   #include "generic.h"
>>   #include "clock.h"
>>   #include "sam9_smc.h"
>> +#include "pm.h"
>>
>>   /* ---------------------------------------------------------------=
-----
>>    *  Clocks
>> @@ -217,13 +218,18 @@ static void __init at91sam9n12_register_clocks=
(void)
>>   /* ---------------------------------------------------------------=
-----
>>    *  AT91SAM9N12 processor initialization
>>    * ---------------------------------------------------------------=
----- */
>> -
>>   static void __init at91sam9n12_map_io(void)
>>   {
>>   	at91_init_sram(0, AT91SAM9N12_SRAM_BASE, AT91SAM9N12_SRAM_SIZE);
>>   }
>>
>> +static void __init at91sam9n12_initialize(void)
>> +{
> this is wrong we use a ddr comtroller not the same as the sam9
>> +	at91_pm_set_standby(at91sam9_standby);
>> +}
>> +
>>   AT91_SOC_START(at91sam9n12)
>>   	.map_io =3D at91sam9n12_map_io,
>>   	.register_clocks =3D at91sam9n12_register_clocks,
>> +	.init =3D at91sam9n12_initialize,
>>   AT91_SOC_END
>> diff --git a/arch/arm/mach-at91/at91sam9rl.c
>> b/arch/arm/mach-at91/at91sam9rl.c
>> index d4ec0d9..b0c8cb6 100644
>> --- a/arch/arm/mach-at91/at91sam9rl.c
>> +++ b/arch/arm/mach-at91/at91sam9rl.c
>> @@ -27,6 +27,7 @@
>>   #include "generic.h"
>>   #include "clock.h"
>>   #include "sam9_smc.h"
>> +#include "pm.h"
>>
>>   /* ---------------------------------------------------------------=
-----
>>    *  Clocks
>> @@ -261,7 +262,6 @@ static struct at91_gpio_bank at91sam9rl_gpio[]
>> __initdata =3D {
>>   /* ---------------------------------------------------------------=
-----
>>    *  AT91SAM9RL processor initialization
>>    * ---------------------------------------------------------------=
----- */
>> -
>>   static void __init at91sam9rl_map_io(void)
>>   {
>>   	unsigned long sram_size;
>> @@ -296,6 +296,8 @@ static void __init at91sam9rl_initialize(void)
>>
>>   	/* Register GPIO subsystem */
>>   	at91_gpio_init(at91sam9rl_gpio, 4);
>> +
>> +	at91_pm_set_standby(at91sam9_standby);
>>   }
>>
>>   /* ---------------------------------------------------------------=
-----
>> diff --git a/arch/arm/mach-at91/at91sam9x5.c
>> b/arch/arm/mach-at91/at91sam9x5.c
>> index 916e5a1..9ef7bc6 100644
>> --- a/arch/arm/mach-at91/at91sam9x5.c
>> +++ b/arch/arm/mach-at91/at91sam9x5.c
>> @@ -21,6 +21,7 @@
>>   #include "generic.h"
>>   #include "clock.h"
>>   #include "sam9_smc.h"
>> +#include "pm.h"
>>
>>   /* ---------------------------------------------------------------=
-----
>>    *  Clocks
>> @@ -316,12 +317,15 @@ static void __init at91sam9x5_register_clocks(=
void)
>>   /* ---------------------------------------------------------------=
-----
>>    *  AT91SAM9x5 processor initialization
>>    * ---------------------------------------------------------------=
----- */
>> -
> ??
>>   static void __init at91sam9x5_map_io(void)
>>   {
>>   	at91_init_sram(0, AT91SAM9X5_SRAM_BASE, AT91SAM9X5_SRAM_SIZE);
>>   }
>>
>> +static void __init at91sam9x5_initialize(void)
>> +{
> this is wrong we use a ddr comtroller not the same as the sam9
>> +	at91_pm_set_standby(at91sam9_standby);
>> +}
>>   /* ---------------------------------------------------------------=
-----
>>    *  Interrupt initialization
>>    * ---------------------------------------------------------------=
----- */
>> @@ -329,4 +333,5 @@ static void __init at91sam9x5_map_io(void)
>>   AT91_SOC_START(at91sam9x5)
>>   	.map_io =3D at91sam9x5_map_io,
>>   	.register_clocks =3D at91sam9x5_register_clocks,
>> +	.init =3D at91sam9x5_initialize,
>>   AT91_SOC_END
>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>> index debdbf8..42b955c 100644
>> --- a/arch/arm/mach-at91/pm.c
>> +++ b/arch/arm/mach-at91/pm.c
>> @@ -318,6 +318,11 @@ static struct platform_device at91_cpuidle_devi=
ce =3D {
>>   	.name =3D "cpuidle-at91",
>>   };
>>
>> +void at91_pm_set_standby(void (*at91_standby)(void))
>> +{
>> +	at91_cpuidle_device.dev.platform_data =3D at91_standby;=09
>> +}
>> +
>>   static int __init at91_pm_init(void)
>>   {
>>   #ifdef CONFIG_AT91_SLOW_CLOCK
>> @@ -327,16 +332,8 @@ static int __init at91_pm_init(void)
>>   	pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow
>> clock mode)" : ""));
>>
>>   	/* AT91RM9200 SDRAM low-power mode cannot be used with self-refre=
sh. */
>> -	if (cpu_is_at91rm9200()) {
>> -		at91_cpuidle_device.dev.platform_data =3D at91rm9200_standby;
>> +	if (cpu_is_at91rm9200())
>>   		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
>> -	} else if (cpu_is_at91sam9g45()) {
>> -		at91_cpuidle_device.dev.platform_data =3D at91sam9g45_standby;
>> -	} else if (cpu_is_at91sam9263()) {
>> -		at91_cpuidle_device.dev.platform_data =3D at91sam9263_standby;
>> -	} else {
>> -		at91_cpuidle_device.dev.platform_data =3D at91sam9_standby;
>> -	}
>>   =09
>
> only register it if the call back is set
>>   	platform_device_register(&at91_cpuidle_device);
>>
>> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
>> index 2f5908f..76dd1a7 100644
>> --- a/arch/arm/mach-at91/pm.h
>> +++ b/arch/arm/mach-at91/pm.h
>> @@ -11,9 +11,13 @@
>>   #ifndef __ARCH_ARM_MACH_AT91_PM
>>   #define __ARCH_ARM_MACH_AT91_PM
>>
>> +#include <asm/proc-fns.h>
>> +
>>   #include <mach/at91_ramc.h>
>>   #include <mach/at91rm9200_sdramc.h>
>>
>> +extern void at91_pm_set_standby(void (*at91_standby)(void));
>> +
>>   /*
>>    * The AT91RM9200 goes into self-refresh mode with this command, a=
nd will
>>    * terminate self-refresh automatically on the next SDRAM access.
>> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5=
d3.c
>> index 4012797..9a53db6 100644
>> --- a/arch/arm/mach-at91/sama5d3.c
>> +++ b/arch/arm/mach-at91/sama5d3.c
>> @@ -21,6 +21,7 @@
>>   #include "generic.h"
>>   #include "clock.h"
>>   #include "sam9_smc.h"
>> +#include "pm.h"
>>
>>   /* ---------------------------------------------------------------=
-----
>>    *  Clocks
>> @@ -365,13 +366,18 @@ static void __init sama5d3_register_clocks(voi=
d)
>>   /* ---------------------------------------------------------------=
-----
>>    *  AT91SAM9x5 processor initialization
>>    * ---------------------------------------------------------------=
----- */
>> -
>>   static void __init sama5d3_map_io(void)
>>   {
>>   	at91_init_sram(0, SAMA5D3_SRAM_BASE, SAMA5D3_SRAM_SIZE);
>>   }
>>
>> +static void __init sama5d3_initialize(void)
>> +{
> this is wrong we use a ddr comtroller not the same as the sam9
>> +	at91_set_standby(at91sam9_standby);
>> +}
>> +
>>   AT91_SOC_START(sama5d3)
>>   	.map_io =3D sama5d3_map_io,
>>   	.register_clocks =3D sama5d3_register_clocks,
>> +	.init =3D sama5d3_initialize,
>>   AT91_SOC_END
>>
>>
>
> Best Regards,
> J.
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


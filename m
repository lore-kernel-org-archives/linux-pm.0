From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
Date: Fri, 25 Apr 2014 09:52:59 +0200
Message-ID: <535A145B.5010801@linaro.org>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org> <53594D17.6020107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56528 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbaDYHxB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 03:53:01 -0400
Received: by mail-wi0-f178.google.com with SMTP id bs8so2238864wib.17
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2014 00:53:00 -0700 (PDT)
In-Reply-To: <53594D17.6020107@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>, kgene.kim@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, ccross@google.com

On 04/24/2014 07:42 PM, Tomasz Figa wrote:
> Hi Daniel,
>
> Please see my comments inline.

Hi Tomasz,

> Btw. Please fix your e-mail composer to properly wrap your messages
> around 7xth column, as otherwise they're hard to read.

Well it is already set to the 71th column.

> On 04.04.2014 11:48, Daniel Lezcano wrote:
>> The following driver is for exynos4210. I did not yet finished the
>> other boards, so
>> I created a specific driver for 4210 which could be merged later.
>>
>> The driver is based on Colin Cross's driver found at:
>>
>> https://android.googlesource.com/kernel/exynos/+/e686b1ec67423c40b4f=
df811f9a4dfa3b393a010%5E%5E!/
>>
>>
>> This one was based on a 3.4 kernel and an old API.
>>
>> It has been refreshed, simplified and based on the recent code clean=
up
>> I sent
>> today.
>>
>> The AFTR could be entered when all the cpus (except cpu0) are down. =
In
>> order to
>> reach this situation, the couple idle states are used.
>>
>> There is a sync barrier at the entry and the exit of the low power
>> function. So
>> all cpus will enter and exit the function at the same time.
>>
>> At this point, CPU0 knows the other cpu will power down itself. CPU0
>> waits for
>> the CPU1 to be powered down and then initiate the AFTR power down
>> sequence.
>>
>> No interrupts are handled by CPU1, this is why we switch to the time=
r
>> broadcast
>> even if the local timer is not impacted by the idle state.
>>
>> When CPU0 wakes up, it powers up CPU1 and waits for it to boot. Then
>> they both
>> exit the idle function.
>>
>> This driver allows the exynos4210 to have the same power consumption
>> at idle
>> time than the one when we have to unplug CPU1 in order to let CPU0 t=
o
>> reach
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
>>   drivers/cpuidle/cpuidle-exynos4210.c |  226
>> ++++++++++++++++++++++++++++++++++
>>   4 files changed, 245 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/cpuidle/cpuidle-exynos4210.c
>>
>> diff --git a/arch/arm/mach-exynos/common.c
>> b/arch/arm/mach-exynos/common.c
>> index d5fa21e..1765a98 100644
>> --- a/arch/arm/mach-exynos/common.c
>> +++ b/arch/arm/mach-exynos/common.c
>> @@ -299,9 +299,18 @@ static struct platform_device exynos_cpuidle =3D=
 {
>>       .id                =3D -1,
>>   };
>>
>> +static struct platform_device exynos4210_cpuidle =3D {
>> +    .name              =3D "exynos4210-cpuidle",
>> +    .dev.platform_data =3D exynos_sys_powerdown_aftr,
>> +    .id                =3D -1,
>> +};
>> +
>>   void __init exynos_cpuidle_init(void)
>>   {
>> -    platform_device_register(&exynos_cpuidle);
>> +    if (soc_is_exynos4210())
>> +        platform_device_register(&exynos4210_cpuidle);
>> +    else
>> +        platform_device_register(&exynos_cpuidle);
>>   }
>>
>>   void __init exynos_cpufreq_init(void)
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.a=
rm
>> index 92f0c12..2772130 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -51,3 +51,11 @@ config ARM_EXYNOS_CPUIDLE
>>       depends on ARCH_EXYNOS
>>       help
>>         Select this to enable cpuidle for Exynos processors
>> +
>> +config ARM_EXYNOS4210_CPUIDLE
>> +    bool "Cpu Idle Driver for the Exynos 4210 processor"
>> +    default y
>> +    depends on ARCH_EXYNOS
>> +    select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>> +    help
>> +      Select this to enable cpuidle for the Exynos 4210 processors
>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> index 0d1540a..e0ec9bc 100644
>> --- a/drivers/cpuidle/Makefile
>> +++ b/drivers/cpuidle/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)        +=3D cpuidle=
-zynq.o
>>   obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux500.o
>>   obj-$(CONFIG_ARM_AT91_CPUIDLE)          +=3D cpuidle-at91.o
>>   obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        +=3D cpuidle-exynos.o
>> +obj-$(CONFIG_ARM_EXYNOS4210_CPUIDLE)    +=3D cpuidle-exynos4210.o
>>
>>
>> ####################################################################=
###########
>>
>>   # POWERPC drivers
>> diff --git a/drivers/cpuidle/cpuidle-exynos4210.c
>> b/drivers/cpuidle/cpuidle-exynos4210.c
>> new file mode 100644
>> index 0000000..56f6d51
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-exynos4210.c
>> @@ -0,0 +1,226 @@
>> +/*
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *        http://www.samsung.com
>> + *
>> + * Copyright (c) 2014 Linaro : Daniel Lezcano
>> <daniel.lezcano@linaro.org>
>> + *        http://www.linaro.org
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
>
> This won't work with multiplatform.
>
>> +
>> +static atomic_t exynos_idle_barrier;
>> +static atomic_t cpu1_wakeup =3D ATOMIC_INIT(0);
>> +
>> +#define BOOT_VECTOR S5P_VA_SYSRAM
>> +#define S5P_VA_PMU                  S3C_ADDR(0x02180000)
>> +#define S5P_PMUREG(x)              (S5P_VA_PMU + (x))
>> +#define S5P_ARM_CORE1_CONFIGURATION S5P_PMUREG(0x2080)
>> +#define S5P_ARM_CORE1_STATUS        S5P_PMUREG(0x2084)
>> +
>> +static void (*exynos_aftr)(void);
>
> Could we get rid of those global variables? I know that they won't br=
eak
> anything, but they don't look good. A driver data struct would look m=
uch
> better.

Yeah, that is part of the plan. As mentioned before I want to kill thos=
e=20
variable/macro and define a cpuidle ops structure to be filled from pm.=
c.

But I would like to have this structure to be shared across the=20
different cpuidle drivers and defined in the common arm code. The=20
structure definition will depend on the different existing drivers, so =
I=20
would like to do it in a separate patchset and keep the exynos_aftr()=20
callback for the moment.

Does your comment 'those global variables' includes=20
'exynos_idle_barrier' and 'cpu1_wakeup' ?

>> +static int cpu_suspend_finish(unsigned long flags)
>
> Name of this function could be more meaningful. Something like
> exynos_cpu_enter_lpm() could be better. Same goes for the argument.
> Maybe it could be simply called enter_aftr?

Agree, I can find something more meaningful.

>> +{
>> +    if (flags)
>> +        exynos_aftr();
>> +
>> +    cpu_do_idle();
>> +
>> +    return -1;
>> +}
>> +
>> +static int exynos_cpu0_enter_aftr(void)
>> +{
>> +    int ret =3D -1;
>
> Hmm, wouldn't a real error code be better here?

Ok, what error ? -EAGAIN ?

>> +
>> +    /*
>> +     * If the other cpu is powered on, we have to power it off, bec=
ause
>> +     * the AFTR state won't work otherwise
>> +     */
>> +    if (cpu_online(1)) {
>> +
>> +        /*
>> +         * We reach a sync point with the coupled idle state, we kn=
ow
>> +         * the other cpu will power down itself or will abort the
>> +         * sequence, let's wait for one of these to happen
>> +         */
>> +        while (__raw_readl(S5P_ARM_CORE1_STATUS) & 3) {
>
> nit: A macro could be used for 3.
>
>> +
>> +            /*
>> +             * The other cpu may skip idle and boot back
>> +             * up again
>> +             */
>> +            if (atomic_read(&cpu1_wakeup))
>> +                goto abort;
>> +
>> +            /*
>> +             * The other cpu may bounce through idle and
>> +             * boot back up again, getting stuck in the
>> +             * boot rom code
>> +             */
>> +            if (__raw_readl(BOOT_VECTOR) =3D=3D 0)
>
> Is this a reliable behavior? I mean, is this part of some specificati=
on
> or rather a feature specific to a particular Android bootloader this =
was
> used with in original kernel tree?
>
>> +                goto abort;
>> +
>> +            cpu_relax();
>> +        }
>> +    }
>> +
>> +    cpu_pm_enter();
>> +
>> +    ret =3D cpu_suspend(1, cpu_suspend_finish);
>> +
>> +    cpu_pm_exit();
>> +
>> +abort:
>> +    if (cpu_online(1)) {
>> +        /*
>> +         * Set the boot vector to something non-zero
>> +         */
>> +        __raw_writel(virt_to_phys(s3c_cpu_resume),
>> +                 BOOT_VECTOR);
>
> Resume address is quite a specific "something non-zero". :)

Ok, this is resulting from reverse engineering. I don't have the=20
documentation. If you can briefly summarize how it works that may help=20
to simplify/clarify the result.

>> +        dsb();
>
> Checkpatch would probably complain about missing comment on why dsb()=
 is
> needed here (or I'm confusing this with other barriers).

Same comment than above. I guess this barrier is needed to ensure the=20
value is effectively written to BOOT_VECTOR before shutting down the co=
re.

>> +
>> +        /*
>> +         * Turn on cpu1 and wait for it to be on
>> +         */
>> +        __raw_writel(0x3, S5P_ARM_CORE1_CONFIGURATION);
>> +        while ((__raw_readl(S5P_ARM_CORE1_STATUS) & 3) !=3D 3)
>> +            cpu_relax();
>
> nit: Here again 3 could be replaced with a macro.
>
>> +
>> +        /*
>> +         * Wait for cpu1 to get stuck in the boot rom
>> +         */
>> +        while ((__raw_readl(BOOT_VECTOR) !=3D 0) &&
>
> Same comment about the assumption about BOOT_VECTOR changing to 0 as =
above.
>
>> +               !atomic_read(&cpu1_wakeup))
>> +            cpu_relax();
>> +
>> +        if (!atomic_read(&cpu1_wakeup)) {
>> +            /*
>> +             * Poke cpu1 out of the boot rom
>> +             */
>> +            __raw_writel(virt_to_phys(s3c_cpu_resume),
>> +                     BOOT_VECTOR);
>> +            dsb_sev();
>
> Hmm, platsmp code seems to be using an IPI to do this. Again, I wonde=
r
> if this isn't a behavior implemented only in some specific Android
> bootloader.

Yeah, definitively that needs clarification.

>> +        }
>> +
>> +        /*
>> +         * Wait for cpu1 to finish booting
>> +         */
>> +        while (!atomic_read(&cpu1_wakeup))
>> +            cpu_relax();
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int exynos_powerdown_cpu1(void)
>> +{
>> +    int ret =3D -1;
>
> Error code?

Yep,

	ret =3D cpu_pm_enter();
	if (ret)
		goto cpu1_aborted;

>> +
>> +    /*
>> +     * Idle sequence for cpu1
>> +     */
>> +    if (cpu_pm_enter())
>> +        goto cpu1_aborted;
>> +
>> +    /*
>> +     * Turn off cpu 1
>> +     */
>> +    __raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
>> +
>> +    ret =3D cpu_suspend(0, cpu_suspend_finish);
>> +
>> +    cpu_pm_exit();
>> +
>> +cpu1_aborted:
>> +    dsb();
>> +    /*
>> +     * Notify cpu 0 that cpu 1 is awake
>> +     */
>> +    atomic_set(&cpu1_wakeup, 1);
>> +
>> +    return ret;
>> +}
>> +
>> +static int exynos_enter_aftr(struct cpuidle_device *dev,
>> +                 struct cpuidle_driver *drv, int index)
>> +{
>> +    int ret;
>> +
>> +    __raw_writel(virt_to_phys(s3c_cpu_resume), BOOT_VECTOR);
>
> Why this is being written here, instead of some of the low level
> functions above?
>
> Otherwise, I quite like the whole idea. I need to play a bit with CPU
> hotplug and PMU to verify that things couldn't really be simplified a
> bit, but in general this looks reasonably.

Yes, there is a nice improvement in term of power saving for dual=20
processor. If you can clarify the BOOT_VECTOR stuff that will be nice.

I have a more recent version of the driver based on samsung-next and th=
e=20
cleanups I previously sent:

https://git.linaro.org/people/daniel.lezcano/linux.git/

branch : cpuidle/samsung-next

Thanks for the review.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


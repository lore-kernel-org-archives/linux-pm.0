From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
Date: Tue, 15 Apr 2014 18:38:39 +0200
Message-ID: <534D608F.60007@linaro.org>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org> <20140415083704.212d3a0f@amdc2363> <534D4ED4.9020203@linaro.org> <20140415175432.0d73018e@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140415175432.0d73018e@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "ccross@google.com" <ccross@google.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pm@vger.kernel.org

On 04/15/2014 05:54 PM, Lukasz Majewski wrote:
> Hi Daniel,
>
>> On 04/15/2014 08:37 AM, Lukasz Majewski wrote:
>>> Hi Daniel,
>>>
>>>> The following driver is for exynos4210. I did not yet finished the
>>>> other boards, so I created a specific driver for 4210 which could
>>>> be merged later.
>>>>
>>>
>>> If I may ask - do you plan to develop this code for Exynos4412 in a
>>> near future?
>>
>> Yes it is in my plan.
>>
>>> I did some tests (with hotplug) and it turns out, that due to stati=
c
>>> leakage current one can save up to 12 % of power consumption when
>>> power domains for cores are disabled.
>>>
>>>
>>> Such notable power consumption reduction could drive (and justify)
>>> the further development of power aware scheduling code.
>>>
>>> If you don't have time, then I can offer myself to develop the
>>> code. I just want to avoid potential duplication of effort.
>>
>> I would be very glad if we can cooperate. Thanks for proposing your
>> help.
>
> You are welcome :-)
>
>>
>> I have put a branch containing the cleanups + driver moving + dual
>> cpu support, so you can base your work in it.
>>
>> git://git.linaro.org/people/daniel.lezcano/linux.git
>> cpuidle/samsung-next
>
> Thanks for sharing code. I will look into it.
>
>>
>> I am wondering if the 5250 board wouldn't make sense as a primary
>> target before the 4412...
>
> I'm working on a device based on 4412, not 5250. Therefore, I would
> prefer to have this concept implemented on 4412 as soon as possible t=
o
> not hinder my scheduler related experiments.
>
> If you have other priorities, then we can split the work. What do you
> think?

It is ok for me if you want to handle the cpuidle driver 4412. Will you=
=20
create a new driver or extend this dual cpu driver to support 4 cpus ?


>>>> The driver is based on Colin Cross's driver found at:
>>>>
>>>> https://android.googlesource.com/kernel/exynos/+/e686b1ec67423c40b=
4fdf811f9a4dfa3b393a010%5E%5E!/
>>>>
>>>> This one was based on a 3.4 kernel and an old API.
>>>>
>>>> It has been refreshed, simplified and based on the recent code
>>>> cleanup I sent today.
>>>>
>>>> The AFTR could be entered when all the cpus (except cpu0) are down=
=2E
>>>> In order to reach this situation, the couple idle states are used.
>>>>
>>>> There is a sync barrier at the entry and the exit of the low power
>>>> function. So all cpus will enter and exit the function at the same
>>>> time.
>>>>
>>>> At this point, CPU0 knows the other cpu will power down itself.
>>>> CPU0 waits for the CPU1 to be powered down and then initiate the
>>>> AFTR power down sequence.
>>>>
>>>> No interrupts are handled by CPU1, this is why we switch to the
>>>> timer broadcast even if the local timer is not impacted by the
>>>> idle state.
>>>>
>>>> When CPU0 wakes up, it powers up CPU1 and waits for it to boot.
>>>> Then they both exit the idle function.
>>>>
>>>> This driver allows the exynos4210 to have the same power
>>>> consumption at idle time than the one when we have to unplug CPU1
>>>> in order to let CPU0 to reach the AFTR state.
>>>>
>>>> This patch is a RFC because, we have to find a way to remove the
>>>> macros definitions and cpu powerdown function without pulling the
>>>> arch dependent headers.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>    arch/arm/mach-exynos/common.c        |   11 +-
>>>>    drivers/cpuidle/Kconfig.arm          |    8 ++
>>>>    drivers/cpuidle/Makefile             |    1 +
>>>>    drivers/cpuidle/cpuidle-exynos4210.c |  226
>>>> ++++++++++++++++++++++++++++++++++ 4 files changed, 245
>>>> insertions(+), 1 deletion(-) create mode 100644
>>>> drivers/cpuidle/cpuidle-exynos4210.c
>>>>
>>>> diff --git a/arch/arm/mach-exynos/common.c
>>>> b/arch/arm/mach-exynos/common.c index d5fa21e..1765a98 100644
>>>> --- a/arch/arm/mach-exynos/common.c
>>>> +++ b/arch/arm/mach-exynos/common.c
>>>> @@ -299,9 +299,18 @@ static struct platform_device exynos_cpuidle
>>>> =3D { .id                =3D -1,
>>>>    };
>>>>
>>>> +static struct platform_device exynos4210_cpuidle =3D {
>>>> +       .name              =3D "exynos4210-cpuidle",
>>>> +       .dev.platform_data =3D exynos_sys_powerdown_aftr,
>>>> +       .id                =3D -1,
>>>> +};
>>>> +
>>>>    void __init exynos_cpuidle_init(void)
>>>>    {
>>>> -       platform_device_register(&exynos_cpuidle);
>>>> +       if (soc_is_exynos4210())
>>>> +               platform_device_register(&exynos4210_cpuidle);
>>>> +       else
>>>> +               platform_device_register(&exynos_cpuidle);
>>>>    }
>>>>
>>>>    void __init exynos_cpufreq_init(void)
>>>> diff --git a/drivers/cpuidle/Kconfig.arm
>>>> b/drivers/cpuidle/Kconfig.arm index 92f0c12..2772130 100644
>>>> --- a/drivers/cpuidle/Kconfig.arm
>>>> +++ b/drivers/cpuidle/Kconfig.arm
>>>> @@ -51,3 +51,11 @@ config ARM_EXYNOS_CPUIDLE
>>>>           depends on ARCH_EXYNOS
>>>>           help
>>>>             Select this to enable cpuidle for Exynos processors
>>>> +
>>>> +config ARM_EXYNOS4210_CPUIDLE
>>>> +       bool "Cpu Idle Driver for the Exynos 4210 processor"
>>>> +       default y
>>>> +       depends on ARCH_EXYNOS
>>>> +       select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>>>> +       help
>>>> +         Select this to enable cpuidle for the Exynos 4210
>>>> processors diff --git a/drivers/cpuidle/Makefile
>>>> b/drivers/cpuidle/Makefile index 0d1540a..e0ec9bc 100644
>>>> --- a/drivers/cpuidle/Makefile
>>>> +++ b/drivers/cpuidle/Makefile
>>>> @@ -14,6 +14,7 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)                +=3D
>>>> cpuidle-zynq.o obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D
>>>> cpuidle-ux500.o obj-$(CONFIG_ARM_AT91_CPUIDLE)          +=3D
>>>> cpuidle-at91.o obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        +=3D
>>>> cpuidle-exynos.o +obj-$(CONFIG_ARM_EXYNOS4210_CPUIDLE)    +=3D
>>>> cpuidle-exynos4210.o
>>>>
>>>>    ###############################################################=
################
>>>>    # POWERPC drivers
>>>> diff --git a/drivers/cpuidle/cpuidle-exynos4210.c
>>>> b/drivers/cpuidle/cpuidle-exynos4210.c new file mode 100644
>>>> index 0000000..56f6d51
>>>> --- /dev/null
>>>> +++ b/drivers/cpuidle/cpuidle-exynos4210.c
>>>> @@ -0,0 +1,226 @@
>>>> +/*
>>>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>>>> + *             http://www.samsung.com
>>>> + *
>>>> + * Copyright (c) 2014 Linaro : Daniel Lezcano
>>>> <daniel.lezcano@linaro.org>
>>>> + *             http://www.linaro.org
>>>> + *
>>>> + * Based on the work of Colin Cross <ccross@android.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or
>>>> modify
>>>> + * it under the terms of the GNU General Public License version 2
>>>> as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#include <linux/cpuidle.h>
>>>> +#include <linux/cpu_pm.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +#include <asm/proc-fns.h>
>>>> +#include <asm/suspend.h>
>>>> +#include <asm/cpuidle.h>
>>>> +
>>>> +#include <plat/pm.h>
>>>> +#include <plat/cpu.h>
>>>> +#include <plat/map-base.h>
>>>> +#include <plat/map-s5p.h>
>>>> +
>>>> +static atomic_t exynos_idle_barrier;
>>>> +static atomic_t cpu1_wakeup =3D ATOMIC_INIT(0);
>>>> +
>>>> +#define BOOT_VECTOR S5P_VA_SYSRAM
>>>> +#define S5P_VA_PMU                  S3C_ADDR(0x02180000)
>>>> +#define S5P_PMUREG(x)              (S5P_VA_PMU + (x))
>>>> +#define S5P_ARM_CORE1_CONFIGURATION S5P_PMUREG(0x2080)
>>>> +#define S5P_ARM_CORE1_STATUS        S5P_PMUREG(0x2084)
>>>> +
>>>> +static void (*exynos_aftr)(void);
>>>> +
>>>> +static int cpu_suspend_finish(unsigned long flags)
>>>> +{
>>>> +       if (flags)
>>>> +               exynos_aftr();
>>>> +
>>>> +       cpu_do_idle();
>>>> +
>>>> +       return -1;
>>>> +}
>>>> +
>>>> +static int exynos_cpu0_enter_aftr(void)
>>>> +{
>>>> +       int ret =3D -1;
>>>> +
>>>> +       /*
>>>> +        * If the other cpu is powered on, we have to power it off=
,
>>>> because
>>>> +        * the AFTR state won't work otherwise
>>>> +        */
>>>> +       if (cpu_online(1)) {
>>>> +
>>>> +               /*
>>>> +                * We reach a sync point with the coupled idle
>>>> state, we know
>>>> +                * the other cpu will power down itself or will
>>>> abort the
>>>> +                * sequence, let's wait for one of these to happen
>>>> +                */
>>>> +               while (__raw_readl(S5P_ARM_CORE1_STATUS) & 3) {
>>>> +
>>>> +                       /*
>>>> +                        * The other cpu may skip idle and boot
>>>> back
>>>> +                        * up again
>>>> +                        */
>>>> +                       if (atomic_read(&cpu1_wakeup))
>>>> +                               goto abort;
>>>> +
>>>> +                       /*
>>>> +                        * The other cpu may bounce through idle
>>>> and
>>>> +                        * boot back up again, getting stuck in th=
e
>>>> +                        * boot rom code
>>>> +                        */
>>>> +                       if (__raw_readl(BOOT_VECTOR) =3D=3D 0)
>>>> +                               goto abort;
>>>> +
>>>> +                       cpu_relax();
>>>> +               }
>>>> +       }
>>>> +
>>>> +       cpu_pm_enter();
>>>> +
>>>> +       ret =3D cpu_suspend(1, cpu_suspend_finish);
>>>> +
>>>> +       cpu_pm_exit();
>>>> +
>>>> +abort:
>>>> +       if (cpu_online(1)) {
>>>> +               /*
>>>> +                * Set the boot vector to something non-zero
>>>> +                */
>>>> +               __raw_writel(virt_to_phys(s3c_cpu_resume),
>>>> +                            BOOT_VECTOR);
>>>> +               dsb();
>>>> +
>>>> +               /*
>>>> +                * Turn on cpu1 and wait for it to be on
>>>> +                */
>>>> +               __raw_writel(0x3, S5P_ARM_CORE1_CONFIGURATION);
>>>> +               while ((__raw_readl(S5P_ARM_CORE1_STATUS) & 3) !=3D
>>>> 3)
>>>> +                       cpu_relax();
>>>> +
>>>> +               /*
>>>> +                * Wait for cpu1 to get stuck in the boot rom
>>>> +                */
>>>> +               while ((__raw_readl(BOOT_VECTOR) !=3D 0) &&
>>>> +                      !atomic_read(&cpu1_wakeup))
>>>> +                       cpu_relax();
>>>> +
>>>> +               if (!atomic_read(&cpu1_wakeup)) {
>>>> +                       /*
>>>> +                        * Poke cpu1 out of the boot rom
>>>> +                        */
>>>> +                       __raw_writel(virt_to_phys(s3c_cpu_resume),
>>>> +                                    BOOT_VECTOR);
>>>> +                       dsb_sev();
>>>> +               }
>>>> +
>>>> +               /*
>>>> +                * Wait for cpu1 to finish booting
>>>> +                */
>>>> +               while (!atomic_read(&cpu1_wakeup))
>>>> +                       cpu_relax();
>>>> +       }
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static int exynos_powerdown_cpu1(void)
>>>> +{
>>>> +       int ret =3D -1;
>>>> +
>>>> +       /*
>>>> +        * Idle sequence for cpu1
>>>> +        */
>>>> +       if (cpu_pm_enter())
>>>> +               goto cpu1_aborted;
>>>> +
>>>> +       /*
>>>> +        * Turn off cpu 1
>>>> +        */
>>>> +       __raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
>>>> +
>>>> +       ret =3D cpu_suspend(0, cpu_suspend_finish);
>>>> +
>>>> +       cpu_pm_exit();
>>>> +
>>>> +cpu1_aborted:
>>>> +       dsb();
>>>> +       /*
>>>> +        * Notify cpu 0 that cpu 1 is awake
>>>> +        */
>>>> +       atomic_set(&cpu1_wakeup, 1);
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static int exynos_enter_aftr(struct cpuidle_device *dev,
>>>> +                            struct cpuidle_driver *drv, int index=
)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       __raw_writel(virt_to_phys(s3c_cpu_resume), BOOT_VECTOR);
>>>> +
>>>> +       /*
>>>> +        * Waiting all cpus to reach this point at the same moment
>>>> +        */
>>>> +       cpuidle_coupled_parallel_barrier(dev,
>>>> &exynos_idle_barrier); +
>>>> +       /*
>>>> +        * Both cpus will reach this point at the same time
>>>> +        */
>>>> +       ret =3D dev->cpu ? exynos_powerdown_cpu1() :
>>>> exynos_cpu0_enter_aftr();
>>>> +       if (ret)
>>>> +               index =3D ret;
>>>> +
>>>> +       /*
>>>> +        * Waiting all cpus to finish the power sequence before
>>>> going further
>>>> +        */
>>>> +       cpuidle_coupled_parallel_barrier(dev,
>>>> &exynos_idle_barrier); +
>>>> +       atomic_set(&cpu1_wakeup, 0);
>>>> +
>>>> +       return index;
>>>> +}
>>>> +
>>>> +static struct cpuidle_driver exynos_idle_driver =3D {
>>>> +       .name           =3D "exynos4210_idle",
>>>> +       .owner          =3D THIS_MODULE,
>>>> +       .states =3D {
>>>> +               ARM_CPUIDLE_WFI_STATE,
>>>> +               [1] =3D {
>>>> +                       .enter                  =3D
>>>> exynos_enter_aftr,
>>>> +                       .exit_latency           =3D 5000,
>>>> +                       .target_residency       =3D 10000,
>>>> +                       .flags                  =3D
>>>> CPUIDLE_FLAG_TIME_VALID |
>>>> +                       CPUIDLE_FLAG_COUPLED |
>>>> CPUIDLE_FLAG_TIMER_STOP,
>>>> +                       .name                   =3D "C1",
>>>> +                       .desc                   =3D "ARM power dow=
n",
>>>> +               },
>>>> +       },
>>>> +       .state_count =3D 2,
>>>> +       .safe_state_index =3D 0,
>>>> +};
>>>> +
>>>> +static int exynos_cpuidle_probe(struct platform_device *pdev)
>>>> +{
>>>> +       exynos_aftr =3D (void *)(pdev->dev.platform_data);
>>>> +
>>>> +       return cpuidle_register(&exynos_idle_driver,
>>>> cpu_possible_mask); +}
>>>> +
>>>> +static struct platform_driver exynos_cpuidle_driver =3D {
>>>> +       .driver =3D {
>>>> +               .name =3D "exynos4210-cpuidle",
>>>> +               .owner =3D THIS_MODULE,
>>>> +       },
>>>> +       .probe =3D exynos_cpuidle_probe,
>>>> +};
>>>> +
>>>> +module_platform_driver(exynos_cpuidle_driver);
>>>> --
>>>> 1.7.9.5
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>>
>>>
>>
>>
>
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

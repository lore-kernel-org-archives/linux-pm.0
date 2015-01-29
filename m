From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH v3 2/2] cpuidle: exynos: add coupled cpuidle support for
 Exynos4210
Date: Fri, 30 Jan 2015 08:38:01 +0900
Message-ID: <54CAC459.4010002@kernel.org>
References: <1422030294-20925-1-git-send-email-b.zolnierkie@samsung.com> <1422030294-20925-3-git-send-email-b.zolnierkie@samsung.com> <1422260208.4131.8.camel@AMDC1943> <2952015.VHEX8XYZy5@amdc1032> <1422273188.30150.2.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422273188.30150.2.camel@AMDC1943>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/26/15 20:53, Krzysztof Kozlowski wrote:
> On pon, 2015-01-26 at 12:33 +0100, Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>>
>> On Monday, January 26, 2015 09:16:48 AM Krzysztof Kozlowski wrote:
>>> On pi=C4=85, 2015-01-23 at 17:24 +0100, Bartlomiej Zolnierkiewicz w=
rote:
>>>> The following patch adds coupled cpuidle support for Exynos4210 to
>>>> an existing cpuidle-exynos driver.  As a result it enables AFTR mo=
de
>>>> to be used by default on Exynos4210 without the need to hot unplug
>>>> CPU1 first.
>>>>
>>>> The patch is heavily based on earlier cpuidle-exynos4210 driver fr=
om
>>>> Daniel Lezcano:
>>>>
>>>> http://www.spinics.net/lists/linux-samsung-soc/msg28134.html
>>>>
>>>> Changes from Daniel's code include:
>>>> - porting code to current kernels
>>>> - fixing it to work on my setup (by using S5P_INFORM register
>>>>   instead of S5P_VA_SYSRAM one on Revison 1.1 and retrying poking
>>>>   CPU1 out of the BOOT ROM if necessary)
>>>> - fixing rare lockup caused by waiting for CPU1 to get stuck in
>>>>   the BOOT ROM (CPU hotplug code in arch/arm/mach-exynos/platsmp.c
>>>>   doesn't require this and works fine)
>>>> - moving Exynos specific code to arch/arm/mach-exynos/pm.c
>>>> - using cpu_boot_reg_base() helper instead of BOOT_VECTOR macro
>>>> - using exynos_cpu_*() helpers instead of accessing registers
>>>>   directly
>>>> - using arch_send_wakeup_ipi_mask() instead of dsb_sev()
>>>>   (this matches CPU hotplug code in arch/arm/mach-exynos/platsmp.c=
)
>>>> - integrating separate exynos4210-cpuidle driver into existing
>>>>   exynos-cpuidle one
>>>>
>>>> Cc: Colin Cross <ccross@google.com>
>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com=
>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>
>>> I've seen the patch during internal review and now looks good... ex=
cept
>>> minor issues below.
>>>
>>>> ---
>>>>  arch/arm/mach-exynos/common.h                |   4 +
>>>>  arch/arm/mach-exynos/exynos.c                |   4 +
>>>>  arch/arm/mach-exynos/platsmp.c               |   2 +-
>>>>  arch/arm/mach-exynos/pm.c                    | 122 ++++++++++++++=
+++++++++++++
>>>>  drivers/cpuidle/Kconfig.arm                  |   1 +
>>>>  drivers/cpuidle/cpuidle-exynos.c             |  76 ++++++++++++++=
+--
>>>>  include/linux/platform_data/cpuidle-exynos.h |  20 +++++
>>>>  7 files changed, 223 insertions(+), 6 deletions(-)
>>>>  create mode 100644 include/linux/platform_data/cpuidle-exynos.h
>>>>
>>>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/=
common.h
>>>> index 865f878..f70eca7 100644
>>>> --- a/arch/arm/mach-exynos/common.h
>>>> +++ b/arch/arm/mach-exynos/common.h
>>>> @@ -13,6 +13,7 @@
>>>>  #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
>>>> =20
>>>>  #include <linux/of.h>
>>>> +#include <linux/platform_data/cpuidle-exynos.h>
>>>> =20
>>>>  #define EXYNOS3250_SOC_ID	0xE3472000
>>>>  #define EXYNOS3_SOC_MASK	0xFFFFF000
>>>> @@ -150,8 +151,11 @@ extern void exynos_pm_central_suspend(void);
>>>>  extern int exynos_pm_central_resume(void);
>>>>  extern void exynos_enter_aftr(void);
>>>> =20
>>>> +extern struct cpuidle_exynos_data cpuidle_coupled_exynos_data;
>>>> +
>>>>  extern void s5p_init_cpu(void __iomem *cpuid_addr);
>>>>  extern unsigned int samsung_rev(void);
>>>> +extern void __iomem *cpu_boot_reg_base(void);
>>>> =20
>>>>  static inline void pmu_raw_writel(u32 val, u32 offset)
>>>>  {
>>>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/=
exynos.c
>>>> index 78eca99b..2013f73 100644
>>>> --- a/arch/arm/mach-exynos/exynos.c
>>>> +++ b/arch/arm/mach-exynos/exynos.c
>>>> @@ -211,6 +211,10 @@ static void __init exynos_dt_machine_init(voi=
d)
>>>>  	if (!IS_ENABLED(CONFIG_SMP))
>>>>  		exynos_sysram_init();
>>>> =20
>>>> +#ifdef CONFIG_ARM_EXYNOS_CPUIDLE
>>>> +	if (of_machine_is_compatible("samsung,exynos4210"))
>>>> +		exynos_cpuidle.dev.platform_data =3D &cpuidle_coupled_exynos_da=
ta;
>>>> +#endif
>>>>  	if (of_machine_is_compatible("samsung,exynos4210") ||
>>>>  	    of_machine_is_compatible("samsung,exynos4212") ||
>>>>  	    (of_machine_is_compatible("samsung,exynos4412") &&
>>>> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos=
/platsmp.c
>>>> index 7a1ebfe..3f32c47 100644
>>>> --- a/arch/arm/mach-exynos/platsmp.c
>>>> +++ b/arch/arm/mach-exynos/platsmp.c
>>>> @@ -194,7 +194,7 @@ int exynos_cluster_power_state(int cluster)
>>>>  		S5P_CORE_LOCAL_PWR_EN);
>>>>  }
>>>> =20
>>>> -static inline void __iomem *cpu_boot_reg_base(void)
>>>> +void __iomem *cpu_boot_reg_base(void)
>>>>  {
>>>>  	if (soc_is_exynos4210() && samsung_rev() =3D=3D EXYNOS4210_REV_1=
_1)
>>>>  		return pmu_base_addr + S5P_INFORM5;
>>>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>>>> index 1a7454d..e6209da 100644
>>>> --- a/arch/arm/mach-exynos/pm.c
>>>> +++ b/arch/arm/mach-exynos/pm.c
>>>> @@ -180,3 +180,125 @@ void exynos_enter_aftr(void)
>>>> =20
>>>>  	cpu_pm_exit();
>>>>  }
>>>> +
>>>> +static atomic_t cpu1_wakeup =3D ATOMIC_INIT(0);
>>>> +
>>>> +static int exynos_cpu0_enter_aftr(void)
>>>> +{
>>>> +	int ret =3D -1;
>>>> +
>>>> +	/*
>>>> +	 * If the other cpu is powered on, we have to power it off, beca=
use
>>>> +	 * the AFTR state won't work otherwise
>>>> +	 */
>>>> +	if (cpu_online(1)) {
>>>> +		/*
>>>> +		 * We reach a sync point with the coupled idle state, we know
>>>> +		 * the other cpu will power down itself or will abort the
>>>> +		 * sequence, let's wait for one of these to happen
>>>> +		 */
>>>> +		while (exynos_cpu_power_state(1)) {
>>>> +			/*
>>>> +			 * The other cpu may skip idle and boot back
>>>> +			 * up again
>>>> +			 */
>>>> +			if (atomic_read(&cpu1_wakeup))
>>>> +				goto abort;
>>>> +
>>>> +			/*
>>>> +			 * The other cpu may bounce through idle and
>>>> +			 * boot back up again, getting stuck in the
>>>> +			 * boot rom code
>>>> +			 */
>>>> +			if (__raw_readl(cpu_boot_reg_base()) =3D=3D 0)
>>>> +				goto abort;
>>>> +
>>>> +			cpu_relax();
>>>> +		}
>>>> +	}
>>>> +
>>>> +	exynos_enter_aftr();
>>>> +	ret =3D 0;
>>>> +
>>>> +abort:
>>>> +	if (cpu_online(1)) {
>>>> +		/*
>>>> +		 * Set the boot vector to something non-zero
>>>> +		 */
>>>> +		__raw_writel(virt_to_phys(exynos_cpu_resume),
>>>> +			     cpu_boot_reg_base());
>>>> +		dsb();
>>>> +
>>>> +		/*
>>>> +		 * Turn on cpu1 and wait for it to be on
>>>> +		 */
>>>> +		exynos_cpu_power_up(1);
>>>> +		while (exynos_cpu_power_state(1) !=3D S5P_CORE_LOCAL_PWR_EN)
>>>> +			cpu_relax();
>>>> +
>>>> +		while (!atomic_read(&cpu1_wakeup)) {
>>>> +			/*
>>>> +			 * Poke cpu1 out of the boot rom
>>>> +			 */
>>>> +			__raw_writel(virt_to_phys(exynos_cpu_resume),
>>>> +				     cpu_boot_reg_base());
>>>> +
>>>> +			arch_send_wakeup_ipi_mask(cpumask_of(1));
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int exynos_wfi_finisher(unsigned long flags)
>>>> +{
>>>> +	cpu_do_idle();
>>>> +
>>>> +	return -1;
>>>> +}
>>>> +
>>>> +static int exynos_cpu1_powerdown(void)
>>>> +{
>>>> +	int ret =3D -1;
>>>> +
>>>> +	/*
>>>> +	 * Idle sequence for cpu1
>>>> +	 */
>>>> +	if (cpu_pm_enter())
>>>> +		goto cpu1_aborted;
>>>> +
>>>> +	/*
>>>> +	 * Turn off cpu 1
>>>> +	 */
>>>> +	exynos_cpu_power_down(1);
>>>> +
>>>> +	ret =3D cpu_suspend(0, exynos_wfi_finisher);
>>>> +
>>>> +	cpu_pm_exit();
>>>> +
>>>> +cpu1_aborted:
>>>> +	dsb();
>>>> +	/*
>>>> +	 * Notify cpu 0 that cpu 1 is awake
>>>> +	 */
>>>> +	atomic_set(&cpu1_wakeup, 1);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void exynos_pre_enter_aftr(void)
>>>> +{
>>>> +	__raw_writel(virt_to_phys(exynos_cpu_resume), cpu_boot_reg_base(=
));
>>>> +}
>>>> +
>>>> +static void exynos_post_enter_aftr(void)
>>>> +{
>>>> +	atomic_set(&cpu1_wakeup, 0);
>>>> +}
>>>> +
>>>> +struct cpuidle_exynos_data cpuidle_coupled_exynos_data =3D {
>>>> +	.cpu0_enter_aftr		=3D exynos_cpu0_enter_aftr,
>>>> +	.cpu1_powerdown		=3D exynos_cpu1_powerdown,
>>>> +	.pre_enter_aftr		=3D exynos_pre_enter_aftr,
>>>> +	.post_enter_aftr		=3D exynos_post_enter_aftr,
>>>> +};
>>>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig=
=2Earm
>>>> index 8c16ab2..8e07c94 100644
>>>> --- a/drivers/cpuidle/Kconfig.arm
>>>> +++ b/drivers/cpuidle/Kconfig.arm
>>>> @@ -55,6 +55,7 @@ config ARM_AT91_CPUIDLE
>>>>  config ARM_EXYNOS_CPUIDLE
>>>>  	bool "Cpu Idle Driver for the Exynos processors"
>>>>  	depends on ARCH_EXYNOS
>>>> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>>>>  	help
>>>>  	  Select this to enable cpuidle for Exynos processors
>>>> =20
>>>> diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cp=
uidle-exynos.c
>>>> index 4003a31..26f5f29 100644
>>>> --- a/drivers/cpuidle/cpuidle-exynos.c
>>>> +++ b/drivers/cpuidle/cpuidle-exynos.c
>>>> @@ -1,8 +1,11 @@
>>>> -/* linux/arch/arm/mach-exynos/cpuidle.c
>>>> - *
>>>> - * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>>>> +/*
>>>> + * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
>>>>   *		http://www.samsung.com
>>>>   *
>>>> + * Coupled cpuidle support based on the work of:
>>>> + *	Colin Cross <ccross@android.com>
>>>> + *	Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> + *
>>>>   * This program is free software; you can redistribute it and/or =
modify
>>>>   * it under the terms of the GNU General Public License version 2=
 as
>>>>   * published by the Free Software Foundation.
>>>> @@ -13,13 +16,49 @@
>>>>  #include <linux/export.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/platform_device.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/platform_data/cpuidle-exynos.h>
>>>> =20
>>>>  #include <asm/proc-fns.h>
>>>>  #include <asm/suspend.h>
>>>>  #include <asm/cpuidle.h>
>>>> =20
>>>> +static atomic_t exynos_idle_barrier;
>>>> +
>>>> +static struct cpuidle_exynos_data *exynos_cpuidle_pdata;
>>>>  static void (*exynos_enter_aftr)(void);
>>>> =20
>>>> +static int exynos_enter_coupled_lowpower(struct cpuidle_device *d=
ev,
>>>> +					 struct cpuidle_driver *drv,
>>>> +					 int index)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	exynos_cpuidle_pdata->pre_enter_aftr();
>>>> +
>>>> +	/*
>>>> +	 * Waiting all cpus to reach this point at the same moment
>>>> +	 */
>>>> +	cpuidle_coupled_parallel_barrier(dev, &exynos_idle_barrier);
>>>> +
>>>> +	/*
>>>> +	 * Both cpus will reach this point at the same time
>>>> +	 */
>>>> +	ret =3D dev->cpu ? exynos_cpuidle_pdata->cpu1_powerdown()
>>>> +		       : exynos_cpuidle_pdata->cpu0_enter_aftr();
>>>> +	if (ret)
>>>> +		index =3D ret;
>>>> +
>>>> +	/*
>>>> +	 * Waiting all cpus to finish the power sequence before going fu=
rther
>>>> +	 */
>>>> +	cpuidle_coupled_parallel_barrier(dev, &exynos_idle_barrier);
>>>> +
>>>> +	exynos_cpuidle_pdata->post_enter_aftr();
>>>> +
>>>> +	return index;
>>>> +}
>>>> +
>>>>  static int exynos_enter_lowpower(struct cpuidle_device *dev,
>>>>  				struct cpuidle_driver *drv,
>>>>  				int index)
>>>> @@ -55,13 +94,40 @@ static struct cpuidle_driver exynos_idle_drive=
r =3D {
>>>>  	.safe_state_index =3D 0,
>>>>  };
>>>> =20
>>>> +static struct cpuidle_driver exynos_coupled_idle_driver =3D {
>>>> +	.name			=3D "exynos_coupled_idle",
>>>> +	.owner			=3D THIS_MODULE,
>>>> +	.states =3D {
>>>> +		[0] =3D ARM_CPUIDLE_WFI_STATE,
>>>> +		[1] =3D {
>>>> +			.enter			=3D exynos_enter_coupled_lowpower,
>>>> +			.exit_latency		=3D 5000,
>>>> +			.target_residency	=3D 10000,
>>>
>>> Have you measured these numbers? Existing cpuidle has residency of
>>> 100000.
>>
>> These numbers are from the original driver by Daniel.  If needed the=
y
>> can be changed later.
>>
>>>> +			.flags			=3D CPUIDLE_FLAG_COUPLED |
>>>> +						  CPUIDLE_FLAG_TIMER_STOP,
>>>> +			.name			=3D "C1",
>>>> +			.desc			=3D "ARM power down",
>>>> +		},
>>>> +	},
>>>> +	.state_count =3D 2,
>>>> +	.safe_state_index =3D 0,
>>>> +};
>>>> +
>>>>  static int exynos_cpuidle_probe(struct platform_device *pdev)
>>>>  {
>>>>  	int ret;
>>>> =20
>>>> -	exynos_enter_aftr =3D (void *)(pdev->dev.platform_data);
>>>> +	if (of_machine_is_compatible("samsung,exynos4210")) {
>>>> +		exynos_cpuidle_pdata =3D pdev->dev.platform_data;
>>>> +
>>>> +		ret =3D cpuidle_register(&exynos_coupled_idle_driver,
>>>> +				       cpu_possible_mask);
>>>> +	} else {
>>>> +		exynos_enter_aftr =3D (void *)(pdev->dev.platform_data);
>>>> +
>>>> +		ret =3D cpuidle_register(&exynos_idle_driver, NULL);
>>>> +	}
>>>> =20
>>>> -	ret =3D cpuidle_register(&exynos_idle_driver, NULL);
>>>>  	if (ret) {
>>>>  		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
>>>>  		return ret;
>>>> diff --git a/include/linux/platform_data/cpuidle-exynos.h b/includ=
e/linux/platform_data/cpuidle-exynos.h
>>>> new file mode 100644
>>>> index 0000000..bfa40e4
>>>> --- /dev/null
>>>> +++ b/include/linux/platform_data/cpuidle-exynos.h
>>>> @@ -0,0 +1,20 @@
>>>> +/*
>>>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>>>> + *              http://www.samsung.com
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or =
modify
>>>> + * it under the terms of the GNU General Public License version 2=
 as
>>>> + * published by the Free Software Foundation.
>>>> +*/
>>>> +
>>>> +#ifndef __CPUIDLE_EXYNOS_H
>>>> +#define __CPUIDLE_EXYNOS_H
>>>> +
>>>> +struct cpuidle_exynos_data {
>>>> +	int (*cpu0_enter_aftr)(void);
>>>> +	int (*cpu1_powerdown)(void);
>>>> +	void (*pre_enter_aftr)(void);
>>>> +	void (*post_enter_aftr)(void);
>>>
>>> I don't like the names of pre/post_enter_aftr. They are called also=
 on
>>> CPU1 for powerdown. Probably they will be also called for CPU0 to e=
nter
>>
>> powerdown on CPU1 is a part of preparations for system to go into AF=
TR
>> state.
>>
>>> LPA/LPD/W-AFTR.
>>>
>>> Maybe "pre/post_enter_lowpower"?
>>
>> I agree but it can be changed later when LPA/LPD/W-AFTR support is a=
dded.
>=20
> Sure.
>=20
>>
>>> Additionally could you add short comment for them (like when they a=
re
>>> called and on which CPU). It is not exynos internal header so one m=
ay
>>> not be sure that the raw code is actual documentation for this.
>>
>> It is an Exynos internal header, no generic code uses it.  It is a g=
ood
>> idea to enhance documentation but lets leave the code as it is for v=
3.20
>> and update it in the future changes.
>=20
> OK, I'm fine with that. I saw that Kukjin applied these patches so
> actually I don't oppose them. As I said it was rather nit-picking fro=
m
> my side.
>=20
Thanks, Krzysztof. And we can enhance this stuff next time, soon.

I've applied and merged into for-next just now.

- Kukjin

From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 2/2] cpuidle: Exynos: fix cpuidle for all states
Date: Tue, 15 Jul 2014 19:41:04 +0200
Message-ID: <53C567B0.6020009@samsung.com>
References: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
 <1404225158-8453-3-git-send-email-k.chander@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1404225158-8453-3-git-send-email-k.chander@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <k.chander@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: daniel.lezcano@linaro.org, kgene.kim@samsung.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Chander,

Please see my comments inline.

On 01.07.2014 16:32, Chander Kashyap wrote:
> Pre/post platform specific cpuidle operations are handled by pm_notifier.
> But these operations are not same for all cpuidle states. Handle this by
> moving cpuidle specific code from pm_notifier to cpuidle specific function.
> 
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h    |    2 +-
>  arch/arm/mach-exynos/pm.c        |   45 ++++++++++----------------------------
>  drivers/cpuidle/cpuidle-exynos.c |    7 ++++--
>  3 files changed, 17 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 1ee9176..7769f58 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -166,7 +166,7 @@ extern int  exynos_cpu_power_state(int cpu);
>  extern void exynos_cluster_power_down(int cluster);
>  extern void exynos_cluster_power_up(int cluster);
>  extern int  exynos_cluster_power_state(int cluster);
> -extern void exynos_enter_aftr(void);
> +extern void exynos_enter_aftr(int entering_idle);
>  
>  extern void s5p_init_cpu(void __iomem *cpuid_addr);
>  extern unsigned int samsung_rev(void);
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index a092cc3..328644f 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -188,14 +188,6 @@ static void exynos_cpu_set_boot_vector(long flags)
>  	__raw_writel(flags, EXYNOS_BOOT_VECTOR_FLAG);
>  }
>  
> -void exynos_enter_aftr(void)
> -{
> -	exynos_set_wakeupmask(0x0000ff3e);
> -	exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
> -	/* Set value of power down register for aftr mode */
> -	exynos_sys_powerdown_conf(SYS_AFTR);
> -}
> -
>  static int exynos_cpu_suspend(unsigned long arg)
>  {
>  #ifdef CONFIG_CACHE_L2X0
> @@ -386,40 +378,25 @@ static const struct platform_suspend_ops exynos_suspend_ops = {
>  	.valid		= suspend_valid_only_mem,
>  };
>  
> -static int exynos_cpu_pm_notifier(struct notifier_block *self,
> -				  unsigned long cmd, void *v)
> +void exynos_enter_aftr(int entering_idle)
>  {
> -	int cpu = smp_processor_id();
> -
> -	switch (cmd) {
> -	case CPU_PM_ENTER:
> -		if (cpu == 0)
> -			exynos_pm_central_suspend();
> -		break;
> -
> -	case CPU_PM_EXIT:
> -		if (cpu == 0) {
> -			if (read_cpuid_part_number() ==
> -					ARM_CPU_PART_CORTEX_A9)
> -				scu_enable(S5P_VA_SCU);
> -			exynos_pm_central_resume();
> -		}
> -		break;
> +	if (entering_idle) {
> +		exynos_set_wakeupmask(0x0000ff3e);
> +		exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
> +		/* Set value of power down register for aftr mode */
> +		exynos_sys_powerdown_conf(SYS_AFTR);
> +		exynos_pm_central_suspend();
> +	} else {
> +		if (scu_a9_has_base())
> +			scu_enable(S5P_VA_SCU);
> +		exynos_pm_central_resume();

Hmm. This is not very readable. Basically you have two functions that do
completely different things packed into one function. I would suggest
moving the calls to cpu_pm_enter/exit() and everything in between to
this function then you wouldn't need anything like this and the whole
low level logic would be in one place.

>  	}
> -
> -	return NOTIFY_OK;
>  }
>  
> -static struct notifier_block exynos_cpu_pm_notifier_block = {
> -	.notifier_call = exynos_cpu_pm_notifier,
> -};
> -
>  void __init exynos_pm_init(void)
>  {
>  	u32 tmp;
>  
> -	cpu_pm_register_notifier(&exynos_cpu_pm_notifier_block);
> -
>  	/* Platform-specific GIC callback */
>  	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
>  
> diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
> index 7c01512..1196ca7 100644
> --- a/drivers/cpuidle/cpuidle-exynos.c
> +++ b/drivers/cpuidle/cpuidle-exynos.c
> @@ -18,11 +18,10 @@
>  #include <asm/suspend.h>
>  #include <asm/cpuidle.h>
>  
> -static void (*exynos_enter_aftr)(void);
> +static void (*exynos_enter_aftr)(int);
>  
>  static int idle_finisher(unsigned long flags)
>  {
> -	exynos_enter_aftr();
>  	cpu_do_idle();
>  
>  	return 1;
> @@ -32,8 +31,12 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv,
>  				int index)
>  {
> +	int entering_idle = true;
>  	cpu_pm_enter();
> +	exynos_enter_aftr(entering_idle);
>  	cpu_suspend(0, idle_finisher);
> +	entering_idle = false;
> +	exynos_enter_aftr(entering_idle);

This doesn't look good. Couldn't you just have called it with constant
arguments? E.g.

	exynos_enter_aftr(true);
	[...]
	exynos_enter_aftr(false);

Well, sorry for late comments, I have missed this series, probably
because I'm not on Cc list. Anyway, since this patch will need to be
respun anyway, maybe it would be better to use the one I just posted
today, which IMHO is a bit cleaner.

Best regards,
Tomasz

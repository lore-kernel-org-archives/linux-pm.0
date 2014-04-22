From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] mcpm: exynos: populate suspend and powered_up callbacks
Date: Tue, 22 Apr 2014 12:51:06 +0200
Message-ID: <5356499A.20609@linaro.org>
References: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org> <1398080958-21677-5-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1398080958-21677-5-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <k.chander@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 04/21/2014 01:49 PM, Chander Kashyap wrote:
> In order to support cpuidle through mcpm, suspend and powered-up
> callbacks are required in mcpm platform code.
> Hence populate the same callbacks.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> ---
>   arch/arm/mach-exynos/mcpm-exynos.c |   53 +++++++++++++++++++++++++=
+++++++++++
>   1 file changed, 53 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exyno=
s/mcpm-exynos.c
> index 46d4968..16af0bd 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -318,10 +318,63 @@ static int exynos_power_down_finish(unsigned in=
t cpu, unsigned int cluster)
>   	return 0; /* success: the CPU is halted */
>   }
>
> +static void enable_coherency(void)
> +{
> +	unsigned long v, u;
> +
> +	asm volatile(
> +		"mrc	p15, 0, %0, c1, c0, 1\n"
> +		"orr	%0, %0, %2\n"
> +		"ldr	%1, [%3]\n"
> +		"and	%1, %1, #0\n"
> +		"orr	%0, %0, %1\n"
> +		"mcr	p15, 0, %0, c1, c0, 1\n"
> +		: "=3D&r" (v), "=3D&r" (u)
> +		: "Ir" (0x40), "Ir" (S5P_INFORM0)
> +		: "cc");
> +}

Shouldn't this function to be used from hotplug.c also ?

> +
> +void exynos_powered_up(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +
> +	mpidr =3D read_cpuid_mpidr();
> +	cpu =3D MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster =3D MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	arch_spin_lock(&bl_lock);
> +	if (cpu_use_count[cpu][cluster] =3D=3D 0)
> +		cpu_use_count[cpu][cluster] =3D 1;
> +	arch_spin_unlock(&bl_lock);
> +}
> +
> +static void exynos_suspend(u64 residency)
> +{
> +	unsigned int mpidr, cpunr;
> +
> +	mpidr =3D read_cpuid_mpidr();
> +	cpunr =3D enynos_pmu_cpunr(mpidr);

*enynos*_pmu_cpunr ?

> +
> +	__raw_writel(virt_to_phys(mcpm_entry_point), REG_ENTRY_ADDR);
> +
> +	exynos_power_down();
> +
> +	/*
> +	 * Execution reaches here only if cpu did not power down.
> +	 * Hence roll back the changes done in exynos_power_down function.
> +	*/
> +	__raw_writel(EXYNOS_CORE_LOCAL_PWR_EN,
> +			EXYNOS_ARM_CORE_CONFIGURATION(cpunr));

Why don't you use the functions defined in the

patch 5/5 arm: exynos: Add MCPM call-back functions

exynos_core_power_control() ?

> +	set_cr(get_cr() | CR_C);
> +	enable_coherency();
> +}
> +
>   static const struct mcpm_platform_ops exynos_power_ops =3D {
>   	.power_up		=3D exynos_power_up,
>   	.power_down		=3D exynos_power_down,
>   	.power_down_finish	=3D exynos_power_down_finish,
> +	.suspend		=3D exynos_suspend,
> +	.powered_up		=3D exynos_powered_up,
>   };
>
>   static void __init exynos_mcpm_usage_count_init(void)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

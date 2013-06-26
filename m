From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Wed, 26 Jun 2013 12:36:12 +0200
Message-ID: <51CAC41C.1010900@linaro.org>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com> <1372241627-22695-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1372241627-22695-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, amit.kachhap@linaro.org, t.figa@samsung.com, rjw@sisk.pl, kyungmin.park@samsung.com
List-Id: linux-pm@vger.kernel.org

On 06/26/2013 12:13 PM, Bartlomiej Zolnierkiewicz wrote:
> AFTR mode support was introduced by commit 67173ca ("ARM: EXYNOS: Add
> support AFTR mode on EXYNOS4210") in v3.4 kernel.  Unfortunately even
> in v3.4 kernel it hasn't worked as supposed and this is still the cas=
e
> with v3.10-rc6 (it probably wasn't noticed because CONFIG_CPU_IDLE is
> not turned on by default):
>=20
> - on revision 0 of Exynos4210 (Universal C210 board) it causes lockup
>   (on this revision only one core is usable so entry to AFTR mode is
>   always attempted because the code tries to go into AFTR mode when a=
ll
>   other CPUs except CPU0 are offlined)
>=20
> - on revision 1.1 of Exynos4210 (Trats board) it causes a lockup when
>   CPU1 is offlined (i.e. echo 0 > /sys/devices/system/cpu/cpu1/online=
)
>=20
> - on later Exynos4/5 SoCs wrong registers may be accessed when all CP=
Us
>   except CPU0 are offlined resulting in panic/lockup (REG_DIRECTGO_AD=
DR
>   and REG_DIRECTGO_FLAG register selections was implemented only for
>   Exynos4210)
>=20
> Just remove AFTR mode support for now.

Ok, I will jump on the opportunity to talk about this state.

1. I tried different ways to make the AFTR state to be entered with
*both* cpu online. It goes successfully to this state. The CPU0 is
correctly woken up but the CPU1 is never woken up, why is it happening =
?

https://bugs.launchpad.net/linaro-landing-team-samsung/+bug/1171518

2. The CPU1 hotplug bug should been fixed and if I am not wrong there i=
s
a patch somewhere fixing this.

https://bugs.launchpad.net/linaro-power-kernel/+bug/1171382

3. What is the fix for Exynos5 ?

https://bugs.launchpad.net/linaro-power-kernel/+bug/1171253

It sounds like depending on Hypervisor mode is enabled or not, the AFTR
does not work correctly.

In other words, instead of removing the AFTR state I suggest to fix it:
both core being online, split driver for exynos4 and 5.

Thanks
  -- Daniel

> Cc: Jaecheol Lee <jc.lee@samsung.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/cpuidle.c | 131 +------------------------------=
----------
>  1 file changed, 1 insertion(+), 130 deletions(-)
>=20
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cp=
uidle.c
> index 17a18ff..0a657ac 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -17,30 +17,11 @@
>  #include <linux/time.h>
> =20
>  #include <asm/proc-fns.h>
> -#include <asm/smp_scu.h>
> -#include <asm/suspend.h>
> -#include <asm/unified.h>
>  #include <asm/cpuidle.h>
>  #include <mach/regs-clock.h>
> -#include <mach/regs-pmu.h>
> -
> -#include <plat/cpu.h>
> =20
>  #include "common.h"
> =20
> -#define REG_DIRECTGO_ADDR	(samsung_rev() =3D=3D EXYNOS4210_REV_1_1 ?=
 \
> -			S5P_INFORM7 : (samsung_rev() =3D=3D EXYNOS4210_REV_1_0 ? \
> -			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
> -#define REG_DIRECTGO_FLAG	(samsung_rev() =3D=3D EXYNOS4210_REV_1_1 ?=
 \
> -			S5P_INFORM6 : (samsung_rev() =3D=3D EXYNOS4210_REV_1_0 ? \
> -			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
> -
> -#define S5P_CHECK_AFTR		0xFCBA0D10
> -
> -static int exynos4_enter_lowpower(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv,
> -				int index);
> -
>  static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device)=
;
> =20
>  static struct cpuidle_driver exynos4_idle_driver =3D {
> @@ -48,117 +29,11 @@ static struct cpuidle_driver exynos4_idle_driver=
 =3D {
>  	.owner			=3D THIS_MODULE,
>  	.states =3D {
>  		[0] =3D ARM_CPUIDLE_WFI_STATE,
> -		[1] =3D {
> -			.enter			=3D exynos4_enter_lowpower,
> -			.exit_latency		=3D 300,
> -			.target_residency	=3D 100000,
> -			.flags			=3D CPUIDLE_FLAG_TIME_VALID,
> -			.name			=3D "C1",
> -			.desc			=3D "ARM power down",
> -		},
>  	},
> -	.state_count =3D 2,
> +	.state_count =3D 1,
>  	.safe_state_index =3D 0,
>  };
> =20
> -/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
> -static void exynos4_set_wakeupmask(void)
> -{
> -	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
> -}
> -
> -static unsigned int g_pwr_ctrl, g_diag_reg;
> -
> -static void save_cpu_arch_register(void)
> -{
> -	/*read power control register*/
> -	asm("mrc p15, 0, %0, c15, c0, 0" : "=3Dr"(g_pwr_ctrl) : : "cc");
> -	/*read diagnostic register*/
> -	asm("mrc p15, 0, %0, c15, c0, 1" : "=3Dr"(g_diag_reg) : : "cc");
> -	return;
> -}
> -
> -static void restore_cpu_arch_register(void)
> -{
> -	/*write power control register*/
> -	asm("mcr p15, 0, %0, c15, c0, 0" : : "r"(g_pwr_ctrl) : "cc");
> -	/*write diagnostic register*/
> -	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
> -	return;
> -}
> -
> -static int idle_finisher(unsigned long flags)
> -{
> -	cpu_do_idle();
> -	return 1;
> -}
> -
> -static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv,
> -				int index)
> -{
> -	unsigned long tmp;
> -
> -	exynos4_set_wakeupmask();
> -
> -	/* Set value of power down register for aftr mode */
> -	exynos_sys_powerdown_conf(SYS_AFTR);
> -
> -	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
> -	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
> -
> -	save_cpu_arch_register();
> -
> -	/* Setting Central Sequence Register for power down mode */
> -	tmp =3D __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> -	tmp &=3D ~S5P_CENTRAL_LOWPWR_CFG;
> -	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> -
> -	cpu_pm_enter();
> -	cpu_suspend(0, idle_finisher);
> -
> -#ifdef CONFIG_SMP
> -	if (!soc_is_exynos5250())
> -		scu_enable(S5P_VA_SCU);
> -#endif
> -	cpu_pm_exit();
> -
> -	restore_cpu_arch_register();
> -
> -	/*
> -	 * If PMU failed while entering sleep mode, WFI will be
> -	 * ignored by PMU and then exiting cpu_do_idle().
> -	 * S5P_CENTRAL_LOWPWR_CFG bit will not be set automatically
> -	 * in this situation.
> -	 */
> -	tmp =3D __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> -	if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
> -		tmp |=3D S5P_CENTRAL_LOWPWR_CFG;
> -		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> -	}
> -
> -	/* Clear wakeup state register */
> -	__raw_writel(0x0, S5P_WAKEUP_STAT);
> -
> -	return index;
> -}
> -
> -static int exynos4_enter_lowpower(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv,
> -				int index)
> -{
> -	int new_index =3D index;
> -
> -	/* This mode only can be entered when other core's are offline */
> -	if (num_online_cpus() > 1)
> -		new_index =3D drv->safe_state_index;
> -
> -	if (new_index =3D=3D 0)
> -		return arm_cpuidle_simple_enter(dev, drv, new_index);
> -	else
> -		return exynos4_enter_core0_aftr(dev, drv, new_index);
> -}
> -
>  static void __init exynos5_core_down_clk(void)
>  {
>  	unsigned int tmp;
> @@ -209,10 +84,6 @@ static int __init exynos4_init_cpuidle(void)
>  		device =3D &per_cpu(exynos4_cpuidle_device, cpu_id);
>  		device->cpu =3D cpu_id;
> =20
> -		/* Support IDLE only */
> -		if (cpu_id !=3D 0)
> -			device->state_count =3D 1;
> -
>  		ret =3D cpuidle_register_device(device);
>  		if (ret) {
>  			printk(KERN_ERR "CPUidle register device failed\n");
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

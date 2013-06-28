From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Fri, 28 Jun 2013 11:57:25 +0200
Message-ID: <51CD5E05.3000307@linaro.org>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com> <1372241627-22695-2-git-send-email-b.zolnierkie@samsung.com> <51CAC41C.1010900@linaro.org> <11082993.ysZegLgQAY@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <11082993.ysZegLgQAY@amdc1032>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, amit.kachhap@linaro.org, t.figa@samsung.com, rjw@sisk.pl, kyungmin.park@samsung.com
List-Id: linux-pm@vger.kernel.org

On 06/27/2013 08:10 PM, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, June 26, 2013 12:36:12 PM Daniel Lezcano wrote:
>> On 06/26/2013 12:13 PM, Bartlomiej Zolnierkiewicz wrote:
>>> AFTR mode support was introduced by commit 67173ca ("ARM: EXYNOS: A=
dd
>>> support AFTR mode on EXYNOS4210") in v3.4 kernel.  Unfortunately ev=
en
>>> in v3.4 kernel it hasn't worked as supposed and this is still the c=
ase
>>> with v3.10-rc6 (it probably wasn't noticed because CONFIG_CPU_IDLE =
is
>>> not turned on by default):
>>>
>>> - on revision 0 of Exynos4210 (Universal C210 board) it causes lock=
up
>>>   (on this revision only one core is usable so entry to AFTR mode i=
s
>>>   always attempted because the code tries to go into AFTR mode when=
 all
>>>   other CPUs except CPU0 are offlined)
>>>
>>> - on revision 1.1 of Exynos4210 (Trats board) it causes a lockup wh=
en
>>>   CPU1 is offlined (i.e. echo 0 > /sys/devices/system/cpu/cpu1/onli=
ne)
>>>
>>> - on later Exynos4/5 SoCs wrong registers may be accessed when all =
CPUs
>>>   except CPU0 are offlined resulting in panic/lockup (REG_DIRECTGO_=
ADDR
>>>   and REG_DIRECTGO_FLAG register selections was implemented only fo=
r
>>>   Exynos4210)
>>>
>>> Just remove AFTR mode support for now.
>>
>> Ok, I will jump on the opportunity to talk about this state.
>>
>> 1. I tried different ways to make the AFTR state to be entered with
>> *both* cpu online. It goes successfully to this state. The CPU0 is
>> correctly woken up but the CPU1 is never woken up, why is it happeni=
ng ?
>>
>> https://bugs.launchpad.net/linaro-landing-team-samsung/+bug/1171518
>=20
> No idea here, AFTR doesn't work for me with upstream kernels even if
> only one CPU is online.

What do you mean by "AFTR doesn't work" ? Is the kernel hanging ? The
state is never reached ?

> Also the documentation says that before entering system-level power-d=
own
> mode (such as AFTR) when multiple CPUs cores are used all other CPU c=
ores
> should stop interrupt service so I'm not sure how the way attempted b=
y
> you should work.

The cpu enters the idle mode with the interrupts disabled.

>> 2. The CPU1 hotplug bug should been fixed and if I am not wrong ther=
e is
>> a patch somewhere fixing this.
>>
>> https://bugs.launchpad.net/linaro-power-kernel/+bug/1171382
>=20
> Unfortunately none of the patches there helps with my issues.
>=20
>> 3. What is the fix for Exynos5 ?
>>
>> https://bugs.launchpad.net/linaro-power-kernel/+bug/1171253
>>
>> It sounds like depending on Hypervisor mode is enabled or not, the A=
=46TR
>> does not work correctly.
>=20
> Sorry no idea here either.  On any SoCs later than EXYNOS4210 the
> registers used for s3c_cpu_resume address and 0xFCBA0D10 magic number
> may be different than EXYNOS4210 defaults (at least on EXYNOS4412 the=
y
> indeed are different, unfortunately I lack any info needed for EXYNOS=
5
> support). You are lucky that it even works in some cases on EXYNOS525=
0.
>=20
>> In other words, instead of removing the AFTR state I suggest to fix =
it:
>> both core being online, split driver for exynos4 and 5.
>=20
> My main problem is that with the upstream kernel even on EXYNOS4210
> rev0 (only one core useable due to hardware issues) the kernel goes
> into AFTR state for the first few times during boot and then it just
> lockups (after going into cpu_do_idle() which is really cpu_v7_do_idl=
e()
> and which does wfi call) and doesn't wake up CPU0. I have currently
> no idea how to fix or debug it further.

I have an Origen 4210 board Ver A. and it works without problem with th=
e
AFTR mode (cpu1 unplugged).

> The issue happens with every upstream kernel version tried (from v3.4
> to v3.10-rc6).  Lockups also happen on EXYNOS4210 rev1.1 when CPU1 is
> offlined by hand and then cpuidle driver tries to go into AFTR mode
> (because by default it doesn't go into AFTR mode on any SoC except
> EXYNOS4210 rev0).
>=20
> I don't have EXYNOS4210 rev1.0 but it seems that in the upstream AFTR
> mode has never worked (even on hardware that it was originally develo=
ped
> on) since its introduction in v3.4 (which was released on 20th May 20=
12).
>=20
> IOW for over the year nobody cared to make it work and I have current=
ly
> no fix at hand so the corrent upstream resolution is to just remove t=
he
> known non-working code and re-introduce it later when/if needed (I ca=
n
> just disable it with a small fix but we don't keep such long-term bro=
ken
> code as placeholder in the upstream kernel).  If left as it is people
> can hit the known issues and waste time debugging them, just like thi=
s
> happenend for me [1].
>=20
> If you have AFTR mode working (especially on EXYNOS4210) in Linaro
> kernels please get fixes upstream ASAP. However I still wonder whethe=
r
> the maintanance nightmare (bugs for different cases in your launchpad=
)
> is worth gains over standard idle mode as the rumor around here is th=
at
> they are not that great (unfortunately no numbers were provided durin=
g
> original feature addition).

It works forme with a vanilla kernel 3.10.0-rc7.

Removing a feature because it seems not working is not a good solution.
The right way is to investigate what is happening and why.

Thanks
  -- Daniel

> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>=20
> [1] Somebody enabled CONFIG_CPU_IDLE in the default config in one of =
our
> internal kernel trees on a target on which this feature "works" (sinc=
e
> CPUs are not hot-unplugged by default on all targets except EXYNOS421=
0
> rev0 the code for AFTR is not used) and resulted in lockups on boot o=
n
> my default testing target. It took my long time to find out that prob=
lem
> is actually caused by just enabling exynos cpuidle driver.
>=20
>> Thanks
>>   -- Daniel
>>
>>> Cc: Jaecheol Lee <jc.lee@samsung.com>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>>> Cc: Tomasz Figa <t.figa@samsung.com>
>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> ---
>>>  arch/arm/mach-exynos/cpuidle.c | 131 +----------------------------=
------------
>>>  1 file changed, 1 insertion(+), 130 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/=
cpuidle.c
>>> index 17a18ff..0a657ac 100644
>>> --- a/arch/arm/mach-exynos/cpuidle.c
>>> +++ b/arch/arm/mach-exynos/cpuidle.c
>>> @@ -17,30 +17,11 @@
>>>  #include <linux/time.h>
>>> =20
>>>  #include <asm/proc-fns.h>
>>> -#include <asm/smp_scu.h>
>>> -#include <asm/suspend.h>
>>> -#include <asm/unified.h>
>>>  #include <asm/cpuidle.h>
>>>  #include <mach/regs-clock.h>
>>> -#include <mach/regs-pmu.h>
>>> -
>>> -#include <plat/cpu.h>
>>> =20
>>>  #include "common.h"
>>> =20
>>> -#define REG_DIRECTGO_ADDR	(samsung_rev() =3D=3D EXYNOS4210_REV_1_1=
 ? \
>>> -			S5P_INFORM7 : (samsung_rev() =3D=3D EXYNOS4210_REV_1_0 ? \
>>> -			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
>>> -#define REG_DIRECTGO_FLAG	(samsung_rev() =3D=3D EXYNOS4210_REV_1_1=
 ? \
>>> -			S5P_INFORM6 : (samsung_rev() =3D=3D EXYNOS4210_REV_1_0 ? \
>>> -			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
>>> -
>>> -#define S5P_CHECK_AFTR		0xFCBA0D10
>>> -
>>> -static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>>> -				struct cpuidle_driver *drv,
>>> -				int index);
>>> -
>>>  static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_devic=
e);
>>> =20
>>>  static struct cpuidle_driver exynos4_idle_driver =3D {
>>> @@ -48,117 +29,11 @@ static struct cpuidle_driver exynos4_idle_driv=
er =3D {
>>>  	.owner			=3D THIS_MODULE,
>>>  	.states =3D {
>>>  		[0] =3D ARM_CPUIDLE_WFI_STATE,
>>> -		[1] =3D {
>>> -			.enter			=3D exynos4_enter_lowpower,
>>> -			.exit_latency		=3D 300,
>>> -			.target_residency	=3D 100000,
>>> -			.flags			=3D CPUIDLE_FLAG_TIME_VALID,
>>> -			.name			=3D "C1",
>>> -			.desc			=3D "ARM power down",
>>> -		},
>>>  	},
>>> -	.state_count =3D 2,
>>> +	.state_count =3D 1,
>>>  	.safe_state_index =3D 0,
>>>  };
>>> =20
>>> -/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
>>> -static void exynos4_set_wakeupmask(void)
>>> -{
>>> -	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
>>> -}
>>> -
>>> -static unsigned int g_pwr_ctrl, g_diag_reg;
>>> -
>>> -static void save_cpu_arch_register(void)
>>> -{
>>> -	/*read power control register*/
>>> -	asm("mrc p15, 0, %0, c15, c0, 0" : "=3Dr"(g_pwr_ctrl) : : "cc");
>>> -	/*read diagnostic register*/
>>> -	asm("mrc p15, 0, %0, c15, c0, 1" : "=3Dr"(g_diag_reg) : : "cc");
>>> -	return;
>>> -}
>>> -
>>> -static void restore_cpu_arch_register(void)
>>> -{
>>> -	/*write power control register*/
>>> -	asm("mcr p15, 0, %0, c15, c0, 0" : : "r"(g_pwr_ctrl) : "cc");
>>> -	/*write diagnostic register*/
>>> -	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
>>> -	return;
>>> -}
>>> -
>>> -static int idle_finisher(unsigned long flags)
>>> -{
>>> -	cpu_do_idle();
>>> -	return 1;
>>> -}
>>> -
>>> -static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
>>> -				struct cpuidle_driver *drv,
>>> -				int index)
>>> -{
>>> -	unsigned long tmp;
>>> -
>>> -	exynos4_set_wakeupmask();
>>> -
>>> -	/* Set value of power down register for aftr mode */
>>> -	exynos_sys_powerdown_conf(SYS_AFTR);
>>> -
>>> -	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
>>> -	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
>>> -
>>> -	save_cpu_arch_register();
>>> -
>>> -	/* Setting Central Sequence Register for power down mode */
>>> -	tmp =3D __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
>>> -	tmp &=3D ~S5P_CENTRAL_LOWPWR_CFG;
>>> -	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
>>> -
>>> -	cpu_pm_enter();
>>> -	cpu_suspend(0, idle_finisher);
>>> -
>>> -#ifdef CONFIG_SMP
>>> -	if (!soc_is_exynos5250())
>>> -		scu_enable(S5P_VA_SCU);
>>> -#endif
>>> -	cpu_pm_exit();
>>> -
>>> -	restore_cpu_arch_register();
>>> -
>>> -	/*
>>> -	 * If PMU failed while entering sleep mode, WFI will be
>>> -	 * ignored by PMU and then exiting cpu_do_idle().
>>> -	 * S5P_CENTRAL_LOWPWR_CFG bit will not be set automatically
>>> -	 * in this situation.
>>> -	 */
>>> -	tmp =3D __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
>>> -	if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
>>> -		tmp |=3D S5P_CENTRAL_LOWPWR_CFG;
>>> -		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
>>> -	}
>>> -
>>> -	/* Clear wakeup state register */
>>> -	__raw_writel(0x0, S5P_WAKEUP_STAT);
>>> -
>>> -	return index;
>>> -}
>>> -
>>> -static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>>> -				struct cpuidle_driver *drv,
>>> -				int index)
>>> -{
>>> -	int new_index =3D index;
>>> -
>>> -	/* This mode only can be entered when other core's are offline */
>>> -	if (num_online_cpus() > 1)
>>> -		new_index =3D drv->safe_state_index;
>>> -
>>> -	if (new_index =3D=3D 0)
>>> -		return arm_cpuidle_simple_enter(dev, drv, new_index);
>>> -	else
>>> -		return exynos4_enter_core0_aftr(dev, drv, new_index);
>>> -}
>>> -
>>>  static void __init exynos5_core_down_clk(void)
>>>  {
>>>  	unsigned int tmp;
>>> @@ -209,10 +84,6 @@ static int __init exynos4_init_cpuidle(void)
>>>  		device =3D &per_cpu(exynos4_cpuidle_device, cpu_id);
>>>  		device->cpu =3D cpu_id;
>>> =20
>>> -		/* Support IDLE only */
>>> -		if (cpu_id !=3D 0)
>>> -			device->state_count =3D 1;
>>> -
>>>  		ret =3D cpuidle_register_device(device);
>>>  		if (ret) {
>>>  			printk(KERN_ERR "CPUidle register device failed\n");
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Fri, 28 Jun 2013 13:20:09 +0200
Message-ID: <51CD7169.6010905@linaro.org>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com> <11082993.ysZegLgQAY@amdc1032> <51CD5E05.3000307@linaro.org> <19893620.AhWB5HomTT@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:43585 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab3F1LT4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2013 07:19:56 -0400
Received: by mail-ea0-f172.google.com with SMTP id q10so973767eaj.17
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2013 04:19:54 -0700 (PDT)
In-Reply-To: <19893620.AhWB5HomTT@amdc1227>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, Amit Kachhap <amit.daniel@samsung.com>, rjw@sisk.pl, kyungmin.park@samsung.com

On 06/28/2013 12:11 PM, Tomasz Figa wrote:
> Hi Daniel,
>=20
> I've been fighting with this whole AFTR state as well, before Bartlom=
iej.=20
> Let me share my thoughts on this.
>=20
> On Friday 28 of June 2013 11:57:25 Daniel Lezcano wrote:
>> On 06/27/2013 08:10 PM, Bartlomiej Zolnierkiewicz wrote:
>>> On Wednesday, June 26, 2013 12:36:12 PM Daniel Lezcano wrote:
>>>> On 06/26/2013 12:13 PM, Bartlomiej Zolnierkiewicz wrote:
>>>>> AFTR mode support was introduced by commit 67173ca ("ARM: EXYNOS:=
 Add
>>>>> support AFTR mode on EXYNOS4210") in v3.4 kernel.  Unfortunately =
even
>>>>> in v3.4 kernel it hasn't worked as supposed and this is still the
>>>>> case
>>>>> with v3.10-rc6 (it probably wasn't noticed because CONFIG_CPU_IDL=
E is
>>>>> not turned on by default):
>>>>>
>>>>> - on revision 0 of Exynos4210 (Universal C210 board) it causes lo=
ckup
>>>>>
>>>>>   (on this revision only one core is usable so entry to AFTR mode=
 is
>>>>>   always attempted because the code tries to go into AFTR mode wh=
en
>>>>>   all
>>>>>   other CPUs except CPU0 are offlined)
>>>>>
>>>>> - on revision 1.1 of Exynos4210 (Trats board) it causes a lockup =
when
>>>>>
>>>>>   CPU1 is offlined (i.e. echo 0 >
>>>>>   /sys/devices/system/cpu/cpu1/online)
>>>>>
>>>>> - on later Exynos4/5 SoCs wrong registers may be accessed when al=
l
>>>>> CPUs
>>>>>
>>>>>   except CPU0 are offlined resulting in panic/lockup
>>>>>   (REG_DIRECTGO_ADDR
>>>>>   and REG_DIRECTGO_FLAG register selections was implemented only =
for
>>>>>   Exynos4210)
>>>>>
>>>>> Just remove AFTR mode support for now.
>>>>
>>>> Ok, I will jump on the opportunity to talk about this state.
>>>>
>>>> 1. I tried different ways to make the AFTR state to be entered wit=
h
>>>> *both* cpu online. It goes successfully to this state. The CPU0 is
>>>> correctly woken up but the CPU1 is never woken up, why is it happe=
ning
>>>> ?
>>>>
>>>> https://bugs.launchpad.net/linaro-landing-team-samsung/+bug/117151=
8
>>>
>>> No idea here, AFTR doesn't work for me with upstream kernels even i=
f
>>> only one CPU is online.
>>
>> What do you mean by "AFTR doesn't work" ? Is the kernel hanging ? Th=
e
>> state is never reached ?
>=20
> If you don't unplug all the CPUs >0 the state is obviously never reac=
hed.=20
> Otherwise the whole system hangs after it tries to enter this mode wi=
thout=20
> any reaction for external events, other than reset.

Need investigation.

What is the exynos board version where that occurs ?

>>> Also the documentation says that before entering system-level
>>> power-down
>>> mode (such as AFTR) when multiple CPUs cores are used all other CPU
>>> cores should stop interrupt service so I'm not sure how the way
>>> attempted by you should work.
>>
>> The cpu enters the idle mode with the interrupts disabled.
>=20
> Hmm? What is supposed to wake it up then? AFAIK the whole idea of any=
 idle=20
> or sleep is to sit in such low power mode until some interrupt fires =
(and so=20
> the name of the WFI, wait for interrupt, instruction).

It is handled by the hardware, for the exynos it should be the PMU. The
CPU stays clock/power gated and when an interrupt occurs the PMU wakes
up the CPU. This one continue its instructions after cpu_do_idle and
right after enables the local interrupts leading to the interrupt handl=
ing.

>>>> 2. The CPU1 hotplug bug should been fixed and if I am not wrong th=
ere
>>>> is
>>>> a patch somewhere fixing this.
>>>>
>>>> https://bugs.launchpad.net/linaro-power-kernel/+bug/1171382
>>>
>>> Unfortunately none of the patches there helps with my issues.
>>>
>>>> 3. What is the fix for Exynos5 ?
>>>>
>>>> https://bugs.launchpad.net/linaro-power-kernel/+bug/1171253
>>>>
>>>> It sounds like depending on Hypervisor mode is enabled or not, the
>>>> AFTR
>>>> does not work correctly.
>>>
>>> Sorry no idea here either.  On any SoCs later than EXYNOS4210 the
>>> registers used for s3c_cpu_resume address and 0xFCBA0D10 magic numb=
er
>>> may be different than EXYNOS4210 defaults (at least on EXYNOS4412 t=
hey
>>> indeed are different, unfortunately I lack any info needed for EXYN=
OS5
>>> support). You are lucky that it even works in some cases on EXYNOS5=
250.
>>>
>>>> In other words, instead of removing the AFTR state I suggest to fi=
x
>>>> it:
>>>> both core being online, split driver for exynos4 and 5.
>>>
>>> My main problem is that with the upstream kernel even on EXYNOS4210
>>> rev0 (only one core useable due to hardware issues) the kernel goes
>>> into AFTR state for the first few times during boot and then it jus=
t
>>> lockups (after going into cpu_do_idle() which is really
>>> cpu_v7_do_idle()
>>> and which does wfi call) and doesn't wake up CPU0. I have currently
>>> no idea how to fix or debug it further.
>>
>> I have an Origen 4210 board Ver A. and it works without problem with=
 the
>> AFTR mode (cpu1 unplugged).
>=20
> Great!
>=20
> Since benefits of this feature are rather questionable, especially wh=
en you=20
> consider all the maintenance burden caused by it, could you do some=20
> measurements to check if power saving thanks to this mode is of any=20
> significance?

No I can't, no spare time for that and furthermore this work has alread=
y
be done by Amit Daniel when he submitted the driver.

Amit Daniel is no longer a Linaro assignee but it is still part of the
Samsung company (changed the email address to reach him).

>>> The issue happens with every upstream kernel version tried (from v3=
=2E4
>>> to v3.10-rc6).  Lockups also happen on EXYNOS4210 rev1.1 when CPU1 =
is
>>> offlined by hand and then cpuidle driver tries to go into AFTR mode
>>> (because by default it doesn't go into AFTR mode on any SoC except
>>> EXYNOS4210 rev0).
>>>
>>> I don't have EXYNOS4210 rev1.0 but it seems that in the upstream AF=
TR
>>> mode has never worked (even on hardware that it was originally
>>> developed
>>> on) since its introduction in v3.4 (which was released on 20th May
>>> 2012).
>>>
>>> IOW for over the year nobody cared to make it work and I have curre=
ntly
>>> no fix at hand so the corrent upstream resolution is to just remove=
 the
>>> known non-working code and re-introduce it later when/if needed (I =
can
>>> just disable it with a small fix but we don't keep such long-term
>>> broken
>>> code as placeholder in the upstream kernel).  If left as it is peop=
le
>>> can hit the known issues and waste time debugging them, just like t=
his
>>> happenend for me [1].
>>>
>>> If you have AFTR mode working (especially on EXYNOS4210) in Linaro
>>> kernels please get fixes upstream ASAP. However I still wonder whet=
her
>>> the maintanance nightmare (bugs for different cases in your launchp=
ad)
>>> is worth gains over standard idle mode as the rumor around here is =
that
>>> they are not that great (unfortunately no numbers were provided dur=
ing
>>> original feature addition).
>>
>> It works forme with a vanilla kernel 3.10.0-rc7.
>=20
> As Bartek already said, I haven't worked on any of our Exynos 4210 ba=
sed=20
> boards since it got introduced in Linux 3.4, with exactly the same ef=
fect we=20
> described.
>=20
>> Removing a feature because it seems not working is not a good soluti=
on.
>> The right way is to investigate what is happening and why.
>=20
> I can agree only partially. Keeping a feature that is broken and with=
out=20
> any significant benefits does not make sense for me. Neither does put=
ting=20
> efforts into fixing it, only to find that it is of no use.
>=20
> However this is purely a speculation. Could you test on your Origen, =
on=20
> which it is supposed to work, if this feature is of any use?

It is useless to do that. This work is already done.

The kernel is not a playground where you can upstream code and then
remove it because a feature seems broken and you don't have an idea of =
why.

I asked several times the reasons of why the AFTR state couldn't work
with multiple CPUs and I had no answer.

=46rankly speaking I have a couple of hypothesis:

1. something is not correctly setup and the PMU does not wake up the CP=
U1
2. there is a silicon bug and no one wants to tell it is the case

In any case, this must be investigated and identified. And then we can
take a decision about this state.

>>> --
>>> Bartlomiej Zolnierkiewicz
>>> Samsung R&D Institute Poland
>>> Samsung Electronics
>>>
>>> [1] Somebody enabled CONFIG_CPU_IDLE in the default config in one o=
f
>>> our
>>> internal kernel trees on a target on which this feature "works" (si=
nce
>>> CPUs are not hot-unplugged by default on all targets except EXYNOS4=
210
>>> rev0 the code for AFTR is not used) and resulted in lockups on boot=
 on
>>> my default testing target. It took my long time to find out that
>>> problem
>>> is actually caused by just enabling exynos cpuidle driver.
>>>
>>>> Thanks
>>>>
>>>>   -- Daniel
>>>>>
>>>>> Cc: Jaecheol Lee <jc.lee@samsung.com>
>>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>> Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>>>>> Cc: Tomasz Figa <t.figa@samsung.com>
>>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.co=
m>
>>>>> ---
>>>>>
>>>>>  arch/arm/mach-exynos/cpuidle.c | 131
>>>>>  +---------------------------------------- 1 file changed, 1
>>>>>  insertion(+), 130 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-exynos/cpuidle.c
>>>>> b/arch/arm/mach-exynos/cpuidle.c index 17a18ff..0a657ac 100644
>>>>> --- a/arch/arm/mach-exynos/cpuidle.c
>>>>> +++ b/arch/arm/mach-exynos/cpuidle.c
>>>>> @@ -17,30 +17,11 @@
>>>>>
>>>>>  #include <linux/time.h>
>>>>> =20
>>>>>  #include <asm/proc-fns.h>
>>>>>
>>>>> -#include <asm/smp_scu.h>
>>>>> -#include <asm/suspend.h>
>>>>> -#include <asm/unified.h>
>>>>>
>>>>>  #include <asm/cpuidle.h>
>>>>>  #include <mach/regs-clock.h>
>>>>>
>>>>> -#include <mach/regs-pmu.h>
>>>>> -
>>>>> -#include <plat/cpu.h>
>>>>>
>>>>>  #include "common.h"
>>>>>
>>>>> -#define REG_DIRECTGO_ADDR	(samsung_rev() =3D=3D EXYNOS4210_REV_1=
_1 ? \
>>>>> -			S5P_INFORM7 : (samsung_rev() =3D=3D EXYNOS4210_REV_1_0 ? \
>>>>> -			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
>>>>> -#define REG_DIRECTGO_FLAG	(samsung_rev() =3D=3D EXYNOS4210_REV_1=
_1 ? \
>>>>> -			S5P_INFORM6 : (samsung_rev() =3D=3D EXYNOS4210_REV_1_0 ? \
>>>>> -			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
>>>>> -
>>>>> -#define S5P_CHECK_AFTR		0xFCBA0D10
>>>>> -
>>>>> -static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>>>>> -				struct cpuidle_driver *drv,
>>>>> -				int index);
>>>>> -
>>>>>
>>>>>  static DEFINE_PER_CPU(struct cpuidle_device,
>>>>>  exynos4_cpuidle_device);
>>>>> =20
>>>>>  static struct cpuidle_driver exynos4_idle_driver =3D {
>>>>>
>>>>> @@ -48,117 +29,11 @@ static struct cpuidle_driver exynos4_idle_dr=
iver
>>>>> =3D {>>>=20
>>>>>  	.owner			=3D THIS_MODULE,
>>>>>  	.states =3D {
>>>>>  =09
>>>>>  		[0] =3D ARM_CPUIDLE_WFI_STATE,
>>>>>
>>>>> -		[1] =3D {
>>>>> -			.enter			=3D exynos4_enter_lowpower,
>>>>> -			.exit_latency		=3D 300,
>>>>> -			.target_residency	=3D 100000,
>>>>> -			.flags			=3D CPUIDLE_FLAG_TIME_VALID,
>>>>> -			.name			=3D "C1",
>>>>> -			.desc			=3D "ARM power down",
>>>>> -		},
>>>>>
>>>>>  	},
>>>>>
>>>>> -	.state_count =3D 2,
>>>>> +	.state_count =3D 1,
>>>>>
>>>>>  	.safe_state_index =3D 0,
>>>>> =20
>>>>>  };
>>>>>
>>>>> -/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
>>>>> -static void exynos4_set_wakeupmask(void)
>>>>> -{
>>>>> -	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
>>>>> -}
>>>>> -
>>>>> -static unsigned int g_pwr_ctrl, g_diag_reg;
>>>>> -
>>>>> -static void save_cpu_arch_register(void)
>>>>> -{
>>>>> -	/*read power control register*/
>>>>> -	asm("mrc p15, 0, %0, c15, c0, 0" : "=3Dr"(g_pwr_ctrl) : : "cc")=
;
>>>>> -	/*read diagnostic register*/
>>>>> -	asm("mrc p15, 0, %0, c15, c0, 1" : "=3Dr"(g_diag_reg) : : "cc")=
;
>>>>> -	return;
>>>>> -}
>>>>> -
>>>>> -static void restore_cpu_arch_register(void)
>>>>> -{
>>>>> -	/*write power control register*/
>>>>> -	asm("mcr p15, 0, %0, c15, c0, 0" : : "r"(g_pwr_ctrl) : "cc");
>>>>> -	/*write diagnostic register*/
>>>>> -	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
>>>>> -	return;
>>>>> -}
>>>>> -
>>>>> -static int idle_finisher(unsigned long flags)
>>>>> -{
>>>>> -	cpu_do_idle();
>>>>> -	return 1;
>>>>> -}
>>>>> -
>>>>> -static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
>>>>> -				struct cpuidle_driver *drv,
>>>>> -				int index)
>>>>> -{
>>>>> -	unsigned long tmp;
>>>>> -
>>>>> -	exynos4_set_wakeupmask();
>>>>> -
>>>>> -	/* Set value of power down register for aftr mode */
>>>>> -	exynos_sys_powerdown_conf(SYS_AFTR);
>>>>> -
>>>>> -	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
>>>>> -	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
>>>>> -
>>>>> -	save_cpu_arch_register();
>>>>> -
>>>>> -	/* Setting Central Sequence Register for power down mode */
>>>>> -	tmp =3D __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
>>>>> -	tmp &=3D ~S5P_CENTRAL_LOWPWR_CFG;
>>>>> -	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
>>>>> -
>>>>> -	cpu_pm_enter();
>>>>> -	cpu_suspend(0, idle_finisher);
>>>>> -
>>>>> -#ifdef CONFIG_SMP
>>>>> -	if (!soc_is_exynos5250())
>>>>> -		scu_enable(S5P_VA_SCU);
>>>>> -#endif
>>>>> -	cpu_pm_exit();
>>>>> -
>>>>> -	restore_cpu_arch_register();
>>>>> -
>>>>> -	/*
>>>>> -	 * If PMU failed while entering sleep mode, WFI will be
>>>>> -	 * ignored by PMU and then exiting cpu_do_idle().
>>>>> -	 * S5P_CENTRAL_LOWPWR_CFG bit will not be set automatically
>>>>> -	 * in this situation.
>>>>> -	 */
>>>>> -	tmp =3D __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
>>>>> -	if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
>>>>> -		tmp |=3D S5P_CENTRAL_LOWPWR_CFG;
>>>>> -		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
>>>>> -	}
>>>>> -
>>>>> -	/* Clear wakeup state register */
>>>>> -	__raw_writel(0x0, S5P_WAKEUP_STAT);
>>>>> -
>>>>> -	return index;
>>>>> -}
>>>>> -
>>>>> -static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>>>>> -				struct cpuidle_driver *drv,
>>>>> -				int index)
>>>>> -{
>>>>> -	int new_index =3D index;
>>>>> -
>>>>> -	/* This mode only can be entered when other core's are offline =
*/
>>>>> -	if (num_online_cpus() > 1)
>>>>> -		new_index =3D drv->safe_state_index;
>>>>> -
>>>>> -	if (new_index =3D=3D 0)
>>>>> -		return arm_cpuidle_simple_enter(dev, drv, new_index);
>>>>> -	else
>>>>> -		return exynos4_enter_core0_aftr(dev, drv, new_index);
>>>>> -}
>>>>> -
>>>>>
>>>>>  static void __init exynos5_core_down_clk(void)
>>>>>  {
>>>>> =20
>>>>>  	unsigned int tmp;
>>>>>
>>>>> @@ -209,10 +84,6 @@ static int __init exynos4_init_cpuidle(void)
>>>>>
>>>>>  		device =3D &per_cpu(exynos4_cpuidle_device, cpu_id);
>>>>>  		device->cpu =3D cpu_id;
>>>>>
>>>>> -		/* Support IDLE only */
>>>>> -		if (cpu_id !=3D 0)
>>>>> -			device->state_count =3D 1;
>>>>> -
>>>>>
>>>>>  		ret =3D cpuidle_register_device(device);
>>>>>  		if (ret) {
>>>>>  	=09
>>>>>  			printk(KERN_ERR "CPUidle register device failed\n");


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


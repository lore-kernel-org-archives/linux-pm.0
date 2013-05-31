From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] ARM: tegra114: cpuidle: add powered-down state
Date: Fri, 31 May 2013 11:27:45 +0200
Message-ID: <51A86D11.8060305@linaro.org>
References: <1369912782-30663-1-git-send-email-josephl@nvidia.com>  <1369912782-30663-4-git-send-email-josephl@nvidia.com>  <51A763BD.6070001@linaro.org> <1369991550.7804.37.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:51576 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab3EaJ1x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2013 05:27:53 -0400
Received: by mail-bk0-f52.google.com with SMTP id mz10so626902bkb.25
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2013 02:27:51 -0700 (PDT)
In-Reply-To: <1369991550.7804.37.camel@jlo-ubuntu-64.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joseph Lo <josephl@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

On 05/31/2013 11:12 AM, Joseph Lo wrote:
> Hi Daniel,
>=20
> Thanks for your review.
>=20
> On Thu, 2013-05-30 at 22:35 +0800, Daniel Lezcano wrote:
>> On 05/30/2013 01:19 PM, Joseph Lo wrote:
>>> This supports CPU core power down on each CPU when CPU idle. When C=
PU go
>>> into this state, it saves it's context and needs a proper configura=
tion
>>> in flow controller to power gate the CPU when CPU runs into WFI
>>> instruction. And the CPU also needs to set the IRQ as CPU power dow=
n idle
>>> wake up event in flow controller.
>>>
>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>> ---
>>
>> Hi Joseph,
>>
>> a new flag has been added in the cpuidle framework to let this one t=
o
>> handle the timer broadcast : CPUIDLE_FLAG_TIMER_STOP
>>
>> It is the commit b60e6a0eb0273132cbb60a9806abf5f47a4aee1c
>>
>> You can get rid of the clockevent notify stuff by adding this flag t=
o
>> the state.
>>
>=20
> I just tested this flag on Tegra20, 30 and 114. It is only OK on
> Tegra20. It caused a warning message below on Tegra30/114 at boot tim=
e.
>=20
> I gave it a quick check I found it can't clean
> tick_broadcast_pending_mask sometimes if apply the flag. But I keep t=
he
> code right now it's always OK. Not sure why?=20

Is it possible you didn't intialized the timer broadcast with
CLOCK_EVT_NOTIFY_BROADCAST_ON in the driver and then this one is
actually disabled for you driver ?

> [   25.629539] ------------[ cut here ]------------
> [   25.629559] WARNING: CPU: 2 PID: 0 at
> kernel/time/tick-broadcast.c:578 tick_broadcast_oneshot_control
> +0x1a4/0x1d0()
> [   25.629565] Modules linked in:
> [   25.629574] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
> 3.10.0-rc3-next-20130529+ #15
> [   25.629601] [<c00148f4>] (unwind_backtrace+0x0/0xf8) from
> [<c0011040>] (show_stack+0x10/0x14)
> [   25.629616] [<c0011040>] (show_stack+0x10/0x14) from [<c0504248>]
> (dump_stack+0x80/0xc4)
> [   25.629633] [<c0504248>] (dump_stack+0x80/0xc4) from [<c00231ac>]
> (warn_slowpath_common+0x64/0x88)
> [   25.629646] [<c00231ac>] (warn_slowpath_common+0x64/0x88) from
> [<c00231ec>] (warn_slowpath_null+0x1c/0x24)
> [   25.629657] [<c00231ec>] (warn_slowpath_null+0x1c/0x24) from
> [<c00667f8>] (tick_broadcast_oneshot_control+0x1a4/0x1d0)
> [   25.629670] [<c00667f8>] (tick_broadcast_oneshot_control+0x1a4/0x1=
d0)
> from [<c0065cd0>] (tick_notify+0x240/0x40c)
> [   25.629685] [<c0065cd0>] (tick_notify+0x240/0x40c) from [<c0044724=
>]
> (notifier_call_chain+0x44/0x84)
> [   25.629699] [<c0044724>] (notifier_call_chain+0x44/0x84) from
> [<c0044828>] (raw_notifier_call_chain+0x18/0x20)
> [   25.629712] [<c0044828>] (raw_notifier_call_chain+0x18/0x20) from
> [<c00650cc>] (clockevents_notify+0x28/0x170)
> [   25.629726] [<c00650cc>] (clockevents_notify+0x28/0x170) from
> [<c033f1f0>] (cpuidle_idle_call+0x11c/0x168)
> [   25.629739] [<c033f1f0>] (cpuidle_idle_call+0x11c/0x168) from
> [<c000ea94>] (arch_cpu_idle+0x8/0x38)
> [   25.629755] [<c000ea94>] (arch_cpu_idle+0x8/0x38) from [<c005ea80>=
]
> (cpu_startup_entry+0x60/0x134)
> [   25.629767] [<c005ea80>] (cpu_startup_entry+0x60/0x134) from
> [<804fe9a4>] (0x804fe9a4)
> [   25.629772] ---[ end trace 5484e77e2531bccc ]---
>=20
>=20
>> Also, can you clarify why tegra3 code is used in tegra114 ?
>>
> Yes, because the flow controller that was used to control CPU power i=
s
> similar for both SoCs. The function is shared for Tegra30/114.
>=20
>>
>>>  arch/arm/mach-tegra/cpuidle-tegra114.c | 62 ++++++++++++++++++++++=
+++++++++++-
>>>  1 file changed, 61 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach=
-tegra/cpuidle-tegra114.c
>>> index 1d1c602..e7d21f5 100644
>>> --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
>>> +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
>>> @@ -17,19 +17,79 @@
>>>  #include <linux/kernel.h>
>>>  #include <linux/module.h>
>>>  #include <linux/cpuidle.h>
>>> +#include <linux/cpu_pm.h>
>>> +#include <linux/clockchips.h>
>>> =20
>>>  #include <asm/cpuidle.h>
>>> +#include <asm/suspend.h>
>>> +#include <asm/smp_plat.h>
>>> +
>>> +#include "pm.h"
>>> +#include "sleep.h"
>>> +
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int tegra114_idle_power_down(struct cpuidle_device *dev,
>>> +				    struct cpuidle_driver *drv,
>>> +				    int index);
>>
>> Isn't possible to move the driver declaration after the
>> tegra114_idle_power_down function, before the init function, so we
>> prevent a forward declaration ?
>>
>>> +#define TEGRA114_MAX_STATES 2
>>> +#else
>>> +#define TEGRA114_MAX_STATES 1
>>> +#endif
>>> =20
>>>  static struct cpuidle_driver tegra_idle_driver =3D {
>>>  	.name =3D "tegra_idle",
>>>  	.owner =3D THIS_MODULE,
>>> -	.state_count =3D 1,
>>> +	.state_count =3D TEGRA114_MAX_STATES,
>>>  	.states =3D {
>>>  		[0] =3D ARM_CPUIDLE_WFI_STATE_PWR(600),
>>> +#ifdef CONFIG_PM_SLEEP
>>> +		[1] =3D {
>>> +			.enter			=3D tegra114_idle_power_down,
>>> +			.exit_latency		=3D 500,
>>> +			.target_residency	=3D 1000,
>>> +			.power_usage		=3D 0,
>>> +			.flags			=3D CPUIDLE_FLAG_TIME_VALID,
>>> +			.name			=3D "powered-down",
>>> +			.desc			=3D "CPU power gated",
>>> +		},
>>> +#endif
>>>  	},
>>>  };
>>> =20
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int tegra114_idle_power_down(struct cpuidle_device *dev,
>>> +				    struct cpuidle_driver *drv,
>>> +				    int index)
>>> +{
>>> +	u32 cpu =3D is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
>>
>> IMO, it is up to the tegra_set_cpu_in_lp2 / tegra_clear_cpu_in_lp2
>> functions to do the cpu map conversion instead of adding this into a
>> routine working with logical cpu.
>>
> Good idea, I can create another patch to do that.
>=20
>>> +	local_fiq_disable();
>>> +
>>> +	tegra_set_cpu_in_lp2(cpu);
>>> +	cpu_pm_enter();
>>> +
>>> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
>>> +	smp_wmb();
>>
>> Why do you need a memory barrier here ?
>>
> Yeah, Looks I don't have any static data that needs a barrier to sync
> data for SMP here. Will remove them.
>=20
>>> +	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
>>> +
>>> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
>>> +
>>> +	cpu_pm_exit();
>>> +	tegra_clear_cpu_in_lp2(cpu);
>>> +
>>> +	local_fiq_enable();
>>> +
>>> +	smp_rmb();
>>
>> Why do you need a memory barrier here ?
>>
>>> +	return index;
>>> +}
>>> +#endif
>>> +
>>>  int __init tegra114_cpuidle_init(void)
>>>  {
>>> +#ifdef CONFIG_PM_SLEEP
>>> +	tegra_tear_down_cpu =3D tegra30_tear_down_cpu;
>>> +#endif
>>
>> Doesn't this code should go in the pm.c file ?
>>
> Yes, I had a plan to do that too. Currently It had a timing issue abo=
ut
> this. Because the CPU idle driver was registered by device_initcall, =
but
> the PM init function was registered at late init. I need to sync the
> init time first.
> OK, will do that too.
>=20
> Thanks,
> Joseph
>=20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


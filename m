From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: tegra114: cpuidle: add powered-down state
Date: Fri, 31 May 2013 17:12:29 +0800
Message-ID: <1369991550.7804.37.camel@jlo-ubuntu-64.nvidia.com>
References: <1369912782-30663-1-git-send-email-josephl@nvidia.com>
	 <1369912782-30663-4-git-send-email-josephl@nvidia.com>
	 <51A763BD.6070001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A763BD.6070001-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux PM mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

Thanks for your review.

On Thu, 2013-05-30 at 22:35 +0800, Daniel Lezcano wrote:
> On 05/30/2013 01:19 PM, Joseph Lo wrote:
> > This supports CPU core power down on each CPU when CPU idle. When CPU go
> > into this state, it saves it's context and needs a proper configuration
> > in flow controller to power gate the CPU when CPU runs into WFI
> > instruction. And the CPU also needs to set the IRQ as CPU power down idle
> > wake up event in flow controller.
> > 
> > Signed-off-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> 
> Hi Joseph,
> 
> a new flag has been added in the cpuidle framework to let this one to
> handle the timer broadcast : CPUIDLE_FLAG_TIMER_STOP
> 
> It is the commit b60e6a0eb0273132cbb60a9806abf5f47a4aee1c
> 
> You can get rid of the clockevent notify stuff by adding this flag to
> the state.
> 

I just tested this flag on Tegra20, 30 and 114. It is only OK on
Tegra20. It caused a warning message below on Tegra30/114 at boot time.

I gave it a quick check I found it can't clean
tick_broadcast_pending_mask sometimes if apply the flag. But I keep the
code right now it's always OK. Not sure why? 

[   25.629539] ------------[ cut here ]------------
[   25.629559] WARNING: CPU: 2 PID: 0 at
kernel/time/tick-broadcast.c:578 tick_broadcast_oneshot_control
+0x1a4/0x1d0()
[   25.629565] Modules linked in:
[   25.629574] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
3.10.0-rc3-next-20130529+ #15
[   25.629601] [<c00148f4>] (unwind_backtrace+0x0/0xf8) from
[<c0011040>] (show_stack+0x10/0x14)
[   25.629616] [<c0011040>] (show_stack+0x10/0x14) from [<c0504248>]
(dump_stack+0x80/0xc4)
[   25.629633] [<c0504248>] (dump_stack+0x80/0xc4) from [<c00231ac>]
(warn_slowpath_common+0x64/0x88)
[   25.629646] [<c00231ac>] (warn_slowpath_common+0x64/0x88) from
[<c00231ec>] (warn_slowpath_null+0x1c/0x24)
[   25.629657] [<c00231ec>] (warn_slowpath_null+0x1c/0x24) from
[<c00667f8>] (tick_broadcast_oneshot_control+0x1a4/0x1d0)
[   25.629670] [<c00667f8>] (tick_broadcast_oneshot_control+0x1a4/0x1d0)
from [<c0065cd0>] (tick_notify+0x240/0x40c)
[   25.629685] [<c0065cd0>] (tick_notify+0x240/0x40c) from [<c0044724>]
(notifier_call_chain+0x44/0x84)
[   25.629699] [<c0044724>] (notifier_call_chain+0x44/0x84) from
[<c0044828>] (raw_notifier_call_chain+0x18/0x20)
[   25.629712] [<c0044828>] (raw_notifier_call_chain+0x18/0x20) from
[<c00650cc>] (clockevents_notify+0x28/0x170)
[   25.629726] [<c00650cc>] (clockevents_notify+0x28/0x170) from
[<c033f1f0>] (cpuidle_idle_call+0x11c/0x168)
[   25.629739] [<c033f1f0>] (cpuidle_idle_call+0x11c/0x168) from
[<c000ea94>] (arch_cpu_idle+0x8/0x38)
[   25.629755] [<c000ea94>] (arch_cpu_idle+0x8/0x38) from [<c005ea80>]
(cpu_startup_entry+0x60/0x134)
[   25.629767] [<c005ea80>] (cpu_startup_entry+0x60/0x134) from
[<804fe9a4>] (0x804fe9a4)
[   25.629772] ---[ end trace 5484e77e2531bccc ]---


> Also, can you clarify why tegra3 code is used in tegra114 ?
> 
Yes, because the flow controller that was used to control CPU power is
similar for both SoCs. The function is shared for Tegra30/114.

> 
> >  arch/arm/mach-tegra/cpuidle-tegra114.c | 62 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 61 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
> > index 1d1c602..e7d21f5 100644
> > --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
> > +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
> > @@ -17,19 +17,79 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/cpuidle.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/clockchips.h>
> >  
> >  #include <asm/cpuidle.h>
> > +#include <asm/suspend.h>
> > +#include <asm/smp_plat.h>
> > +
> > +#include "pm.h"
> > +#include "sleep.h"
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int tegra114_idle_power_down(struct cpuidle_device *dev,
> > +				    struct cpuidle_driver *drv,
> > +				    int index);
> 
> Isn't possible to move the driver declaration after the
> tegra114_idle_power_down function, before the init function, so we
> prevent a forward declaration ?
> 
> > +#define TEGRA114_MAX_STATES 2
> > +#else
> > +#define TEGRA114_MAX_STATES 1
> > +#endif
> >  
> >  static struct cpuidle_driver tegra_idle_driver = {
> >  	.name = "tegra_idle",
> >  	.owner = THIS_MODULE,
> > -	.state_count = 1,
> > +	.state_count = TEGRA114_MAX_STATES,
> >  	.states = {
> >  		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
> > +#ifdef CONFIG_PM_SLEEP
> > +		[1] = {
> > +			.enter			= tegra114_idle_power_down,
> > +			.exit_latency		= 500,
> > +			.target_residency	= 1000,
> > +			.power_usage		= 0,
> > +			.flags			= CPUIDLE_FLAG_TIME_VALID,
> > +			.name			= "powered-down",
> > +			.desc			= "CPU power gated",
> > +		},
> > +#endif
> >  	},
> >  };
> >  
> > +#ifdef CONFIG_PM_SLEEP
> > +static int tegra114_idle_power_down(struct cpuidle_device *dev,
> > +				    struct cpuidle_driver *drv,
> > +				    int index)
> > +{
> > +	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
> 
> IMO, it is up to the tegra_set_cpu_in_lp2 / tegra_clear_cpu_in_lp2
> functions to do the cpu map conversion instead of adding this into a
> routine working with logical cpu.
> 
Good idea, I can create another patch to do that.

> > +	local_fiq_disable();
> > +
> > +	tegra_set_cpu_in_lp2(cpu);
> > +	cpu_pm_enter();
> > +
> > +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> > +	smp_wmb();
> 
> Why do you need a memory barrier here ?
> 
Yeah, Looks I don't have any static data that needs a barrier to sync
data for SMP here. Will remove them.

> > +	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
> > +
> > +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> > +
> > +	cpu_pm_exit();
> > +	tegra_clear_cpu_in_lp2(cpu);
> > +
> > +	local_fiq_enable();
> > +
> > +	smp_rmb();
> 
> Why do you need a memory barrier here ?
> 
> > +	return index;
> > +}
> > +#endif
> > +
> >  int __init tegra114_cpuidle_init(void)
> >  {
> > +#ifdef CONFIG_PM_SLEEP
> > +	tegra_tear_down_cpu = tegra30_tear_down_cpu;
> > +#endif
> 
> Doesn't this code should go in the pm.c file ?
> 
Yes, I had a plan to do that too. Currently It had a timing issue about
this. Because the CPU idle driver was registered by device_initcall, but
the PM init function was registered at late init. I need to sync the
init time first.
OK, will do that too.

Thanks,
Joseph

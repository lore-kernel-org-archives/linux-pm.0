From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
Date: Wed, 8 Apr 2015 12:55:46 +0100
Message-ID: <20150408115546.GA24271@red-moon>
References: <1428490480-10144-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50345 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbbDHLzz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Apr 2015 07:55:55 -0400
Content-Disposition: inline
In-Reply-To: <1428490480-10144-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Apr 08, 2015 at 11:54:38AM +0100, Tomeu Vizoso wrote:
> This callback is expected to do the same as enter() only that all
> non-wakeup IRQs are expected to be disabled.

This is not true or at least it is misworded. The enter_freeze() function
is expected to return from the state with IRQs disabled at CPU level, or
put it differently it must not re-enable IRQs while executing since the
tick is frozen.

> It will be called when the system goes to suspend-to-idle and will
> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/arm/mach-tegra/cpuidle-tegra114.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
> index f2b586d..ef06001 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
> @@ -39,28 +39,44 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
>  				    struct cpuidle_driver *drv,
>  				    int index)
>  {
> -	local_fiq_disable();
> -
>  	tegra_set_cpu_in_lp2();
>  	cpu_pm_enter();
>  
> -	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> -
>  	call_firmware_op(prepare_idle);
>  
>  	/* Do suspend by ourselves if the firmware does not implement it */
>  	if (call_firmware_op(do_idle, 0) == -ENOSYS)
>  		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
>  
> -	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> -
>  	cpu_pm_exit();
>  	tegra_clear_cpu_in_lp2();
>  
> +	return index;
> +}
> +
> +static int tegra114_idle_enter(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv,
> +			       int index)
> +{
> +	local_fiq_disable();
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> +
> +	index = tegra114_idle_power_down(dev, drv, index);
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> +
>  	local_fiq_enable();
>  
>  	return index;
>  }
> +
> +static void tegra114_idle_enter_freeze(struct cpuidle_device *dev,
> +				       struct cpuidle_driver *drv,
> +				       int index)
> +{
> +	tegra114_idle_power_down(dev, drv, index);

Cool. So if the problem is FIQs, you don't disabled them on entry
which means you enter the "frozen" state with FIQs enabled and tick frozen,
unless I am missing something.

The question here is: are we allowed to enable FIQs before returning
from an enter_freeze() call (and to enter it with FIQs enabled) ?

If we are not your code here certainly does not solve the issue, since
it does _not_ disable FIQs upon enter_freeze call anyway.

Lorenzo

> +}
>  #endif
>  
>  static struct cpuidle_driver tegra_idle_driver = {
> @@ -71,7 +87,8 @@ static struct cpuidle_driver tegra_idle_driver = {
>  		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
>  #ifdef CONFIG_PM_SLEEP
>  		[1] = {
> -			.enter			= tegra114_idle_power_down,
> +			.enter			= tegra114_idle_enter,
> +			.enter_freeze		= tegra114_idle_enter_freeze,
>  			.exit_latency		= 500,
>  			.target_residency	= 1000,
>  			.power_usage		= 0,
> -- 
> 2.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
Date: Wed, 20 May 2015 10:04:55 +0100
Message-ID: <20150520090455.GC29274@red-moon>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
 <20150520084441.GA29274@red-moon>
 <555C4C0D.4040605@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37291 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbbETJFA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 May 2015 05:05:00 -0400
Content-Disposition: inline
In-Reply-To: <555C4C0D.4040605@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Ingo Molnar <mingo@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, May 20, 2015 at 09:55:41AM +0100, Tomeu Vizoso wrote:
> On 05/20/2015 10:44 AM, Lorenzo Pieralisi wrote:
> > On Tue, May 19, 2015 at 03:49:12PM +0100, Tomeu Vizoso wrote:
> >> This callback is expected to do the same as enter() but it has to
> >> guarantee that interrupts aren't enabled at any point in its execution,
> >> as the tick is frozen.
> >>
> >> It will be called when the system goes to suspend-to-idle and will
> >> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
> >>
> >> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
> >> for both the enter() and enter_freeze() callbacks.
> >>
> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> ---
> >>
> >> v3:	* Set CPUIDLE_FLAG_TIMER_STOP to simplify things as suggested by
> >> 	Lorenzo Pieralisi
> >> v2:	* Disable FIQs also when suspending-to-idle
> >> ---
> >>  arch/arm/mach-tegra/cpuidle-tegra114.c | 13 +++++++++----
> >>  1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
> >> index 155807f..7e59ac0 100644
> >> --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
> >> +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
> >> @@ -44,16 +44,12 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
> >>  	tegra_set_cpu_in_lp2();
> >>  	cpu_pm_enter();
> >>  
> >> -	tick_broadcast_enter();
> >> -
> >>  	call_firmware_op(prepare_idle);
> >>  
> >>  	/* Do suspend by ourselves if the firmware does not implement it */
> >>  	if (call_firmware_op(do_idle, 0) == -ENOSYS)
> >>  		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
> >>  
> >> -	tick_broadcast_exit();
> >> -
> >>  	cpu_pm_exit();
> >>  	tegra_clear_cpu_in_lp2();
> >>  
> >> @@ -61,6 +57,13 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
> >>  
> >>  	return index;
> >>  }
> >> +
> >> +static void tegra114_idle_enter_freeze(struct cpuidle_device *dev,
> >> +				       struct cpuidle_driver *drv,
> >> +				       int index)
> >> +{
> >> +       tegra114_idle_power_down(dev, drv, index);
> >> +}
> > 
> > You do not need this function, remove it and update the enter_freeze
> > pointer below with tegra114_idle_power_down please.
> 
> How so? The callbacks have different signatures.

Sorry, glossed over it, never mind.

Lorenzo

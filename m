From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH] ARM: tegra: cpuidle: implement cpuidle_state.enter_freeze()
Date: Thu, 16 Apr 2015 16:37:19 +0200
Message-ID: <CAAObsKAihF1k1yzZxQEs_jpPnCdV3HQbLaYHWu1QNsNd5zqiOg@mail.gmail.com>
References: <1428490480-10144-1-git-send-email-tomeu.vizoso@collabora.com>
 <20150408115546.GA24271@red-moon> <552643E1.3060200@collabora.com>
 <285738930.THBQOWvsah@vostro.rjw.lan> <20150410100844.GC23730@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36344 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbbDPOhl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 10:37:41 -0400
In-Reply-To: <20150410100844.GC23730@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 10 April 2015 at 12:08, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Thu, Apr 09, 2015 at 10:19:59PM +0100, Rafael J. Wysocki wrote:
>> On Thursday, April 09, 2015 11:18:25 AM Tomeu Vizoso wrote:
>> > On 04/08/2015 01:55 PM, Lorenzo Pieralisi wrote:
>> > > On Wed, Apr 08, 2015 at 11:54:38AM +0100, Tomeu Vizoso wrote:
>> > >> This callback is expected to do the same as enter() only that all
>> > >> non-wakeup IRQs are expected to be disabled.
>> > >
>> > > This is not true or at least it is misworded. The enter_freeze() function
>> > > is expected to return from the state with IRQs disabled at CPU level, or
>> > > put it differently it must not re-enable IRQs while executing since the
>> > > tick is frozen.
>> >
>> > True, only that it mentions interrupts in general, not just IRQs (I
>> > don't know if the terminology used in the base code matches the one in
>> > ARM's documentation).
>> >
>> > /*
>> >  * CPUs execute ->enter_freeze with the local tick or entire timekeeping
>> >  * suspended, so it must not re-enable interrupts at any point (even
>> >  * temporarily) or attempt to change states of clock event devices.
>> >  */
>>
>> This means interrupts on the local CPU (ie. the thing done by local_irq_disable()).
>>
>> > >> It will be called when the system goes to suspend-to-idle and will
>> > >> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
>> > >>
>> > >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> > >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > >> ---
>> > >>  arch/arm/mach-tegra/cpuidle-tegra114.c | 31 ++++++++++++++++++++++++-------
>> > >>  1 file changed, 24 insertions(+), 7 deletions(-)
>> > >>
>> > >> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
>> > >> index f2b586d..ef06001 100644
>> > >> --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
>> > >> +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
>> > >> @@ -39,28 +39,44 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
>> > >>                                      struct cpuidle_driver *drv,
>> > >>                                      int index)
>> > >>  {
>> > >> -        local_fiq_disable();
>> > >> -
>> > >>          tegra_set_cpu_in_lp2();
>> > >>          cpu_pm_enter();
>> > >>
>> > >> -        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
>> > >> -
>> > >>          call_firmware_op(prepare_idle);
>> > >>
>> > >>          /* Do suspend by ourselves if the firmware does not implement it */
>> > >>          if (call_firmware_op(do_idle, 0) == -ENOSYS)
>> > >>                  cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
>> > >>
>> > >> -        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
>> > >> -
>> > >>          cpu_pm_exit();
>> > >>          tegra_clear_cpu_in_lp2();
>> > >>
>> > >> +        return index;
>> > >> +}
>> > >> +
>> > >> +static int tegra114_idle_enter(struct cpuidle_device *dev,
>> > >> +                               struct cpuidle_driver *drv,
>> > >> +                               int index)
>> > >> +{
>> > >> +        local_fiq_disable();
>> > >> +
>> > >> +        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
>> > >> +
>> > >> +        index = tegra114_idle_power_down(dev, drv, index);
>> > >> +
>> > >> +        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
>> > >> +
>> > >>          local_fiq_enable();
>> > >>
>> > >>          return index;
>> > >>  }
>> > >> +
>> > >> +static void tegra114_idle_enter_freeze(struct cpuidle_device *dev,
>> > >> +                                       struct cpuidle_driver *drv,
>> > >> +                                       int index)
>> > >> +{
>> > >> +        tegra114_idle_power_down(dev, drv, index);
>> > >
>> > > Cool. So if the problem is FIQs, you don't disabled them on entry
>> > > which means you enter the "frozen" state with FIQs enabled and tick frozen,
>> > > unless I am missing something.
>> >
>> > I have gone a bit deeper in the code and that's correct, AFAICS.
>> >
>> > > The question here is: are we allowed to enable FIQs before returning
>> > > from an enter_freeze() call (and to enter it with FIQs enabled) ?
>> > >
>> > > If we are not your code here certainly does not solve the issue, since
>> > > it does _not_ disable FIQs upon enter_freeze call anyway.
>> >
>> > I think doing that would go against the wording of the comment I quoted
>> > above, so I see two ways of fixing this:
>> >
>> > * Change the wording to refer to normal IRQs and leave the task of
>> > enabling and disabling FIQs to the enter_freeze implementation (ugly and
>> > I don't see any good reason for this)
>> >
>> > * Have FIQs already disabled when enter_freeze gets called, probably by
>> > having arch_cpu_idle_enter do it on ARM (and the inverse in
>> > arch_cpu_idle_exit)?
>> >
>> > Rafael, what's your opinion on this?
>>
>> I don't know what FIQs are. :-)
>
> In short, fast IRQs, it is a separate IRQ line handled as a separate
> exception source with some private (banked) registers that minimize registers
> saving/restoring. They are not identical to NMI on x86, since
> their behaviour (handling) may be overriden by platforms and they
> can be masked.
>
>> ->enter_freeze is entered with interrupts disabled on the local CPU.  It is
>> not supposed to re-enable them.  That is, while in the ->enter_freeze callback
>> routine, the CPU must not be interrupted aby anything other than NMI.
>
> It boils down to what FIQs handlers are allowed to do with tick frozen
> and what they are (may be) currently used for.
>
> Russell has more insights on this than I do, in particular what FIQs are
> currently used for on ARM and if we can leave them enabled safely with tick
> frozen.

But even if it's currently safe to leave them enabled, is there any
reason for not disabling them?

Regards,

Tomeu

> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

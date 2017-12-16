From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Sat, 16 Dec 2017 03:34:16 +0100
Message-ID: <4909797.WBZJ1MzWze@aspire.rjw.lan>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <25c78d66-9c2a-012c-6574-a687519d4820@tu-dresden.de> <001b01d375c0$07738c20$165aa460$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62966 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755978AbdLPCfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 21:35:02 -0500
In-Reply-To: <001b01d375c0$07738c20$165aa460$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Len Brown' <lenb@kernel.org>, 'Yu Chen' <yu.c.chen@intel.com>, 'Marcus =?ISO-8859-1?Q?H=E4hnel=27?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, 'Robert =?ISO-8859-1?Q?Sch=F6ne=27?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>

On Friday, December 15, 2017 5:16:08 PM CET Doug Smythies wrote:
> On 2017.12.15 06:23 Rafael J. Wysocki wrote:
> > On Fri, Dec 15, 2017 at 11:44 AM, Thomas Ilsche wrote:
> >
> >> we just saw very bad Powernightmares on a freshly installed dual socket 36
> >> core
> 
> During the gap in this thread, I have seen some pretty bad ones also, but
> not to the magnitude that you do.
> 
> > Can you please refrain from using marketing language for describing
> > technical issues?
> 
> Ugh oh. I have just changed my web notes on this to use that term.
> 
> >> This issue is probably wasting a couple Megawatts globally,
> 
> I agree that there appears to be significant energy that can be saved.
> 
> >> I like to reinforce the offer
> >> to help develop and test a patch,
> 
> Me also, however and as previously mentioned, I am stuck.
> 
> >> We acknowledge your suggestion to keep the scheduling ticks running instead
> >> of using an additional fallback timer. Still, we need a solution with
> >> manageable code changes without tightly coupling different software layers.
> >> Unfortunately, the tick-timer is disabled early in the outer idle-loop in
> >> do_idle(), but the C-state decision is taken in the governor.
> >>
> >> In your opinion, what is the best solution?
> >> (a) re-enable the tick-timer? (not a very clean solution)
> >> (b) moving the tick-timer disabling?
> >
> > Yes.
> >
> >> (could be very intrusive in terms of LOC,
> >> we have no overview on which assumptions would break if we do this)
> >
> > Regardless, this is the long-term way to go IMO not just to address
> > this issue, but also to avoid unneeded overhead of stopping the tick.
> >
> > The tick should only be stopped when we know for a fact that it is
> > worth the overhead which is only when we know that the target
> > residency of the idle state we want to enter is longer than the time
> > to the next tick.  Note that this doesn't depend on the idle governor
> > in use at all.
> >
> > And since this is the long-term way to go anyway, why don't we just do
> > it right away?
> 
> Maybe that would also solve the C0 problem, I don't know.

It should mitigate it somehwat at least, because it would add an upper bound
on the idle time for states with target residencies below the length of the
tick period.

We may need something on top of it, though.

> >>
> >> Regarding the C0/poll_idle problem, what is suitable as abort criterion:
> >> (a) interrupt counts
> >> (b) tick_nohz_get_sleep_length
> >> (c) tick_sched->idle_expires
> >
> > Can you please remind me what that problem is exactly?
> 
> The C0 version of the problem is what I have been investigating for a long time
> now. 
> 
> In an off-list e-mail, Yu claims to have found the root issue. I disagree that
> it explains all the long poll_idle scenarios I have found. Obviously, I would
> test any patch when available.
> 
> The problem is within the main loop of drivers/cpuidle/poll_state.c:
> 
>                 while (!need_resched())
>                         cpu_relax();
> 
> because not all isr's set the need_resched flag, and therefore it can end up
> sitting in that loop for multiple seconds, instead of the expected few uSecs.

I see, thanks!

> You may or may not recall that my main test scenario for this is a 100% load
> on one CPU. Typically I observe something like for every unit of time
> properly spent in idle state 0, the most energy costly idle state,
> roughly 60,000 units of time are spent incorrectly in idle state 0, wasting
> energy. Testing needs to done over hours, because the issue tends to come
> in clusters being aggravated by some sort of beat frequencies
> between events.
> 
> My proposed solution was this:
> 
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 7416b16..4d17d3d 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -5,16 +5,31 @@
>   */
> 
>  #include <linux/cpuidle.h>
> +#include <linux/tick.h>
>  #include <linux/sched.h>
>  #include <linux/sched/idle.h>
> 
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>                                struct cpuidle_driver *drv, int index)
>  {
> +       unsigned int next_timer_us, i;
> +
>         local_irq_enable();
>         if (!current_set_polling_and_test()) {
> -               while (!need_resched())
> +               while (!need_resched()){
>                         cpu_relax();
> +
> +                       /* Occasionally check for a new and long expected residency time. */
> +                       if (!(i++ % 1024)) {
> +                               local_irq_disable();
> +                               next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
> +                               local_irq_enable();
> +                               /* need a better way to get threshold, including large margin */
> +                               /* We are only trying to catch really bad cases here.         */
> +                               if (next_timer_us > 100)
> +                               break;
> +                       }
> +               }
>         }
>         current_clr_polling();
> 
> However,
> I do not like that I am disabling and re-enabling local interrupts in some loop,
> albeit only once per 1024 main loops. I do not know if there is another way to get
> the same information without disabling interrupts.

It need not be the same information.

I think you could just set a static time limit for staying in that loop.

> I have not been able to figure out how to replace my "100" microseconds arbitrary
> exit condition with some useful, machine specific exit criteria.

I would make it a fraction of the tick period or similar.

Anyway, as I said above, I would defer playing with this till after the
tick-related changes are made.

Thanks,
Rafael

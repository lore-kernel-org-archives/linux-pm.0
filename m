From: leo.yan@linaro.org
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
Date: Fri, 10 Aug 2018 13:53:45 +0800
Message-ID: <20180810055345.GA11817@leoy-ThinkPad-X240s>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
 <20180809162957.GD14362@leoy-ThinkPad-X240s>
 <CAJZ5v0it0XM29OGnNfanrRAH3E8uHkJjXVwgHBQRiT9aZ0747A@mail.gmail.com>
 <8620035.OlGfqWSkfk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8620035.OlGfqWSkfk@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 09, 2018 at 11:31:46PM +0200, Rafael J . Wysocki wrote:

[...]

> > >> And I really would prefer to avoid restarting the tick here, because
> > >> it is overhead and quite likely unnecessary.
> > >
> > > I understand the logic when read the code, actually I did some experiments
> > > on the function menu_select(), in menu_select() function it discards the
> > > consideration for typical pattern interval and it also tries to avoid to
> > > enable tick and select more shallow state at the bottom of function.  So I
> > > agree that in the middle of idles it's redundant to reenable tick and the
> > > code is careful thought.
> > >
> > > But this patch tries to rescue the case at the last time the CPU enter one
> > > shallow idle state but without wake up event.
> > 
> > It is better to avoid entering a shallow state IMO.  Let me think
> > about that a bit.
> 
> The simple change below should address this issue and I don't quite see
> what it can break.  It may cause deeper idle states to be selected with
> the tick already stopped, but that really shouldn't be problematic, as
> (since the tick has been stopped) there are no strict latency constraints,
> so even if there is an early wakeup, we should be able to tolerate the
> extra latency just fine.
> 
> ---
>  drivers/cpuidle/governors/menu.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -349,14 +349,12 @@ static int menu_select(struct cpuidle_dr
>  		 * If the tick is already stopped, the cost of possible short
>  		 * idle duration misprediction is much higher, because the CPU
>  		 * may be stuck in a shallow idle state for a long time as a
> -		 * result of it.  In that case say we might mispredict and try
> -		 * to force the CPU into a state for which we would have stopped
> -		 * the tick, unless a timer is going to expire really soon
> -		 * anyway.
> +		 * result of it.  In that case say we might mispredict and use
> +		 * the known time to the closest timer event for the idle state
> +		 * selection.
>  		 */
>  		if (data->predicted_us < TICK_USEC)
> -			data->predicted_us = min_t(unsigned int, TICK_USEC,
> -						   ktime_to_us(delta_next));
> +			data->predicted_us = ktime_to_us(delta_next);

I did the testing on this, but above change cannot really resolve the
issue, it misses to handle the case if 'data->predicted_us > TICK_USEC';
if the prediction is longer than TICK_USEC, e.g. data->predicted_us is
2ms, TICK_USEC=1ms;  for this case the deepest state will not be
chosen and if the data->predicted_us is decided by typical pattern
value but not the closest timer, finally the CPU still might stay in
shallow state for long time.

Actually in the CPU idle loop with the tick is stopped, I think we
should achieve two targets:
- Ensure the CPU can enter the deepest idle state at the last time it
  runs into into idle;
- In the middle of idles, we will not reenable the tick at all; though
  the idle states can be chosen a shallow state for short prediction;

To achieve the first target, we need to define what's the possible
case the CPU might stay into shallow state but cannot be waken up in
short time; so for this purpose it's pointeless to compare the value
between 'data->predicted_us' and TICK_USEC, so I'd like to check if
the next timer event is reliable to wake up CPU in short time, this
can be finished by comparison between 'ktime_to_us(delta_next)' with
maximum target residency;

For the second target, we should not enable the tick again in the idle
loop after the tick is stopped, whatever the governor choose any idle
state.

So how about below changes?  I did some verify on this.

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 30ab759..e2de7c2 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -351,18 +351,21 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	data->predicted_us = min(data->predicted_us, expected_interval);
 
 	if (tick_nohz_tick_stopped()) {
+		unsigned int delta_next_us = ktime_to_us(delta_next);
+
 		/*
 		 * If the tick is already stopped, the cost of possible short
 		 * idle duration misprediction is much higher, because the CPU
 		 * may be stuck in a shallow idle state for a long time as a
-		 * result of it.  In that case say we might mispredict and try
-		 * to force the CPU into a state for which we would have stopped
-		 * the tick, unless a timer is going to expire really soon
-		 * anyway.
+		 * result of it.  If the next timer event is later than the
+		 * maximum target residency, this means the timer event is not
+		 * trusted to wake up CPU in short term and the typical pattern
+		 * interval or other factors might lead to a shallow state, in
+		 * that case say we might mispredict and use the known time to
+		 * the closest timer event for the idle state selection.
 		 */
-		if (data->predicted_us < TICK_USEC)
-			data->predicted_us = min_t(unsigned int, TICK_USEC,
-						   ktime_to_us(delta_next));
+		if (delta_next_us >= drv->states[drv->state_count-1].target_residency)
+			data->predicted_us = delta_next_us;
 	} else {
 		/*
 		 * Use the performance multiplier and the user-configurable
@@ -410,12 +413,12 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * expected idle duration is shorter than the tick period length.
 	 */
 	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    expected_interval < TICK_USEC) {
+	    (!tick_nohz_tick_stopped() && expected_interval < TICK_USEC)) {
 		unsigned int delta_next_us = ktime_to_us(delta_next);
 
 		*stop_tick = false;
 
-		if (!tick_nohz_tick_stopped() && idx > 0 &&
+		if (idx > 0 &&
 		    drv->states[idx].target_residency > delta_next_us) {
 			/*
 			 * The tick is not going to be stopped and the target

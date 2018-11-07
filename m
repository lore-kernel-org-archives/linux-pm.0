From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] irq/timings: Fix model validity
Date: Wed, 7 Nov 2018 11:52:31 +0100
Message-ID: <ab9e60d7-e2d3-7d0c-dbf1-c0bed7bdb516@linaro.org>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
 <20181107085936.GI9781@hirez.programming.kicks-ass.net>
 <20181107094624.GB9828@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107094624.GB9828@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 07/11/2018 10:46, Peter Zijlstra wrote:
> On Wed, Nov 07, 2018 at 09:59:36AM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 07, 2018 at 12:39:31AM +0100, Rafael J. Wysocki wrote:
> 
>>> In general, however, I need to be convinced that interrupts that
>>> didn't wake up the CPU from idle are relevant for next wakeup
>>> prediction.  I see that this may be the case, but to what extent is
>>> rather unclear to me and it looks like calling
>>> irq_timings_next_event() would add considerable overhead.
>>
>> How about we add a (debug) knob so that people can play with it for now?
>> If it turns out to be useful, we'll learn.
> 
> That said; Daniel, I think there is a problem with how irqs_update()
> sets irqs->valid. We seem to set valid even when we're still training.

Yes, the fix seems right.

Thanks for fixing it.

  -- Daniel

> ---
> Subject: irq/timings: Fix model validity
> 
> The per IRQ timing predictor will produce a 'valid' prediction even if
> the model is still training. This should not happen.
> 
> Fix this by moving the actual training (online stddev algorithm) up a
> bit and returning early (before predicting) when we've not yet reached
> the sample threshold.
> 
> A direct concequence is that the predictor will only ever run with at
> least that many samples, which means we can remove one branch.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/irq/timings.c | 66 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
> index 1e4cb63a5c82..5d22fd5facd5 100644
> --- a/kernel/irq/timings.c
> +++ b/kernel/irq/timings.c
> @@ -28,6 +28,13 @@ struct irqt_stat {
>  	int	valid;
>  };
>  
> +/*
> + * The rule of thumb in statistics for the normal distribution
> + * is having at least 30 samples in order to have the model to
> + * apply.
> + */
> +#define SAMPLE_THRESHOLD	30
> +
>  static DEFINE_IDR(irqt_stats);
>  
>  void irq_timings_enable(void)
> @@ -101,7 +108,6 @@ void irq_timings_disable(void)
>   * distribution appears when the number of samples is 30 (it is the
>   * rule of thumb in statistics, cf. "30 samples" on Internet). When
>   * there are three consecutive anomalies, the statistics are resetted.
> - *
>   */
>  static void irqs_update(struct irqt_stat *irqs, u64 ts)
>  {
> @@ -146,11 +152,38 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>  	 */
>  	diff = interval - irqs->avg;
>  
> +	/*
> +	 * Online average algorithm:
> +	 *
> +	 *  new_average = average + ((value - average) / count)
> +	 *
> +	 * The variance computation depends on the new average
> +	 * to be computed here first.
> +	 *
> +	 */
> +	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
> +
> +	/*
> +	 * Online variance algorithm:
> +	 *
> +	 *  new_variance = variance + (value - average) x (value - new_average)
> +	 *
> +	 * Warning: irqs->avg is updated with the line above, hence
> +	 * 'interval - irqs->avg' is no longer equal to 'diff'
> +	 */
> +	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
> +
>  	/*
>  	 * Increment the number of samples.
>  	 */
>  	irqs->nr_samples++;
>  
> +	/*
> +	 * If we're still training the model, we can't make any predictions yet.
> +	 */
> +	if (irqs->nr_samples < SAMPLE_THRESHOLD)
> +		return;
> +
>  	/*
>  	 * Online variance divided by the number of elements if there
>  	 * is more than one sample.  Normally the formula is division
> @@ -158,16 +191,12 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>  	 * more than 32 and dividing by 32 instead of 31 is enough
>  	 * precise.
>  	 */
> -	if (likely(irqs->nr_samples > 1))
> -		variance = irqs->variance >> IRQ_TIMINGS_SHIFT;
> +	variance = irqs->variance >> IRQ_TIMINGS_SHIFT;
>  
>  	/*
> -	 * The rule of thumb in statistics for the normal distribution
> -	 * is having at least 30 samples in order to have the model to
> -	 * apply. Values outside the interval are considered as an
> -	 * anomaly.
> +	 * Values outside the interval are considered as an anomaly.
>  	 */
> -	if ((irqs->nr_samples >= 30) && ((diff * diff) > (9 * variance))) {
> +	if ((diff * diff) > (9 * variance)) {
>  		/*
>  		 * After three consecutive anomalies, we reset the
>  		 * stats as it is no longer stable enough.
> @@ -191,27 +220,6 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>  	 */
>  	irqs->valid = 1;
>  
> -	/*
> -	 * Online average algorithm:
> -	 *
> -	 *  new_average = average + ((value - average) / count)
> -	 *
> -	 * The variance computation depends on the new average
> -	 * to be computed here first.
> -	 *
> -	 */
> -	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
> -
> -	/*
> -	 * Online variance algorithm:
> -	 *
> -	 *  new_variance = variance + (value - average) x (value - new_average)
> -	 *
> -	 * Warning: irqs->avg is updated with the line above, hence
> -	 * 'interval - irqs->avg' is no longer equal to 'diff'
> -	 */
> -	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
> -
>  	/*
>  	 * Update the next event
>  	 */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

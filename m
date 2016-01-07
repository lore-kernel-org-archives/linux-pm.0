From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Thu, 7 Jan 2016 16:42:58 +0100
Message-ID: <568E8782.9020401@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
 <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.20.1601061156120.1652@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35422 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbcAGPnD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2016 10:43:03 -0500
Received: by mail-wm0-f50.google.com with SMTP id f206so102216783wmf.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2016 07:43:02 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1601061156120.1652@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On 01/06/2016 06:40 PM, Nicolas Pitre wrote:
> On Wed, 6 Jan 2016, Daniel Lezcano wrote:
>
>> Many IRQs are quiet most of the time, or they tend to come in bursts=
 of
>> fairly equal time intervals within each burst. It is therefore possi=
ble
>> to detect those IRQs with stable intervals and guestimate when the n=
ext
>> IRQ event is most likely to happen.
>>
>> Examples of such IRQs may include audio related IRQs where the FIFO =
size
>> and/or DMA descriptor size with the sample rate create stable interv=
als,
>> block devices during large data transfers, etc.  Even network stream=
ing
>> of multimedia content creates patterns of periodic network interface=
 IRQs
>> in some cases.
>>
>> This patch adds code to track the mean interval and variance for eac=
h IRQ
>> over a window of time intervals between IRQ events. Those statistics=
 can
>> be used to assist cpuidle in selecting the most appropriate sleep st=
ate
>> by predicting the most likely time for the next interrupt.
>>
>> Because the stats are gathered in interrupt context, the core comput=
ation
>> is as light as possible.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> There are still a few problems with this patch.
>
> Please see comments below.

[ ... ]

>> +/**
>> + * stats_variance - compute the variance
>> + *
>> + * @s: the statistic structure
>> + *
>> + * Returns an u64 corresponding to the variance, or zero if there i=
s
>> + * no data
>> + */
>> +static u64 stats_variance(struct stats *s, u32 mean)
>> +{
>> +	int i;
>> +	u64 variance =3D 0;
>> +
>> +	/*
>> +	 * The variance is the sum of the squared difference to the
>> +	 * average divided by the number of elements.
>> +	 */
>> +	for (i =3D 0; i < STATS_NR_VALUES; i++) {
>> +		s32 diff =3D s->values[i] - mean;
>> +		variance +=3D (u64)diff * diff;
>
> Strictly speaking, diff should be casted to s64 as it is a signed val=
ue
> that may actually be negative.  Because of the strange C type promoti=
on
> rules, the generated code appears correct (at least on ARM), but it
> would be clearer to use s64 anyway.

I don't get the connection in your explanation of why it should be a=20
s64. It is already a signed s32, s->values[] are s32 and mean is u32.

What would be the benefit to convert diff to s64 ?

> The product will end up being positive in all cases of course so
> variance may remain as a u64.
>

[ ... ]

>> +static ktime_t next_irq_event(void)
>> +{
>> +	unsigned int irq, cpu =3D raw_smp_processor_id();
>> +	ktime_t diff, next, min =3D { .tv64 =3D KTIME_MAX };
>
> To avoid exposing the ktime_t definition, you should use
> ktime_set(KTIME_SEC_MAX, 0) instead of { .tv64 =3D KTIME_MAX }.

Ok.

>> +	struct wakeup *w;
>> +	u32 interval, mean;
>> +	u64 variance;
>> +
>> +	/*
>> +	 * Lookup the interrupt array for this cpu and search for the
>> +	 * earlier expected interruption.
>> +	 */
>> +        for (irq =3D 0; irq < NR_IRQS; irq++) {
>> +
>> +		ktime_t now =3D ktime_get();
>
> ktime_get() is potentially non-trivial. It should be plenty good enou=
gh
> to call it only once outside the loop.

Ok.

>> +		w =3D per_cpu(wakeups[irq], cpu);
>> +
>> +		/*
>> +		 * The interrupt was not setup as a source of a wakeup
>> +		 * or the wakeup source is not considered at this
>> +		 * moment stable enough to do a prediction.
>> +		 */
>> +		if (!w)
>> +			continue;
>> +
>> +		/*
>> +		 * No statistics available yet.
>> +		 */
>> +		if (ktime_equal(w->timestamp, ktime_set(0, 0)))
>> +			continue;
>> +
>> +		diff =3D ktime_sub(now, w->timestamp);
>> +
>> +		/*
>> +		 * There is no point attempting predictions on interrupts more
>> +		 * than 1 second apart. This has no benefit for sleep state
>> +		 * selection and increases the risk of overflowing our variance
>> +		 * computation. Reset all stats in that case.
>> +		 */
>> +		if (unlikely(ktime_after(diff, ktime_set(1, 0)))) {
>> +			stats_reset(&w->stats);
>> +			continue;
>> +		}
>
> The above is wrong. It is not computing the interval between successi=
ve
> interruts but rather the interval between the last interrupt occurren=
ce
> and the present time (i.e. when we're about to go idle).  This won't
> prevent interrupt intervals greater than one second from being summed
> and potentially overflowing the variance if this code is executed les=
s
> than a second after one such IRQ interval.  This test should rather b=
e
> performed in sched_idle_irq().

Ok, I will move it.

>> +		 * If the mean value is null, just ignore this wakeup
>> +		 * source.
>> +		 */
>> +		mean =3D stats_mean(&w->stats);
>> +		if (!mean)
>> +			continue;
>> +
>> +		variance =3D stats_variance(&w->stats, mean);
>> +		/*
>> +		 * We want to check the last interval is:
>> +		 *
>> +		 *  mean - stddev < interval < mean + stddev
>> +		 *
>> +		 * That simplifies to:
>> +		 *
>> +		 * -stddev < interval - mean < stddev
>> +		 *
>> +		 * abs(interval - mean) < stddev
>> +		 *
>> +		 * The standard deviation is the sqrt of the variance:
>> +		 *
>> +		 * abs(interval - mean) < sqrt(variance)
>> +		 *
>> +		 * and we want to prevent to do an sqrt, so we square
>> +		 * the equation:
>> +		 *
>> +		 * (interval - mean)^2 < variance
>> +		 *
>> +		 * So if the latest value of the stats complies with
>> +		 * this condition, then the wakeup source is
>> +		 * considered predictable and can be used to predict
>> +		 * the next event.
>> +		 */
>> +		interval =3D w->stats.values[(w->stats.w_ptr + 1) % STATS_NR_VALU=
ES];
>
> But here (w->stats.w_ptr + 1) % STATS_NR_VALUES does not point at the
> last interval. It rather points at the second oldest.
> To make things simpler, you should rather pre-increment the pointer
> before updating the array in stats_add(), and here the value you want
> will directly be accessible with w->stats.values[w->stats.w_ptr].

Yeah, there is a glitch here. I will look at it.

>> +		if ((u64)((interval - mean) * (interval - mean)) > variance)
>> +			continue;
>
> Same comment as in stats_variance(): this should be s64.
>
>> +		/*
>> +		 * Let's compute the next event: the wakeup source is
>> +		 * considered predictable, we add the average interval
>> +		 * time added to the latest interruption event time.
>> +		 */
>> +		next =3D ktime_add_us(w->timestamp, stats_mean(&w->stats));
>> +
>> +		/*
>> +		 * If the interrupt is supposed to happen before the
>> +		 * minimum time, then it becomes the minimum.
>> +		 */
>> +		if (ktime_before(next, min))
>> +			min =3D next;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we have our prediction but the caller is
>> +	 * expecting the remaining time before the next event, so
>> +	 * compute the expected sleep length.
>> +	 */
>> +	diff =3D ktime_sub(min, ktime_get());
>
> You should use the variable 'now' rather than asking for the current
> time again.

Yep.

>> +	/*
>> +	 * The result could be negative for different reasons:
>> +	 *  - the prediction is incorrect
>> +	 *  - the prediction was too near now and expired while we were
>> +	 *    in this function
>> +	 *
>> +	 * In both cases, we return KTIME_MAX as a failure to do a
>> +	 * prediction
>> +	 */
>> +	if (ktime_compare(diff, ktime_set(0, 0)) <=3D 0)
>> +		return (ktime_t){ .tv64 =3D KTIME_MAX };
>
> See my comment about ktime_t internals at the beginning of this
> function.

Ok.

Thanks for the review.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


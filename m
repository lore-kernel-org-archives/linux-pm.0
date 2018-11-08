From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] irq/timings: Fix model validity
Date: Thu, 8 Nov 2018 09:10:26 +0100
Message-ID: <c9d8152a-566e-7ae6-e41c-5817c884c277@linaro.org>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
 <20181107085936.GI9781@hirez.programming.kicks-ass.net>
 <20181107094624.GB9828@hirez.programming.kicks-ass.net>
 <ab9e60d7-e2d3-7d0c-dbf1-c0bed7bdb516@linaro.org>
 <20181107130507.GD9761@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107130507.GD9761@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 07/11/2018 14:05, Peter Zijlstra wrote:
> On Wed, Nov 07, 2018 at 11:52:31AM +0100, Daniel Lezcano wrote:
>>> @@ -146,11 +152,38 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>>>  	 */
>>>  	diff = interval - irqs->avg;
>>>  
>>> +	/*
>>> +	 * Online average algorithm:
>>> +	 *
>>> +	 *  new_average = average + ((value - average) / count)
>>> +	 *
>>> +	 * The variance computation depends on the new average
>>> +	 * to be computed here first.
>>> +	 *
>>> +	 */
>>> +	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
>>> +
>>> +	/*
>>> +	 * Online variance algorithm:
>>> +	 *
>>> +	 *  new_variance = variance + (value - average) x (value - new_average)
>>> +	 *
>>> +	 * Warning: irqs->avg is updated with the line above, hence
>>> +	 * 'interval - irqs->avg' is no longer equal to 'diff'
>>> +	 */
>>> +	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
>>> +
>>>  	/*
>>>  	 * Increment the number of samples.
>>>  	 */
>>>  	irqs->nr_samples++;
> 
> FWIW, I'm confused on this. The normal (Welford's) online algorithm
> does:
> 
> 	count++;
> 	delta = value - mean;
> 	mean += delta / count;
> 	M2 += delta * (value - mean);
> 
> But the above uses:
> 
> 	mean += delta / 32;
> 
> Which, for count >> 32, over-estimates the mean adjustment. But worse,
> it significantly under-estimates the mean during training.
> 
> How is the computed variance still correct with this? I can not find any
> comments that clarifies this. I'm thinking that since the mean will
> slowly wander towards it's actual location (assuming an actual standard
> distribution input) the resulting variance will be far too large, since
> the (value - mean) term will be much larger than 'expected'.

You are right, initially it was divided by min(count, 32) but for
optimization reason, we decided to change that by a power of two
constant assuming the number of samples will reach quickly 32 and the
compiler will replace that by a shift.

https://lkml.org/lkml/2017/3/23/696

>>> @@ -158,16 +191,12 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>>>  	 * more than 32 and dividing by 32 instead of 31 is enough
>>>  	 * precise.
>>>  	 */
>>> +	variance = irqs->variance >> IRQ_TIMINGS_SHIFT;
> 
> Worse; variance is actually (as the comment states):
> 
> 	s^2 = M2 / (count -1)
> 
> But instead you compute:
> 
> 	s^2 = M2 / 32;
> 
> Which is again much larger than the actual result; assuming count >> 32.
> 
> So you compute a variance that is inflated in two different ways.
> 
> 
> I'm not seeing how this thing works reliably.

I have to revisit this part of code soon, I will double check that.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

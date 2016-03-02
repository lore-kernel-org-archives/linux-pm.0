From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Wed, 2 Mar 2016 18:58:25 +0100
Message-ID: <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<1842158.0Xhak3Uaac@vostro.rjw.lan>
	<CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33200 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbcCBR63 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 12:58:29 -0500
In-Reply-To: <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>

On Wed, Mar 2, 2016 at 6:10 PM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> Hi Rafael,
>
>
> On 2 March 2016 at 03:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Add a new cpufreq scaling governor, called "schedutil", that uses
>> scheduler-provided CPU utilization information as input for making
>> its decisions.
>>
>> Doing that is possible after commit fe7034338ba0 (cpufreq: Add
>> mechanism for registering utilization update callbacks) that
>> introduced cpufreq_update_util() called by the scheduler on
>> utilization changes (from CFS) and RT/DL task status updates.
>> In particular, CPU frequency scaling decisions may be based on
>> the the utilization data passed to cpufreq_update_util() by CFS.
>>
>> The new governor is relatively simple.
>>
>> The frequency selection formula used by it is essentially the same
>> as the one used by the "ondemand" governor, although it doesn't use
>> the additional up_threshold parameter, but instead of computing the
>> load as the "non-idle CPU time" to "total CPU time" ratio, it takes
>> the utilization data provided by CFS as input.  More specifically,
>> it represents "load" as the util/max ratio, where util and max
>> are the utilization and CPU capacity coming from CFS.
>>
>
> [snip]
>
>> +
>> +static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>> +                               unsigned long util, unsigned long max,
>> +                               unsigned int next_freq)
>> +{
>> +       struct cpufreq_policy *policy = sg_policy->policy;
>> +       unsigned int rel;
>> +
>> +       if (next_freq > policy->max)
>> +               next_freq = policy->max;
>> +       else if (next_freq < policy->min)
>> +               next_freq = policy->min;
>> +
>> +       sg_policy->last_freq_update_time = time;
>> +       if (sg_policy->next_freq == next_freq)
>> +               return;
>> +
>> +       sg_policy->next_freq = next_freq;
>> +       /*
>> +        * If utilization is less than max / 4, use RELATION_C to allow the
>> +        * minimum frequency to be selected more often in case the distance from
>> +        * it to the next available frequency in the table is significant.
>> +        */
>> +       rel = util < (max >> 2) ? CPUFREQ_RELATION_C : CPUFREQ_RELATION_L;
>> +       if (policy->fast_switch_possible) {
>> +               cpufreq_driver_fast_switch(policy, next_freq, rel);
>> +       } else {
>> +               sg_policy->relation = rel;
>> +               sg_policy->work_in_progress = true;
>> +               irq_work_queue(&sg_policy->irq_work);
>> +       }
>> +}
>> +
>> +static void sugov_update_single(struct update_util_data *data, u64 time,
>> +                               unsigned long util, unsigned long max)
>> +{
>> +       struct sugov_cpu *sg_cpu = container_of(data, struct sugov_cpu, update_util);
>> +       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>> +       unsigned int min_f, max_f, next_f;
>> +
>> +       if (!sugov_should_update_freq(sg_policy, time))
>> +               return;
>> +
>> +       min_f = sg_policy->policy->cpuinfo.min_freq;
>> +       max_f = sg_policy->policy->cpuinfo.max_freq;
>> +       next_f = util > max ? max_f : min_f + util * (max_f - min_f) / max;
>
> I think it has been pointed out in another email's thread but you
> should change the way the next_f is computed. util reflects the
> utilization of a CPU from 0 to its max compute capacity whereas
> ondemand was using the load at the current frequency during the last
> time window. I have understood that you want to keep same formula than
> ondemand as a starting point but you use a different input to
> calculate the next frequency so i don't see the rational of keeping
> this formula.

It is a formula that causes the entire available frequency range to be
utilized proportionally to the utilization as reported by the
scheduler (modulo the policy->min/max limits).  Its (significant IMO)
advantage is that it doesn't require any additional factors that would
need to be determined somehow.

> Saying that, even the simple formula next_f = util > max
> ? max_f : util * (max_f) / max will not work properly if the frequency
> invariance is enable because the utilization becomes capped by the
> current compute capacity so next_f will never be higher than current
> freq (unless a task move on the rq).  That was one reason of using a
> threshold in sched-freq proposal (and there are on going dev to try to
> solve this limitation).

Well, a different formula will have to be used along with frequency
invariance, then.

> IIIUC, frequency invariance is not enable on your platform so you have
> not seen the problem but you have probably see that selection of your
> next_f was not really stable. Without frequency invariance, the
> utilization will be overestimated when running at lower frequency so
> the governor will probably select a frequency that is higher than
> necessary but then the utilization will decrease at this higher
> frequency so the governor will probably decrease the frequency and so
> on until you found the right frequency that will generate the right
> utilisation value

I don't have any problems with that to be honest and if you aim at
selecting the perfect frequency at the first attempt, then good luck
with that anyway.

Now, I'm not saying that the formula used in this patch cannot be
improved or similar.  It very well may be possible to improve it.  I'm
only saying that it is good enough to start with, because of the
reasons mentioned above.

Still, if you can suggest to me what other formula specifically should
be used here, I'll consider using it.  Which will probably mean
comparing the two and seeing which one leads to better results.

Thanks,
Rafael

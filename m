From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 7/7][Resend] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Sat, 26 Mar 2016 03:05:19 +0100
Message-ID: <CAJZ5v0j=LwOT=sjSOwwzY=sYLqiV1tuvVazzgU+yMwMWXmpR8A@mail.gmail.com>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
	<6666532.7ULg06hQ7e@vostro.rjw.lan>
	<56F5E1F2.5090100@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56F5E1F2.5090100@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 26, 2016 at 2:12 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> Hi Rafael,
>
> On 03/21/2016 06:54 PM, Rafael J. Wysocki wrote:
> ...
>> +config CPU_FREQ_GOV_SCHEDUTIL
>> +     tristate "'schedutil' cpufreq policy governor"
>> +     depends on CPU_FREQ
>> +     select CPU_FREQ_GOV_ATTR_SET
>> +     select IRQ_WORK
>> +     help
>> +       The frequency selection formula used by this governor is analogous
>> +       to the one used by 'ondemand', but instead of computing CPU load
>> +       as the "non-idle CPU time" to "total CPU time" ratio, it uses CPU
>> +       utilization data provided by the scheduler as input.
>
> The formula's changed a bit from ondemand - can the formula description
> in the commit text be repackaged a bit and used here?

Right, I forgot to update this help text.

I'll figure out what to do here.

> ...
>> +
>> +static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>> +                             unsigned int next_freq)
>> +{
>> +     struct cpufreq_policy *policy = sg_policy->policy;
>> +
>> +     sg_policy->last_freq_update_time = time;
>> +
>> +     if (policy->fast_switch_enabled) {
>> +             if (next_freq > policy->max)
>> +                     next_freq = policy->max;
>> +             else if (next_freq < policy->min)
>> +                     next_freq = policy->min;
>
> The __cpufreq_driver_target() interface has this capping in it. For
> uniformity should this be pushed into cpufreq_driver_fast_switch()?

It could, but see below.

>> +
>> +             if (sg_policy->next_freq == next_freq) {
>> +                     trace_cpu_frequency(policy->cur, smp_processor_id());
>> +                     return;
>> +             }
>
> I fear this may bloat traces unnecessarily as there may be long
> stretches when a frequency domain is at the same frequency (especially
> fmin or fmax).

I put it here, because without it powertop reports that the CPU is
idle in situations like these.

> ...
>> +static unsigned int sugov_next_freq_shared(struct sugov_policy *sg_policy,
>> +                                        unsigned long util, unsigned long max)
>> +{
>> +     struct cpufreq_policy *policy = sg_policy->policy;
>> +     unsigned int max_f = policy->cpuinfo.max_freq;
>> +     u64 last_freq_update_time = sg_policy->last_freq_update_time;
>> +     unsigned int j;
>> +
>> +     if (util == ULONG_MAX)
>> +             return max_f;
>> +
>> +     for_each_cpu(j, policy->cpus) {
>> +             struct sugov_cpu *j_sg_cpu;
>> +             unsigned long j_util, j_max;
>> +             u64 delta_ns;
>> +
>> +             if (j == smp_processor_id())
>> +                     continue;
>> +
>> +             j_sg_cpu = &per_cpu(sugov_cpu, j);
>> +             /*
>> +              * If the CPU utilization was last updated before the previous
>> +              * frequency update and the time elapsed between the last update
>> +              * of the CPU utilization and the last frequency update is long
>> +              * enough, don't take the CPU into account as it probably is
>> +              * idle now.
>> +              */
>> +             delta_ns = last_freq_update_time - j_sg_cpu->last_update;
>> +             if ((s64)delta_ns > TICK_NSEC)
>
> Why not declare delta_ns as an s64 (also in suguv_should_update_freq)
> and avoid the cast?

I took this from __update_load_avg(), but it shouldn't matter here.

> ...
>> +static int sugov_limits(struct cpufreq_policy *policy)
>> +{
>> +     struct sugov_policy *sg_policy = policy->governor_data;
>> +
>> +     if (!policy->fast_switch_enabled) {
>> +             mutex_lock(&sg_policy->work_lock);
>> +
>> +             if (policy->max < policy->cur)
>> +                     __cpufreq_driver_target(policy, policy->max,
>> +                                             CPUFREQ_RELATION_H);
>> +             else if (policy->min > policy->cur)
>> +                     __cpufreq_driver_target(policy, policy->min,
>> +                                             CPUFREQ_RELATION_L);
>> +
>> +             mutex_unlock(&sg_policy->work_lock);
>> +     }
>
> Is the expectation that in the fast_switch_enabled case we should
> re-evaluate soon enough that an explicit fixup is not required here?

Yes, it is.

> I'm worried as to whether that will always be true given the possible
> criticality of applying frequency limits (thermal for example).

The part of the patch below that you cut actually takes care of that:

    sg_policy->need_freq_update = true;

which causes the rate limit to be ignored essentially, so the
frequency will be changed on the first update from the scheduler.
Which also is why the min/max check is before the sg_policy->next_freq
== next_freq check in sugov_update_commit().

I wanted to avoid locking in the fast switch/one CPU per policy case
which otherwise would be necessary just for the handling of this
thing.  I'd like to keep it the way it is unless it can be clearly
demonstrated that it really would lead to problems in practice in a
real system.

Thanks,
Rafael

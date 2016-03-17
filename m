From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 7/7][Update] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Thu, 17 Mar 2016 13:54:05 +0100
Message-ID: <CAJZ5v0j-NKveJEN9fuySrbWDy++rWKTr_QWLY3vcA7Df0e3rGQ@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<4088601.C2vItRYpQn@vostro.rjw.lan>
	<1711281.bPmSjlBT7c@vostro.rjw.lan>
	<18957412.GBWZqUOZtk@vostro.rjw.lan>
	<20160317113054.GG18212@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160317113054.GG18212@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 17, 2016 at 12:30 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi Rafael,
>
> On 17/03/16 01:01, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> [...]
>
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
>> +
>> +             if (sg_policy->next_freq == next_freq) {
>> +                     trace_cpu_frequency(policy->cur, smp_processor_id());
>> +                     return;
>> +             }
>> +             sg_policy->next_freq = next_freq;
>> +             next_freq = cpufreq_driver_fast_switch(policy, next_freq);
>> +             if (next_freq == CPUFREQ_ENTRY_INVALID)
>> +                     return;
>> +
>> +             policy->cur = next_freq;
>> +             trace_cpu_frequency(next_freq, smp_processor_id());
>> +     } else if (sg_policy->next_freq != next_freq) {
>> +             sg_policy->work_cpu = smp_processor_id();
>
>   +             sg_policy->next_freq = next_freq;
>

Doh.

>> +             irq_work_queue(&sg_policy->irq_work);
>> +     }
>> +}
>
> Or we remain at max_f :-).

Sure, thanks!

Will fix.

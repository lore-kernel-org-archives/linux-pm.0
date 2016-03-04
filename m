From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 9/10] cpufreq: sched: Re-introduce cpufreq_update_util()
Date: Fri, 4 Mar 2016 13:58:51 +0100
Message-ID: <CAJZ5v0inrkShx8EW=pyVxc60ykSyhRWp+t4by8=Qj7auSR=6Vw@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<2409306.qzzMXcm4dm@vostro.rjw.lan>
	<3276406.TfbasUEj6b@vostro.rjw.lan>
	<20160304105007.GB4061@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160304105007.GB4061@e106622-lin>
Sender: linux-acpi-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 4, 2016 at 11:50 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi Rafael,
>
> On 04/03/16 04:18, Rafael J. Wysocki wrote:
>
> [...]
>
>> +/**
>> + * cpufreq_update_util - Take a note about CPU utilization changes.
>> + * @time: Current time.
>> + * @util: CPU utilization.
>> + * @max: CPU capacity.
>> + *
>> + * This function is called on every invocation of update_load_avg() on the CPU
>> + * whose utilization is being updated.
>> + *
>> + * It can only be called from RCU-sched read-side critical sections.
>> + */
>> +void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
>> +{
>> +     struct freq_update_hook *hook;
>> +
>> +#ifdef CONFIG_LOCKDEP
>> +     WARN_ON(debug_locks && !rcu_read_lock_sched_held());
>> +#endif
>> +
>> +     hook = rcu_dereference(*this_cpu_ptr(&cpufreq_freq_update_hook));
>
> Small fix. You forgot to change this to rcu_dereference_sched() (you
> only fixed that in 01/10).

Yup, thanks!

I had to propagate the change throughout the queue and forgot about
the last step.

I'll send an updated patch shortly.

Thanks,
Rafael

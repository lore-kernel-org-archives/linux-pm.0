From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Wed, 10 Feb 2016 14:23:50 +0100
Message-ID: <CAJZ5v0gWV+Qc2CM6YN90=s+TE2HCDOZVCRH7nOrKFW+kGiOpDA@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<56B93548.9090006@linaro.org>
	<CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
	<5387313.xAhVpzgZCg@vostro.rjw.lan>
	<20160210123342.GA11415@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160210123342.GA11415@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 10, 2016 at 1:33 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi Rafael,
>
> On 09/02/16 21:05, Rafael J. Wysocki wrote:
>
> [...]
>
>> +/**
>> + * cpufreq_update_util - Take a note about CPU utilization changes.
>> + * @util: Current utilization.
>> + * @max: Utilization ceiling.
>> + *
>> + * This function is called by the scheduler on every invocation of
>> + * update_load_avg() on the CPU whose utilization is being updated.
>> + */
>> +void cpufreq_update_util(unsigned long util, unsigned long max)
>> +{
>> +     struct update_util_data *data;
>> +
>> +     rcu_read_lock();
>> +
>> +     data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
>> +     if (data && data->func)
>> +             data->func(data, cpu_clock(smp_processor_id()), util, max);
>
> Are util and max used anywhere?

They aren't yet, but they will be.

Maybe not in this cycle (it it takes too much time to integrate the
preliminary changes), but we definitely are going to use those
numbers.

Thanks,
Rafael

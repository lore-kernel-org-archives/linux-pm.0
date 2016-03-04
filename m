From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 9/10] cpufreq: sched: Re-introduce cpufreq_update_util()
Date: Fri, 4 Mar 2016 22:36:10 +0100
Message-ID: <CAJZ5v0ivhhSEGbWM5m9LYaATe2WtvwA4G68q4BGAdf8Wib11ZQ@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<2409306.qzzMXcm4dm@vostro.rjw.lan>
	<3276406.TfbasUEj6b@vostro.rjw.lan>
	<2165535.KMoOuEkF5Y@vostro.rjw.lan>
	<56D9FC66.9050201@linaro.org>
	<CAJZ5v0j1yCnW0M3XmFH4EHjJONwY3WASgvXZRFnbcggDcdUD7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j1yCnW0M3XmFH4EHjJONwY3WASgvXZRFnbcggDcdUD7g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 4, 2016 at 10:27 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Mar 4, 2016 at 10:21 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> On 03/04/2016 05:30 AM, Rafael J. Wysocki wrote:
>>> +void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
>>> +{
>>> +     struct freq_update_hook *hook;
>>> +
>>> +#ifdef CONFIG_LOCKDEP
>>> +     WARN_ON(debug_locks && !rcu_read_lock_sched_held());
>>> +#endif
>>> +
>>> +     hook = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_freq_update_hook));
>>> +     /*
>>> +      * If this isn't inside of an RCU-sched read-side critical section, hook
>>> +      * may become NULL after the check below.
>>> +      */
>>> +     if (hook) {
>>> +             if (hook->update_util)
>>> +                     hook->update_util(hook, time, util, max);
>>> +             else
>>> +                     hook->func(hook, time);
>>> +     }
>>
>> Is it worth having two hook types?
>
> Well, that's why I said "maybe over the top" in the changelog comments. :-)
>
> If we want to isolate the "old" governors from util/max entirely, then yes.
>
> If we don't care that much, then no.
>
> I'm open to both possibilities.

But in the latter case I don't see a particular reason to put the new
governor under kernel/sched/ too and as I wrote in the changelog
comments to patch [10/10], I personally think that it would be cleaner
to keep it under drivers/cpufreq/.

Thanks,
Rafael

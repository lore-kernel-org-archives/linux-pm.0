From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/10] cpufreq: Reduce cpufreq_update_util() overhead a bit
Date: Wed, 9 Mar 2016 15:17:48 +0100
Message-ID: <CAJZ5v0gt3tmJ1ZunvkLKfeUSgZv7yiO9vBDtDmXSuC=tUUpPLg@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<2409306.qzzMXcm4dm@vostro.rjw.lan>
	<1988425.XTpZIAJINa@vostro.rjw.lan>
	<20160309123956.GM6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160309123956.GM6356@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 9, 2016 at 1:39 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Mar 04, 2016 at 03:58:22AM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Use the observation that cpufreq_update_util() is only called
>> by the scheduler with rq->lock held, so the callers of
>> cpufreq_set_update_util_data() can use synchronize_sched()
>> instead of synchronize_rcu() to wait for cpufreq_update_util()
>> to complete.  Moreover, if they are updated to do that,
>> rcu_read_(un)lock() calls in cpufreq_update_util() might be
>> replaced with rcu_read_(un)lock_sched(), respectively, but
>> those aren't really necessary, because the scheduler calls
>> that function from RCU-sched read-side critical sections
>> already.
>>
>> In addition to that, if cpufreq_set_update_util_data() checks
>> the func field in the struct update_util_data before setting
>> the per-CPU pointer to it, the data->func check may be dropped
>> from cpufreq_update_util() as well.
>>
>> Make the above changes to reduce the overhead from
>> cpufreq_update_util() in the scheduler paths invoking it
>> and to make the cleanup after removing its callbacks less
>> heavy-weight somewhat.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>
>> Changes from the previous version:
>> - Use rcu_dereference_sched() in cpufreq_update_util().
>
> Which I think also shows the WARN_ON I insisted upon is redundant.
>
> In any case, I cannot object to reducing overhead, esp. as this whole
> patch was suggested by me in the first place, so:
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

> That said, how about the below? It avoids a function call.

That is fine by me.

What about taking it a bit further, though, and moving the definition
of cpufreq_update_util_data to somewhere under kernel/sched/ (like
kernel/sched/cpufreq.c maybe)?

Then, the whole static inline void cpufreq_update_util() definition
can go into kernel/sched/sched.h (it doesn't have to be visible
anywhere beyond kernel/sched/) and the only thing that needs to be
exported to cpufreq will be a helper (or two), to set/clear the
cpufreq_update_util_data pointers.

I'll try to cut a patch doing that later today for illustration.

From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 13:30:37 +0100
Message-ID: <CAJZ5v0jXDUzMq65n3kyRp5MjRzzi8=GFLEq6zj3nj=owQMXXSQ@mail.gmail.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan> <20170321064044.GO25659@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321064044.GO25659@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 21, 2017 at 7:40 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 20-03-17, 22:46, Rafael J. Wysocki wrote:
>> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
>
>> +static void sugov_update_commit(struct sugov_cpu *sg_cpu,
>> +                             struct sugov_policy *sg_policy,
>> +                             u64 time, unsigned int next_freq)
>>  {
>>       struct cpufreq_policy *policy = sg_policy->policy;
>>
>> +     if (sugov_cpu_is_busy(sg_cpu) && next_freq < sg_policy->next_freq)
>> +             next_freq = sg_policy->next_freq;
>> +
>
> In the earlier version you said that we want to be opportunistic and
> don't want to do heavy computation and so check only for current CPU.
>
> But in this version, all those computations are already done by now.
> Why shouldn't we check all CPUs in the policy now? I am asking as we
> will still have the same problem, we are trying to work-around if the
> current CPU isn't busy but others sharing the policy are.

This isn't the way I'm looking at that.

This is an easy (and relatively cheap) check to make for the *current*
*CPU* and our frequency selection algorithm turns out to have
problems, so it would be kind of unreasonable to not use the
opportunity to fix up the value coming from it - if we can do that
easily enough.

For the other CPUs in the policy that would require extra
synchronization etc., so not that easy any more.

> Also, why not return directly from within the if block? To run
> trace_cpu_frequency()?

Yes.

> I don't remember exactly, but why don't we run that for !fast-switch
> case?

That's an interesting question.

We do that in the fast switch case, because otherwise utilities get
confused if the frequency is not updated for a long enough time.

I'm not really sure why they don't get confused in the other case,
though.  [In that case the core calls trace_cpu_frequency() for us,
but only if we actually run the async work.]

It looks like it wouldn't hurt to always run trace_cpu_frequency()
when we want to bail out early for next_freq == sg_policy->next_freq.

Let me prepare a patch for that. :-)

> We can simplify the code a bit if we check for no freq change at
> the top of the routine.

Right.

Thanks,
Rafael

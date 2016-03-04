From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Sat, 5 Mar 2016 00:18:54 +0100
Message-ID: <CAJZ5v0jh7qcmYjDXCdO3Pid4XyuuxQfsKAmWDLXYcrkx0t-phw@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<2409306.qzzMXcm4dm@vostro.rjw.lan>
	<15684081.T4iOMUSHCY@vostro.rjw.lan>
	<56DA09B1.4010005@linaro.org>
	<CAJZ5v0jENyu8j0fq1-BhU64QwRHAjvcjQktYc2sa9QmhktoEnQ@mail.gmail.com>
	<CAJZ5v0jd6sXQnvZ87=_L1MQgu2QsBJtYb8jwn=0=m7eRdKVvhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jd6sXQnvZ87=_L1MQgu2QsBJtYb8jwn=0=m7eRdKVvhA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 4, 2016 at 11:40 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Mar 4, 2016 at 11:32 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Fri, Mar 4, 2016 at 11:18 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
>>> On 03/03/2016 07:07 PM, Rafael J. Wysocki wrote:
>>>> +void cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>>>> +                             unsigned int target_freq, unsigned int relation)
>>>> +{
>>>> +     unsigned int freq;
>>>> +
>>>> +     freq = cpufreq_driver->fast_switch(policy, target_freq, relation);
>>>> +     if (freq != CPUFREQ_ENTRY_INVALID) {
>>>> +             policy->cur = freq;
>>>> +             trace_cpu_frequency(freq, smp_processor_id());
>>>> +     }
>>>> +}
>>>
>>> Even if there are platforms which may change the CPU frequency behind
>>> cpufreq's back, breaking the transition notifiers, I'm worried about the
>>> addition of an interface which itself breaks them. The platforms which
>>> do change CPU frequency on their own have probably evolved to live with
>>> or work around this behavior. As other platforms migrate to fast
>>> frequency switching they might be surprised when things don't work as
>>> advertised.
>>
>> Well, intel_pstate doesn't do notifies at all, so anything depending
>> on them is already broken when it is used.  Let alone the hardware
>> P-states coordination mechanism (HWP) where the frequency is
>> controlled by the processor itself entirely.
>>
>> That said I see your point.
>>
>>> I'm not sure what the easiest way to deal with this is. I see the
>>> transition notifiers are the srcu type, which I understand to be
>>> blocking. Going through the tree and reworking everyone's callbacks and
>>> changing the type to atomic is obviously not realistic.
>>
>> Right.
>>
>>> How about modifying cpufreq_register_notifier to return an error if the
>>> driver has a fast_switch callback installed and an attempt to register a
>>> transition notifier is made?
>>
>> That sounds like a good idea.
>>
>> There also is the CPUFREQ_ASYNC_NOTIFICATION driver flag that in
>> principle might be used as a workaround, but I'm not sure how much
>> work that would require ATM.
>
> What I mean is that drivers using it are supposed to handle the
> notifications by calling cpufreq_freq_transition_begin(/end() by
> themselves, so theoretically there is a mechanism already in place for
> that.
>
> I guess what might be done would be to spawn a work item to carry out
> a notify when the frequency changes.

In fact, the mechanism may be relatively simple if I'm not mistaken.

In the "fast switch" case, the governor may spawn a work item that
will just execute cpufreq_get() on policy->cpu.  That will notice that
policy->cur is different from the real current frequency and will
re-adjust.

Of course, cpufreq_driver_fast_switch() will need to be modified so it
doesn't update policy->cur then perhaps with a comment that the
governor using it will be responsible for that.

And the governor will need to avoid spawning that work item too often
(basically, if one has been spawned already and hasn't completed, no
need to spawn a new one, and maybe rate-limit it?), but all that looks
reasonably straightforward.

Thanks,
Rafael

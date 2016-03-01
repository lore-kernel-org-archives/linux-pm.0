From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v4 1/2] cpufreq: New governor using utilization
 data from the scheduler
Date: Tue, 1 Mar 2016 21:20:01 +0100
Message-ID: <CAJZ5v0hi+RZUkWFGDPpftWxcCP-1v6675FY14j19AoRM=e=13Q@mail.gmail.com>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
	<1825489.pc33SqXSIB@vostro.rjw.lan>
	<56D1270F.4010106@linaro.org>
	<2754630.1sRldKdOu8@vostro.rjw.lan>
	<56D5161F.1030701@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D5161F.1030701@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 1, 2016 at 5:10 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On 02/27/2016 07:24 AM, Rafael J. Wysocki wrote:
>>>> +static unsigned int sugov_next_freq(struct policy_dbs_info *policy_dbs,
>>>> +                               unsigned long util, unsigned long max,
>>>> +                               u64 last_sample_time)
>>>> +{
>>>> +   struct cpufreq_policy *policy = policy_dbs->policy;
>>>> +   unsigned int min_f = policy->min;
>>>> +   unsigned int max_f = policy->max;
>>>> +   unsigned int j;
>>>> +
>>>> +   if (util > max || min_f >= max_f)
>>>> +           return max_f;
>>>> +
>>>> +   for_each_cpu(j, policy->cpus) {
>>>> +           struct sugov_cpu *j_sg_cpu;
>>>> +           unsigned long j_util, j_max;
>>>> +
>>>> +           if (j == smp_processor_id())
>>>> +                   continue;
>>>> +
>>>> +           j_sg_cpu = &per_cpu(sugov_cpu, j);
>>>> +           /*
>>>> +            * If the CPU was last updated before the previous sampling
>>>> +            * time, we don't take it into account as it probably is idle
>>>> +            * now.
>>>> +            */
>>>
>>> If the sampling rate is less than the tick, it seems possible a busy CPU
>>> may not manage to get an update in within the current sampling period.
>>
>> Right.
>>
>> sampling_rate is more of a rate limit here, though, because the governor doesn't
>> really do any sampling (I was talking about that in the intro message at
>> http://marc.info/?l=linux-pm&m=145609673008122&w=2).
>>
>> It was easy to re-use the existing show/store for that, so I took the shortcut,
>> but I'm considering to introduce a new attribute with a more suitable name for
>> that.  That would help to avoid a couple of unclean things in patch [2/2] as
>> well if I'm not mistaken.
>>
>>> What about checking to see if there was an update within the last tick
>>> period, rather than sample period?
>>
>> If your rate limit is set below the rate of the updates (scheduling rate more
>> or less), it simply has no effect.  To me, that case doesn't require any
>> special care.
>
> I'm specifically worried about the check below where we omit a CPU's
> capacity request if its last update came before the last sample time.
>
> Say there are 2 CPUs in a frequency domain, HZ is 100 and the sample
> delay here is 4ms.

Yes, that's the case I clearly didn't take into consideration. :-)

My assumption was that the sample delay would always be greater than
the typical update rate which of course need not be the case.

The reason I added the check at all was that the numbers from the
other CPUs may become stale if those CPUs are idle for too long, so at
one point the contributions from them need to be discarded.  Question
is when that point is and since sample delay may be arbitrary, that
mechanism has to be more complex.

> At t=0ms CPU0 starts running a CPU hog and reports
> being fully busy. At t=5ms CPU1 starts running a task - CPU0's vote is
> kept and factored in and last_sample_time is updated to t=5ms. At t=9ms
> CPU1 stops running the task and updates again, but this time CPU0's vote
> is discarded because its last update is t=0ms, and last_sample_time is
> 5ms. But CPU0 is fully busy and the freq is erroneously dropped.
>

[cut]

>>
>> Like I said in my reply to Peter in that thread, using RELATION_L here is likely
>> to make us avoid the min frequency almost entirely even if the system is almost
>> completely idle.  I don't think that would be OK really.
>>
>> That said my opinion about this particular item isn't really strong.
>
> I think the calculation for required CPU bandwidth needs tweaking.

The reason why I used that particular formula was that ondemand used
it.  Of course, the input to it is different in ondemand, but the idea
here is to avoid departing from it too much.

> Aside from always wanting something past fmin, currently the amount of
> extra CPU capacity given for a particular % utilization depends on how
> high the platform's fmin happens to be, even if the fmax speeds are the
> same. For example given two platforms with the following available
> frequencies (MHz):
>
> platform A: 100, 300, 500, 700, 900, 1100
> platform B: 500, 700, 900, 1100

The frequencies may not determine raw performance, though, so 500 MHz
in platform A may correspond to 700 MHz in platform B.  You never
know.

>
> A 50% utilization load on platform A will want 600 MHz (rounding up to
> 700 MHz perhaps) whereas platform B will want 800 MHz (again likely
> rounding up to 900 MHz), even though the load consumes 550 MHz on both
> platforms.
>
> One possibility would be something like we had in schedfreq, getting the
> absolute CPU bw requirement (util/max) * fmax and then adding some %
> margin, which I think is more consistent. It is true that it means
> figuring out what the right margin is and now there's a magic number
> (and potentially a tunable), but it would be more consistent.
>

What the picture is missing is the information on how much more
performance you get by running in a higher P-state (or OPP if you
will).  We don't have that information, however, and relying on
frequency values here generally  doesn't help.

Moreover, since 0 utilization gets you to run in f_min no matter what,
if you treat f_max as an absolute, you're going to underutilize the
P-states in the upper half of the available range.

Thanks,
Rafael

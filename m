From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 4/4] sched: cpufreq_cfs: pelt-based cpu frequency scaling
Date: Thu, 07 May 2015 11:49:27 +0100
Message-ID: <554B4337.4050007@arm.com>
References: <1430777441-15087-1-git-send-email-mturquette@linaro.org> <1430777441-15087-5-git-send-email-mturquette@linaro.org> <20150505090042.GC21418@twins.programming.kicks-ass.net> <20150505182347.16410.16338@quantum> <20150506122240.GY23123@twins.programming.kicks-ass.net> <20150507041725.16410.58417@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150507041725.16410.58417@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "riel@redhat.com" <riel@redhat.com>, "efault@gmx.de" <efault@gmx.de>, "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ashwin.chaugule@linaro.org" <ashwin.chaugule@linaro.org>, "alex.shi@linaro.org" <alex.shi@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mike,

On 07/05/15 05:17, Michael Turquette wrote:
> Quoting Peter Zijlstra (2015-05-06 05:22:40)
>> On Tue, May 05, 2015 at 11:23:47AM -0700, Michael Turquette wrote:
>>> Quoting Peter Zijlstra (2015-05-05 02:00:42)
>>>> On Mon, May 04, 2015 at 03:10:41PM -0700, Michael Turquette wrote:
>>>>> This policy is implemented using the cpufreq governor interface for two
>>>>> main reasons:
>>>>>
>>>>> 1) re-using the cpufreq machine drivers without using the governor
>>>>> interface is hard.
>>>>>
>>>>> 2) using the cpufreq interface allows us to switch between the
>>>>> scheduler-driven policy and legacy cpufreq governors such as ondemand at
>>>>> run-time. This is very useful for comparative testing and tuning.
>>>>
>>>> Urgh,. so I don't really like that. It adds a lot of noise to the
>>>> system. You do the irq work thing to kick the cpufreq threads which do
>>>> their little thing -- and their wakeup will influence the cfs
>>>> accounting, which in turn will start the whole thing anew.
>>>>
>>>> I would really prefer you did a whole new system with directly invoked
>>>> drivers that avoid the silly dance. Your 'new' ARM systems should be
>>>> well capable of that.
>>>
>>> Thanks for the review Peter.
>>
>> Well, I didn't actually get beyond the Changelog; although I have
>> rectified this now. A few more comments below.
> 
> Thanks for the Real Deal review Peter.
> 
>>
>>> We'll need something in process context for the many cpufreq drivers
>>> that might sleep during their cpu frequency transition, no? This is due
>>> to calls into the regulator framework, the clock framework and sometimes
>>> other things such as conversing with a power management IC or voting
>>> with some system controller.
>>
>> Yes, we need _something_. I just spoke to a bunch of people on IRC and
>> it does indeed seem that I was mistaken in my assumption that modern ARM
>> systems were 'easy' in this regard.
>>
>>>> As to the drivers, they're mostly fairly small and self contained, it
>>>> should not be too hard to hack them up to work without cpufreq.
>>>
>>> The drivers are not the only thing. I want to leverage the existing
>>> cpufreq core infrastructure:
>>>
>>> * rate change notifiers
>>> * cpu hotplug awareness
>>> * methods to fetch frequency tables from firmware (acpi, devicetree)
>>> * other stuff I can't think of now
>>>
>>> So I do not think we should throw out the baby with the bath water. The
>>> thing that people really don't like about cpufreq are the governors IMO.
>>> Let's fix that by creating a list of requirements that we really want
>>> for scheduler-driven cpu frequency selection:
>>>
>>> 0) do something smart with scheduler statistics to create an improved
>>> frequency selection algorithm over existing cpufreq governors
>>>
>>> 1) support upcoming and legacy hardware, within reason
>>>
>>> 2) if a system exports a fast, async frequency selection interface to
>>> Linux, then provide a solution that doesn't do any irq_work or kthread
>>> stuff.  Do it all in the fast path
>>>
>>> 3) if a system has a slow, synchronous interface for frequency
>>> selection, then provide an acceptable solution for kicking this work to
>>> process context. Limit time in the fast path
>>>
>>> The patch set tries to tackle 0, 1 and 3. Would the inclusion of #2 make
>>> you feel better about supporting "newer" hardware with a fire-and-forget
>>> frequency selection interface?
>>
>> I should probably look at doing a x86 support patch to try some of this
>> out, I'll try and find some time to play with that.
>>
>> So two comments on the actual code:
>>
>> 1) Ideally these hooks would be called from places where we've just
>> computed the cpu utilization already. I understand this is currently not
>> the case and we need to do it in-situ.
> 
> Are you thinking of placing the hook somewhere such as
> update_entity_load_avg?
> 
> I did not choose that as a call site since I was worried that it would
> be too noisy; we can enter that function multiple times in the same
> pass through the scheduler.
> 
> On the other hand if dvfs transitions are cheap for a platform then it
> might not be so bad to call it multiple times. For platforms where dvfs
> transitions are expensive we could store per-cpu new_capacity data
> multiple times and make sure that we only try to program the hardware as
> deferred work later on.
> 
>>
>> That said; it would be good to have the interface such that we pass the
>> utilization in; this would of course mean we'd have to compute it at the
>> call sites, this should be fine I think.
> 
> I changed the code to do this but didn't have time to test it. Will send
> the patch with these changes tomorrow.
> 
>>
>>
>> 2) I dislike how policy->cpus is handled; it feels upside down.
> 
> I agree. It feels better to push the utilization from cfs instead of
> pull it from the frequency selection policy.
> 
> I chose to do it this way since there isn't an obvious way to pass some
> private data to an irq_work callback, but I've overcome this with some
> per-cpu data internal to the governor.
>

This new interface looks like what I was also proposing in the
discussion we had [1], are you going to send out something along this
line?

I think it would be good to have something like that. As Peter is
saying, together with Morten's/Dietmar's series, we could try to do
wiser decisions on when to trigger the whole machinery.

Thanks,

- Juri

[1] https://lists.linaro.org/pipermail/eas-dev/2015-April/000129.html

>> If per 1 each CPU already computed its utilization and provides it in
>> the call, we should not have to recompute it and its scale factor (which
>> btw seems done slightly odd too, I know humans like 10 base, but
>> computers suck at it).
>>
>> Why not something like:
>>
>>         usage = ((1024 + 256) * usage) >> 10; /* +25% */
> 
> This works when the max capacity is always 1024, but that is not always
> the case for some new ARM systems. For cpu's whose max capacity is less
> than 1024 we would still need to normalize against capacity_orig_of().
> 
> Doing the SCHED_LOAD_SCALE thing is fine for me now, but at some point
> it will probably need to be changed by Morten/Juri/Dietmar for their EAS
> patch series, which deals with some of these cpu capacity scale issues.
> 
>>
>>         old_usage = __this_cpu_read(gd->usage);
>>         __this_cpu_write(gd->usage, usage);
>>
>>         max_usage = 0;
>>         for_each_cpu(cpu, policy->cpus)
>>                 max_usage = max(max_usage, per_cpu(gd->usage, cpu));
>>
>>         if (max_usage < old_usage || /* dropped */
>>             (max_usage == usage && max_usage != old_usage)) /* raised */
>>                 request_change(max_usage);
> 
> Yes this should work fine. I've pulled it into the patch that I'll
> test and publish tomorrow.
> 
> Thanks,
> Mike
> 
>>
>>
> 

From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 5/9] sched: cpufreq: remove smp_processor_id() in remote paths
Date: Thu, 13 Apr 2017 00:53:13 +0200
Message-ID: <CAJZ5v0j4DYHRoYax+BS-QM8wspdh1bhod7qFe_A3Ak3Ow6swWg@mail.gmail.com>
References: <cover.1489058244.git.viresh.kumar@linaro.org> <834d098efe029ee687bac7690bb482e9263a766b.1489058244.git.viresh.kumar@linaro.org>
 <1836427.bpauTYz19k@aspire.rjw.lan> <20170411103556.GC13627@vireshk-i7>
 <CAJZ5v0iQ4X=Vt54EvJce9R9rPhtVqvznte8=HoQ_UOAZ1fQj2g@mail.gmail.com> <20170412142628.GH5910@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34306 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754864AbdDLWxO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 18:53:14 -0400
In-Reply-To: <20170412142628.GH5910@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <smuckle.linux@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, eas-dev@lists.linaro.org

On Wed, Apr 12, 2017 at 4:26 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 11-04-17, 16:00, Rafael J. Wysocki wrote:
>> On Tue, Apr 11, 2017 at 12:35 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 29-03-17, 23:28, Rafael J. Wysocki wrote:
>> >> On Thursday, March 09, 2017 05:15:15 PM Viresh Kumar wrote:
>> >> > @@ -216,7 +216,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>> >> >     if (flags & SCHED_CPUFREQ_RT_DL) {
>> >> >             next_f = policy->cpuinfo.max_freq;
>> >> >     } else {
>> >> > -           sugov_get_util(&util, &max);
>> >> > +           sugov_get_util(&util, &max, hook->cpu);
>> >>
>> >> Why is this not racy?
>> >
>> > Why would reading the utilization values be racy? The only dynamic value here is
>> > "util_avg" and I am not sure if reading it is racy.
>> >
>> > But, this whole routine has races which I ignored as we may end up updating
>> > frequency simultaneously from two threads.
>>
>> Those races aren't there if we don't update cross-CPU, which is my point. :-)
>
> Of course. There are no races without this series.
>
>> >> >             sugov_iowait_boost(sg_cpu, &util, &max);
>> >> >             next_f = get_next_freq(sg_policy, util, max);
>> >> >     }
>> >> > @@ -272,7 +272,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>> >> >     unsigned long util, max;
>> >> >     unsigned int next_f;
>> >> >
>> >> > -   sugov_get_util(&util, &max);
>> >> > +   sugov_get_util(&util, &max, hook->cpu);
>> >> >
>> >>
>> >> And here?
>> >>
>> >> >     raw_spin_lock(&sg_policy->update_lock);
>> >
>> > The lock prevents the same here though.
>> >
>> > So, if we are going to use this series, then we can use the same update-lock in
>> > case of single cpu per policies as well.
>>
>> No, we can't.
>>
>> The lock is unavoidable in the mulit-CPU policies case, but there's no
>> way I will agree on using a lock in the single-CPU case.
>
> How do you suggest to avoid the locking here then ? Some atomic
> variable read/write as done in cpufreq_governor.c ?

That is a very good question. :-)

I need to look at the scheduler code that invokes those things and see
what happens in there.  Chances are there already is some sufficient
mutual exclusion in place.

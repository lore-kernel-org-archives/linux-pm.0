From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 00:42:01 +0100
Message-ID: <CAJZ5v0jjp7stM6O4XbDjATOUjntpYY-85FeiCC-WUeRVaQwTLA@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
	<20160202154717.GI3947@e106622-lin>
	<CAJZ5v0h3k_CVDkmc8QKczr0MxCuGd+Rm_wSMXO=UHBvOjae0Uw@mail.gmail.com>
	<20160202170144.GL3947@e106622-lin>
	<CAJZ5v0hL4sybqiWCYJpornfJcpMXeAg4E2UNKcCxRB08dhaFPA@mail.gmail.com>
	<56B12BEC.9070603@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33527 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864AbcBBXmE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 18:42:04 -0500
In-Reply-To: <56B12BEC.9070603@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 2, 2016 at 11:21 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 02/02/2016 11:40 AM, Rafael J. Wysocki wrote:
>>
>> On Tue, Feb 2, 2016 at 6:01 PM, Juri Lelli <juri.lelli@arm.com> wrote:
>>>
>>> Hi Rafael,
>>>
>>> On 02/02/16 17:35, Rafael J. Wysocki wrote:
>>>>
>>>> On Tue, Feb 2, 2016 at 4:47 PM, Juri Lelli <juri.lelli@arm.com> wrote:
>>>>>
>>>>> Hi Viresh,
>>>>>
>>>>> On 02/02/16 16:27, Viresh Kumar wrote:
>>>>>>
>>>>>> Until now, governors (ondemand/conservative) were using the
>>>>>> 'global-attr' or 'freq-attr', depending on the sysfs location where we
>>>>>> want to create governor's directory.
>>>>>>
>>>>>> The problem is that, in case of 'freq-attr', we are forced to use
>>>>>> show()/store() present in cpufreq.c, which always take policy->rwsem.
>>>>>>
>>>>>> And because of that we were facing some ABBA lockups during governor
>>>>>> callback event CPUFREQ_GOV_POLICY_EXIT. And so we were dropping the
>>>>>> rwsem right before calling governor callback for
>>>>>> CPUFREQ_GOV_POLICY_EXIT
>>>>>> event.
>>>>>>
>>>>>> That caused further problems and it never worked perfectly.
>>>>>>
>>>>>> This patch attempts to fix that by creating separate sysfs-ops for
>>>>>> cpufreq governors.
>>>>>>
>>>>>> Because things got much simplified now, we don't need separate
>>>>>> show/store callbacks for governor-for-system and governor-per-policy
>>>>>> cases.
>>>>>>
>>>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>>
>>>>>
>>>>> This patch cleans things up a lot, that's good.
>>>>>
>>>>> One thing I'm still concerned about, though: don't we need some locking
>>>>> in place for some of the store operations on governors attributes? Are
>>>>> store_{ignore_nice_load, sampling_down_fact, etc} safe without locking?
>>>>
>>>>
>>>> That would require some investigation I suppose.
>>>>
>>>>> It seems that we can call them from different cpus concurrently.
>>>>
>>>>
>>>> Yes, we can.
>>>>
>>>> One quick-and-dirty way of dealing with that might be to introduce a
>>>> "sysfs lock" into struct dbs_data and hold that around the invocation
>>>> of gattr->store() in the sysfs_ops's ->store callback.
>>>>
>>>
>>> There is value in trying to solve this issue by using some of the
>>> existing locks, IMHO.
>>
>>
>> Some value - maybe.  I'm not sure how much of it, though.
>>
>> Finer-grained locking is generally easier to follow, because the locks
>> tend to be used for specific purposes only.
>>
>>> Can't we actually try to use the policy->rwsem (or one of the core
>>> locks) + wait_for_completion approach as we do in cpufreq core?
>>
>>
>> No.  Too many things depend on that lock already and some of them work
>> by accident rather than by design.
>
>
> Also, wait_for_completion() and complete() is just another way to implement
> a lock. So, it won't necessarily solve any deadlock issues.
>
> I also don't like this patch because it forces governors to either implement
> their own macros and management of their attributes or force them to use the
> governor structs that come with cpufreq_governor.h. cpufreq_governor.h IMHO
> is very ondemand and conservative governor specific and is very irrelevant
> for sched-dvfs or any other governors (hint hint).
>
> The only time this ABBA locking is an issue is when governor are changing
> and trying to add/remove attributes. That can easily be checked in
> store_governor and dealt with without holding the policy rwsem if the
> governors can provide their per sys and per policy attribute arrays as part
> of registering themselves.
>
> I'm sorry that I just keep talking about the idea and not sending out the
> patches.

I think you have a point, though.

The deadlock really is specific to the governors using the code in
cpufreq_governor.c.

Thanks,
Rafael

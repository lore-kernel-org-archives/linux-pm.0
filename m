From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Tue, 09 Feb 2016 13:02:51 -0800
Message-ID: <56BA53FB.8050204@codeaurora.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org> <3866963.E19P3EGEHd@vostro.rjw.lan> <56B558EB.6070408@codeaurora.org> <14418694.vd8JTxlxro@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33080 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222AbcBIVCy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 16:02:54 -0500
In-Reply-To: <14418694.vd8JTxlxro@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Shilpa Bhat <shilpabhatppc@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02/07/2016 06:28 PM, Rafael J. Wysocki wrote:
> On Friday, February 05, 2016 06:22:35 PM Saravana Kannan wrote:
>> On 02/04/2016 07:54 PM, Rafael J. Wysocki wrote:
>>> On Thursday, February 04, 2016 07:18:32 PM Rafael J. Wysocki wrote:
>>>> On Thu, Feb 4, 2016 at 6:44 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
>>>>> On 02/04/2016 09:43 AM, Saravana Kannan wrote:
>>>>>>
>>>>>> On 02/04/2016 03:09 AM, Viresh Kumar wrote:
>>>>>>>
>>>>>>> On 04-02-16, 00:50, Rafael J. Wysocki wrote:
>>>>>>>>
>>>>>>>> This is exactly right.  We've avoided one deadlock only to trip into
>>>>>>>> another one.
>>>>>>>>
>>>>>>>> This happens because update_sampling_rate() acquires
>>>>>>>> od_dbs_cdata.mutex which is held around cpufreq_governor_exit() by
>>>>>>>> cpufreq_governor_dbs().
>>>>>>>>
>>>>>>>> Worse yet, a deadlock can still happen without (the new)
>>>>>>>> dbs_data->mutex, just between s_active and od_dbs_cdata.mutex if
>>>>>>>> update_sampling_rate() runs in parallel with
>>>>>>>> cpufreq_governor_dbs()->cpufreq_governor_exit() and the latter wins
>>>>>>>> the race.
>>>>>>>>
>>>>>>>> It looks like we need to drop the governor mutex before putting the
>>>>>>>> kobject in cpufreq_governor_exit().
>>>>>>>
>>>>
>>>> [cut]
>>>>
>>>>>>
>>>>>> No no no no! Let's not open up this can of worms of queuing up the work
>>>>>> to handle a write to a sysfs file. It *MIGHT* work for this specific
>>>>>> tunable (I haven't bothered to analyze), but this makes it impossible to
>>>>>> return a useful/proper error value.
>>>>>
>>>>>
>>>>> Sent too soon. Not only that, but it can also cause the writes to the sysfs
>>>>> files to get processed in a different order and I don't know what other
>>>>> issues/races THAT will open up.
>>>>
>>>> Well, I don't like this too.
>>>>
>>>> I actually do have an idea about how to fix these deadlocks, but it is
>>>> on top of my cleanup series.
>>>>
>>>> I'll write more about it later today.
>>>
>>> Having actually posted that series again after cleaning it up I can say
>>> what I'm thinking about hopefully without confusing anyone too much.  So
>>> please bear in mind that I'm going to refer to this series below:
>>>
>>> http://marc.info/?l=linux-pm&m=145463901630950&w=4
>>>
>>> Also this is more of a brain dump rather than actual design description,
>>> so there may be holes etc in it.  Please let me know if you can see any.
>>>
>>> The problem at hand is that policy->rwsem needs to be held around *all*
>>> operations in cpufreq_set_policy().  In particular, it cannot be dropped
>>> around invocations of __cpufreq_governor() with the event arg equal to
>>> _EXIT as that leads to interesting races.
>>>
>>> Unfortunately, we know that holding policy->rwsem in those places leads
>>> to a deadlock with governor sysfs attributes removal in cpufreq_governor_exit().
>>>
>>> Viresh attempted to fix this by avoiding to acquire policy->rwsem for governor
>>> attributes access (as holding it is not necessary for them in principle).  That
>>> was a nice try, but it turned out to be insufficient because of another deadlock
>>> scenario uncovered by it.  Namely, since the ondemand governor's update_sampling_rate()
>>> acquires the governor mutex (called dbs_data_mutex after my patches mentioned
>>> above), it may deadlock with exactly the same piece of code in cpufreq_governor_exit()
>>> in almost exactly the same way.
>>>
>>> To avoid that other deadlock, we'd either need to drop dbs_data_mutex from
>>> update_sampling_rate(), or drop it for the removal of the governor sysfs
>>> attributes in cpufreq_governor_exit().  I don't think the former is an option
>>> at least at this point, so it looks like we pretty much have to do the latter.
>>>
>>> With that in mind, I'd start with the changes made by Viresh (maybe without the
>>> first patch which really isn't essential here).  That is, introduce a separate
>>> kobject type for the governor attributes kobject and register that in
>>> cpufreq_governor_init().  The show/store callbacks for that kobject type won't
>>> acquire policy->rwsem so the first deadlock will be avoided.
>>>
>>> But in addition to that, I'd drop dbs_data_mutex before the removal of governor
>>> sysfs attributes.  That actually happens in two places, in cpufreq_governor_exit()
>>> and in the error path of cpufreq_governor_init().
>>>
>>> To that end, I'd move the locking from cpufreq_governor_dbs() to the functions
>>> called by it.  That should be readily doable and they can do all of the
>>> necessary checks themselves.  cpufreq_governor_dbs() would become a pure mux then,
>>> but that's not such a big deal.
>>>
>>> With that, cpufreq_governor_exit() may just drop the lock before it does the
>>> final kobject_put().  The danger here is that the sysfs show/store callbacks of
>>> the governor attributes kobject may see invalid dbs_data for a while, after the
>>> lock has been dropped and before the kobject is deleted.  That may be addressed
>>> by checking, for example, the presence of the dbs_data's "tuners" pointer in those
>>> callbacks.  If it is NULL, they can simply return -EAGAIN or similar.
>>>
>>> Now, that means, though, that they need to acquire the same lock as
>>> cpufreq_governor_exit(), or they may see things go away while they are running.
>>> The simplest approach here would be to take dbs_data_mutex in them too, although
>>> that's a bit of a sledgehammer.  It might be better to have a per-policy lock
>>> in struct policy_dbs_info for that, for example, but then the governor attribute
>>> sysfs callbacks would need to get that object instead of dbs_data.
>>>
>>> On the flip side, it might be possible to migrate update_sampling_rate() to
>>> that lock too.  And maybe we can get rid of dbs_data_mutex even, who knows?
>>
>> I'm glad you've analyzed it this far. So, the rest of my comments will
>> be easier to understand.
>>
>> I'm going to go back to my point of NOT doing the sysfs add/remove
>> inside the governor at all (that includes cpufreq_governor.c) and doing
>> it in cpufreq.c. That suggestion was confusing to explain/understand
>> before when we were using policy rwsem inside the show/store ops for the
>> governor attributes. Now that has been removed, my suggestion would be
>> even easier/cleaner to implement/understand and you don't have to worry
>> about ANY races in the governor.
>>
>> I'll just talk about the have_governor_per_policy() case. It can be
>> easily extended to the global case.
>>
>> In cpufreq_governor.c:
>> cpufreq_governor_init(...)
>> {
>>    ...
>>    /* NOT kobject_init_and_add */
>>    kobject_init();
>>    /* New field */
>>    policy->gov_kobj = &dbs_data->kobj);
>>    ...
>> }
>>
>> In cpufreq.c:
>> __cpufreq_governor(...)
>> {
>>
>>      if (event == POLICY_EXIT) {
>>         kobject_put(policy->gov_kobj);
>>      }
>>      ret = policy->governor->governor(policy, event);
>>      if (event == POLICY_INIT) {
>>         kobj_add(policy->gov_kobj, policy->kobj, policy->governor->name);
>>      }
>> }
>>
>> This guarantees that there can be no races of the governor specific data
>> structures going away while being accessed from sysfs because the first
>> thing we do once we decide to "kill" a governor is to remove the sysfs
>> files and the accesses to governor data (and flush out all on going
>> accesses) and THEN ask the governor to exit.
>>
>> Thoughts?
>
> The core would then have to rely on the governor code to populate the gov_kobj
> field correctly which doesn't look really straightforward to me.  It is better
> if each code layer arranges the data structures it is going to use by itself.

The core depends a lot on the drivers and governors filling up some 
fields correctly. This isn't any worse than that. It just seems way more 
logical to me to remove the interface to changing governor attributes 
(the sysfs files) before we start "exiting" a governor. But it looks 
like there's a v3 series of patches from Viresh that people seem to 
agree is fixing the race in a different method -- I haven't had time to 
look at it. So, I'm not going to keep pushing my point about removing 
the sysfs files at the core level. I'll jump back to it if we later find 
another race with this v3 patch series :)

> Besides, ondemand and conservative are the only governors that use the governor
> kobject at all, so I'm not sure if that really belongs to the core.

Technically userspace should be using kobject and sysfs attributes for 
set speed, but for whatever reason (legacy/historical I assume) we let 
the core add/remove sysfs files for an op that's supported only by 
userspace governor.

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

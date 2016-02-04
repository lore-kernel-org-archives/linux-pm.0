From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Thu, 4 Feb 2016 19:18:32 +0100
Message-ID: <CAJZ5v0hG2CickrbnTn8qJdFHJZ4cuZg1nxJ=8OXN8YFuw=qSFQ@mail.gmail.com>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
	<20160203155428.GY3947@e106622-lin>
	<20160203161059.GH3469@vireshk>
	<20160203172009.GC12132@e106622-lin>
	<CAJZ5v0hdn6bM8J97O_GFrvi2O7LfuGv0oaZu7KH+cj1TJy+4CQ@mail.gmail.com>
	<CAMSceqiFG47G=mvzY8-tUL=sHdkkjVQaWzEA1aN+-ym0F_n6Gw@mail.gmail.com>
	<CAJZ5v0hbhoS+1AaU12SFxz=r1-TOWq10yJ+ST7mVWcUubTbxFw@mail.gmail.com>
	<20160204110907.GE3469@vireshk>
	<56B38DC8.8060606@codeaurora.org>
	<56B38E14.5060705@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33161 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbcBDSSe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 13:18:34 -0500
In-Reply-To: <56B38E14.5060705@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Shilpa Bhat <shilpabhatppc@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Feb 4, 2016 at 6:44 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 02/04/2016 09:43 AM, Saravana Kannan wrote:
>>
>> On 02/04/2016 03:09 AM, Viresh Kumar wrote:
>>>
>>> On 04-02-16, 00:50, Rafael J. Wysocki wrote:
>>>>
>>>> This is exactly right.  We've avoided one deadlock only to trip into
>>>> another one.
>>>>
>>>> This happens because update_sampling_rate() acquires
>>>> od_dbs_cdata.mutex which is held around cpufreq_governor_exit() by
>>>> cpufreq_governor_dbs().
>>>>
>>>> Worse yet, a deadlock can still happen without (the new)
>>>> dbs_data->mutex, just between s_active and od_dbs_cdata.mutex if
>>>> update_sampling_rate() runs in parallel with
>>>> cpufreq_governor_dbs()->cpufreq_governor_exit() and the latter wins
>>>> the race.
>>>>
>>>> It looks like we need to drop the governor mutex before putting the
>>>> kobject in cpufreq_governor_exit().
>>>

[cut]

>>
>> No no no no! Let's not open up this can of worms of queuing up the work
>> to handle a write to a sysfs file. It *MIGHT* work for this specific
>> tunable (I haven't bothered to analyze), but this makes it impossible to
>> return a useful/proper error value.
>
>
> Sent too soon. Not only that, but it can also cause the writes to the sysfs
> files to get processed in a different order and I don't know what other
> issues/races THAT will open up.

Well, I don't like this too.

I actually do have an idea about how to fix these deadlocks, but it is
on top of my cleanup series.

I'll write more about it later today.

Thanks,
Rafael

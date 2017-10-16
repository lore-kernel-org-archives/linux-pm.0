From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 0/8] Introduct cpu idle prediction functionality
Date: Mon, 16 Oct 2017 15:44:41 +0800
Message-ID: <c4eaedb9-904f-0b51-a6e3-3033a6808cf0@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <3026355.QRuoy6eIZM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25839 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbdJPHoo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Oct 2017 03:44:44 -0400
In-Reply-To: <3026355.QRuoy6eIZM@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017/10/14 9:14, Rafael J. Wysocki wrote:
> On Saturday, September 30, 2017 9:20:26 AM CEST Aubrey Li wrote:
>> We found under some latency intensive workloads, short idle periods occurs
>> very common, then idle entry and exit path starts to dominate, so it's
>> important to optimize them. To determine the short idle pattern, we need
>> to figure out how long of the coming idle and the threshold of the short
>> idle interval.
>>
>> A cpu idle prediction functionality is introduced in this proposal to catch
>> the short idle pattern.
>>
>> Firstly, we check the IRQ timings subsystem, if there is an event
>> coming soon.
>> -- https://lwn.net/Articles/691297/
>>
>> Secondly, we check the idle statistics of scheduler, if it's likely we'll
>> go into a short idle.
>> -- https://patchwork.kernel.org/patch/2839221/
>>
>> Thirdly, we predict the next idle interval by using the prediction
>> fucntionality in the idle governor if it has.
>>
>> For the threshold of the short idle interval, we record the timestamps of
>> the idle entry, and multiply by a tunable parameter at here:
>> -- /proc/sys/kernel/fast_idle_ratio
>>
>> We use the output of the idle prediction to skip turning tick off if a
>> short idle is determined in this proposal. Reprogramming hardware timer
>> twice(off and on) is expensive for a very short idle. There are some
>> potential optimizations can be done according to the same indicator.
>>
>> I observed when system is idle, the idle predictor reports 20/s long idle
>> and ZERO fast idle on one CPU. And when the workload is running, the idle
>> predictor reports 72899/s fast idle and ZERO long idle on the same CPU.
>>
>> Aubrey Li (8):
>>   cpuidle: menu: extract prediction functionality
>>   cpuidle: record the overhead of idle entry
>>   cpuidle: add a new predict interface
>>   tick/nohz: keep tick on for a fast idle
>>   timers: keep sleep length updated as needed
>>   cpuidle: make fast idle threshold tunable
>>   cpuidle: introduce irq timing to make idle prediction
>>   cpuidle: introduce run queue average idle to make idle prediction
>>
>>  drivers/cpuidle/Kconfig          |   1 +
>>  drivers/cpuidle/cpuidle.c        | 109 +++++++++++++++++++++++++++++++++++++++
>>  drivers/cpuidle/governors/menu.c |  69 ++++++++++++++++---------
>>  include/linux/cpuidle.h          |  21 ++++++++
>>  kernel/sched/idle.c              |  14 ++++-
>>  kernel/sysctl.c                  |  12 +++++
>>  kernel/time/tick-sched.c         |   7 +++
>>  7 files changed, 209 insertions(+), 24 deletions(-)
>>
> 
> Overall, it looks like you could avoid stopping the tick every time the
> predicted idle duration is not longer than the tick interval in the first
> place.
> > Why don't you do that?

I didn't catch this.

Are you suggesting?

if(!cpu_stat.fast_idle)
	tick_nohz_idle_enter()

Or you concern why the threshold can't simply be tick interval?

For the first, can_stop_idle_tick() is a better place to skip tick-off IMHO.
For the latter, if the threshold is close/equal to the tick, it's quite possible
the next event is the tick and no other else event.

Thanks,
-Aubrey

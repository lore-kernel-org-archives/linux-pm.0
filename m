From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Thu, 10 Mar 2016 09:12:12 +0700
Message-ID: <CAKfTPtC0x+ZOUZxEYahXwXGXSd5eATUhTDtRc=9sko8V896YQw@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <2044559.7ypXocW9OZ@vostro.rjw.lan>
 <3499355.2JlaSruvOa@vostro.rjw.lan> <16016177.YFqb4gVNBo@vostro.rjw.lan> <20160309123539.GL6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35355 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbcCJCMd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 21:12:33 -0500
Received: by mail-lb0-f173.google.com with SMTP id bc4so91953737lbc.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2016 18:12:32 -0800 (PST)
In-Reply-To: <20160309123539.GL6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 9 March 2016 at 19:35, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 15, 2016 at 10:47:22PM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Introduce a mechanism by which parts of the cpufreq subsystem
>> ("setpolicy" drivers or the core) can register callbacks to be
>> executed from cpufreq_update_util() which is invoked by the
>> scheduler's update_load_avg() on CPU utilization changes.
>>
>> This allows the "setpolicy" drivers to dispense with their timers
>> and do all of the computations they need and frequency/voltage
>> adjustments in the update_load_avg() code path, among other things.
>>
>> The update_load_avg() changes were suggested by Peter Zijlstra.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/cpufreq/cpufreq.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/cpufreq.h   |   34 ++++++++++++++++++++++++++++++++++
>>  kernel/sched/deadline.c   |    4 ++++
>>  kernel/sched/fair.c       |   26 +++++++++++++++++++++++++-
>>  kernel/sched/rt.c         |    4 ++++
>>  kernel/sched/sched.h      |    1 +
>>  6 files changed, 113 insertions(+), 1 deletion(-)
>>
>
> So with the understanding that we'll work on getting rid of
> cpufreq_trigger_update().
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Also, Vincent had some concerns about the exact placement of the
> callback, and I see no problem in moving it if there's need.

Yes, as explained previously we can probably  use other placement to
not miss any immediate change of rq's utilization because of task
migration but this optimization can probably be done in a next step

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

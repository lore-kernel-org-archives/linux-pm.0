From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 4/6] sched/rt: fast switch to maximum frequency when
 RT tasks are scheduled
Date: Thu, 30 Nov 2017 14:28:59 +0100
Message-ID: <20171130132859.GD9903@localhost.localdomain>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-5-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45240 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdK3N3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Nov 2017 08:29:04 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so12988918wme.4
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2017 05:29:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171130114723.29210-5-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

Hi,

On 30/11/17 11:47, Patrick Bellasi wrote:
> Currently schedutil updates are triggered for the RT class using a single
> call place, which is part of the rt::update_curr_rt() used in:
> 
> - dequeue_task_rt:
>   but it does not make sense to set the schedutil's SCHED_CPUFREQ_RT in
>   case the next task should not be an RT one
> 
> - put_prev_task_rt:
>   likewise, we set the SCHED_CPUFREQ_RT flag without knowing if required
>   by the next task
> 
> - pick_next_task_rt:
>   likewise, the schedutil's SCHED_CPUFREQ_RT is set in case the prev task
>   was RT, while we don't yet know if the next will be RT
> 
> - task_tick_rt:
>   that's the only really useful call, which can ramp up the frequency in
>   case a RT task started its execution without a chance to order a
>   frequency switch (e.g. because of the schedutil ratelimit)
> 
> Apart from the last call in task_tick_rt, the others are at least useless.
> Thus, although being a simple solution, not all the call sites of that
> update_curr_rt() are interesting to trigger a frequency switch as well as
> some of the most interesting points are not covered by that call.
> For example, a task set to RT has to wait the next tick to get the
> frequency boost.
> 
> This patch fixes these issues by placing explicitly the schedutils
> update calls in the only sensible places, which are:
> - when an RT task wakes up and it's enqueued in a CPU
> - when we actually pick a RT task for execution
> - at each tick time
> - when a task is set to be RT
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,

Juri

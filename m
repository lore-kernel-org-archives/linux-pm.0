From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Wed, 20 Dec 2017 10:17:12 +0100
Message-ID: <20171220091712.kd2nx5rf3dgila45@hirez.programming.kicks-ass.net>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
 <20171219192504.nstxsfii6y7rh37w@hirez.programming.kicks-ass.net>
 <20171220040446.GS19815@vireshk-i7>
 <20171220083115.n4mc4pdkvycakce2@hirez.programming.kicks-ass.net>
 <20171220084859.GY19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43714 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754167AbdLTJRW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 04:17:22 -0500
Content-Disposition: inline
In-Reply-To: <20171220084859.GY19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org, patrick.bellasi@arm.com

On Wed, Dec 20, 2017 at 02:18:59PM +0530, Viresh Kumar wrote:
> On 20-12-17, 09:31, Peter Zijlstra wrote:
> What about this case: A CFS task is running currently and an RT task
> is enqueued.
> 
> - Is it always the case that the CFS task is preempted immediately and
>   the CPU is given to RT task ? I was talking to Vincent earlier and
>   he told me that for certain configurations the CFS task may keep
>   running until the next tick.
> 
> - What if the CFS task has disabled preemption ?
> 
> - More corner cases like this ?

If there is a runnable RT task we'll schedule to it ASAP. This means
for:

 CONFIG_PREEMPT=y

   either immediately or when next preempt_enable() hits a 0
   preempt_count.

 CONFIG_PREEMPT=n

   on any next kernel preemption point or when returning to userspace.

But this is not something we should worry about.

From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Tue, 19 Dec 2017 20:25:04 +0100
Message-ID: <20171219192504.nstxsfii6y7rh37w@hirez.programming.kicks-ass.net>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:50046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752778AbdLSTZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 14:25:12 -0500
Content-Disposition: inline
In-Reply-To: <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

On Wed, Dec 13, 2017 at 03:23:21PM +0530, Viresh Kumar wrote:
> Currently the schedutil governor overwrites the sg_cpu->flags field on
> every call to the utilization handler. It was pretty good as the initial
> implementation of utilization handlers, there are several drawbacks
> though.
> 
> The biggest drawback is that the sg_cpu->flags field doesn't always
> represent the correct type of tasks that are enqueued on a CPU's rq. For
> example, if a fair task is enqueued while a RT or DL task is running, we
> will overwrite the flags with value 0 and that may take the CPU to lower
> OPPs unintentionally. There can be other corner cases as well which we
> aren't aware of currently.
> 
> This patch changes the current implementation to keep track of all the
> task types that are currently enqueued to the CPUs rq. A new flag: CLEAR
> is introduced and is set by the scheduling classes when their last task
> is dequeued. When the CLEAR flag bit is set, the schedutil governor resets
> all the other flag bits that are present in the flags parameter. For
> now, the util update handlers return immediately if they were called to
> clear the flag.

Yeah, not happy about this either; we had code that did the right thing
without this extra tracking I think.

Also, we can look at the rq state if we want to, we don't need to
duplicate that state.

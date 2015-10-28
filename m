From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/5] cpufreq: ondemand: Drop unnecessary locks from
 update_sampling_rate()
Date: Wed, 28 Oct 2015 10:14:51 +0530
Message-ID: <20151028044451.GA30039@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <56084623b2c27372a4c2c598151dd47176c3e26f.1444723240.git.viresh.kumar@linaro.org>
 <9152551.Va141R8GGE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36147 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbJ1Eo5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 00:44:57 -0400
Received: by pacfv9 with SMTP id fv9so255103654pac.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2015 21:44:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9152551.Va141R8GGE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>

On 28-10-15, 05:05, Rafael J. Wysocki wrote:
> On Tuesday, October 13, 2015 01:39:01 PM Viresh Kumar wrote:
> > 'timer_mutex' is required to sync work-handlers of policy->cpus.
> > update_sampling_rate() is just canceling the works and queuing them
> > again. This isn't protecting anything at all in update_sampling_rate()
> > and is not gonna be of any use.
> > 
> > Even if a work-handler is already running for a CPU,
> > cancel_delayed_work_sync() will wait for it to finish.
> > 
> > Drop these unnecessary locks.
> > 
> > Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I'm queuing this up for 4.4, although I think that the changelog is not right.
> 
> While at it, what are the race conditions the lock is protecting against?

In cases where a single policy controls multiple CPUs, a timer is
queued for every cpu present in policy->cpus. When we reach the timer
handler (which can be on multiple CPUs together) on any CPU, we trace
CPU load for all policy->cpus and update the frequency accordingly.

The lock is for protecting multiple CPUs to do the same thing
together, as only its required to be done by a single CPU. Once any
CPUs handler has completed, it updates the last update time and drops
the mutex. At that point of time, other blocked handler (if any) check
the last update time and return early.

And then there are enough minute things that can go wrong if multiple
CPUs do the load evaluation and freq-update at the same time, apart
from it being an time wasting effort.

And so I still think that the commit log isn't that bad. The
timer_mutex lock isn't required in other parts of the governor, they
are just for synchronizing the work-handlers of CPUs belonging to the
same policy.

-- 
viresh

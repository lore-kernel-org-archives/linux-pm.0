From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/5] cpufreq: ondemand: Drop unnecessary locks from
 update_sampling_rate()
Date: Wed, 28 Oct 2015 12:13:17 +0530
Message-ID: <20151028064317.GB30039@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <9152551.Va141R8GGE@vostro.rjw.lan>
 <20151028044451.GA30039@ubuntu>
 <4304226.RJrgDykfyW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35897 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbJ1GnY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 02:43:24 -0400
Received: by pacfv9 with SMTP id fv9so258370687pac.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2015 23:43:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4304226.RJrgDykfyW@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>

On 28-10-15, 06:54, Rafael J. Wysocki wrote:
> On Wednesday, October 28, 2015 10:14:51 AM Viresh Kumar wrote:
> > In cases where a single policy controls multiple CPUs, a timer is
> > queued for every cpu present in policy->cpus. When we reach the timer
> > handler (which can be on multiple CPUs together) on any CPU, we trace
> > CPU load for all policy->cpus and update the frequency accordingly.
> 
> That would be in dbs_timer(), right?

Yeah, and we already do stuff from within the mutex there.

> > The lock is for protecting multiple CPUs to do the same thing
> > together, as only its required to be done by a single CPU. Once any
> > CPUs handler has completed, it updates the last update time and drops
> > the mutex. At that point of time, other blocked handler (if any) check
> > the last update time and return early.
> 
> Well, that would mean we only needed to hold the lock around the
> need_load_eval() evaluation in dbs_timer() if I'm not mistaken.

Actually yeah, but then the fourth patch of this series uses the
timer_mutex to fix a long standing problem (which was fixed by hacking
the code earlier). And so we need to take the lock for the entire
dbs_timer() routine.

> We also should acquire it around updates of the sampling rate, which
> essentially is set_sampling_rate().

Why? In the worst case we may schedule the next timer for the earlier
sampling rate. But do we care that much for that race, that we want to
add locks here as well ?

> Is there any reason to acquire it in cpufreq_governor_limits(), then,
> for example?

Yeah, we are calling dbs_check_cpu(dbs_data, cpu) from that path,
which will reevaluate the load.

-- 
viresh

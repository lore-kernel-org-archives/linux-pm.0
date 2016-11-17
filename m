From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Avoid a couple of races related to
 cpufreq_cpu_get()
Date: Thu, 17 Nov 2016 19:27:09 +0530
Message-ID: <20161117135709.GA3380@vireshk-i7>
References: <7191200.L2L3Fy8tSf@vostro.rjw.lan>
 <20161117063306.GC4894@vireshk-i7>
 <CAJZ5v0hYfDr0P6zG9GcCr_x_epQihxB8FdzpYH_hOUDSEc18BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36350 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbcKQRtl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 12:49:41 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so50310795pfz.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2016 09:49:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hYfDr0P6zG9GcCr_x_epQihxB8FdzpYH_hOUDSEc18BQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 17-11-16, 14:35, Rafael J. Wysocki wrote:
> That unless cpu == policy->cpu and it is going offline I suppose?
> 
> The scenario is as follows.  cpufreq_get() is invoked for policy->cpu
> and cpufreq_offline() runs for it at the same time.
> 
> cpufreq_get() calls cpufreq_cpu_get() which does the policy->cpus
> check which passes, because cpufreq_offline() hasn't updated the mask
> yet.  Now cpufreq_offline() updates the mask and proceeds with
> cpufreq_driver->stop_cpu() and cpufreq_driver->exit().  Then, it drops
> the lock.
> 
> cpufreq_get() acquires the lock.  The policy is still there, but it
> may be inactive at this point.  Still, cpufreq_get() doesn't check
> that, but invokes __cpufreq_get() unconditionally, which calls
> cpufreq_driver->get(policy->cpu).  Is this still guaranteed to work?
> I don't think so.
> 
> It looks like a policy_is_inactive() check should be there in
> cpufreq_get() at least.

Okay, trying to do any operations on the device for an inactive policy is
absolutely wrong. I agree.

> >> +
> >>               up_read(&policy->rwsem);
> >>
> >>               cpufreq_cpu_put(policy);
> >> @@ -2142,6 +2154,11 @@ int cpufreq_get_policy(struct cpufreq_po
> >>       if (!cpu_policy)
> >>               return -EINVAL;
> >>
> >> +     if (!cpumask_test_cpu(cpu, policy->cpus)) {
> >> +             cpufreq_cpu_put(cpu_policy);
> >> +             return -EINVAL;
> >> +     }
> >> +
> >
> > We are just copying the policy here, so it should be always safe.
> 
> So the check is not necessary at all?

Right.

> Say the CPU is the only one in the policy and it is going offline.
> 
> cpufreq_update_policy() is invoked at the same time and calls
> cpufreq_cpu_get() which checks policy->cpus and the test passes,
> because cpufreq_offline() hasn't updated the mask yet.  The
> cpufreq_offline() updates the mask and the policy becomes inactive,
> but there are no checks for that going forward, unless Im overlooking
> something again.

Same here. I agree.

> > Also, even if we have some real cases for cpufreq_cpu_get_raw(), which
> > needs to get fixed, I believe that we can move the check to
> > cpufreq_cpu_get() and not to every caller.
> 
> I disagree, but for now I'm going to leave cpufreq_cpu_get() alone.
> To me, the policy->cpus check in cpufreq_cpu_get_raw() is just
> confusing (it isn't even needed by some callers of that function),
> which is the reason why I'd prefer to get rid of it.

Okay.

> I'll add policy_is_inactive() checks to cpufreq_get() and
> cpufreq_update_policy() at this point.

That would be much better I think.

-- 
viresh

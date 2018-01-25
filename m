From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [PATCH v3 2/3] sched/fair: use util_est in LB and WU paths
Date: Thu, 25 Jan 2018 20:03:58 +0530
Message-ID: <20180125143358.GE30677@codeaurora.org>
References: <20180123180847.4477-1-patrick.bellasi@arm.com>
 <20180123180847.4477-3-patrick.bellasi@arm.com>
 <20180124113342.GD30677@codeaurora.org>
 <20180124193138.GB5739@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52758 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeAYOeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jan 2018 09:34:06 -0500
Content-Disposition: inline
In-Reply-To: <20180124193138.GB5739@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>

On Wed, Jan 24, 2018 at 07:31:38PM +0000, Patrick Bellasi wrote:
> 
> > > +       /*
> > > +        * These are the main cases covered:
> > > +        * - if *p is the only task sleeping on this CPU, then:
> > > +        *      cpu_util (== task_util) > util_est (== 0)
> > > +        *   and thus we return:
> > > +        *      cpu_util_wake = (cpu_util - task_util) = 0
> > > +        *
> > > +        * - if other tasks are SLEEPING on the same CPU, which is just waking
> > > +        *   up, then:
> > > +        *      cpu_util >= task_util
> > > +        *      cpu_util > util_est (== 0)
> > > +        *   and thus we discount *p's blocked utilization to return:
> > > +        *      cpu_util_wake = (cpu_util - task_util) >= 0
> > > +        *
> > > +        * - if other tasks are RUNNABLE on that CPU and
> > > +        *      util_est > cpu_util
> > > +        *   then we use util_est since it returns a more restrictive
> > > +        *   estimation of the spare capacity on that CPU, by just considering
> > > +        *   the expected utilization of tasks already runnable on that CPU.
> > > +        */
> > > +       util_est = cpu_rq(cpu)->cfs.util_est_runnable;
> > > +       util = max(util, util_est);
> > > +
> > > +       return util;
> 
> I should instead clamp util before returning it! ;-)
> 
> > May be a separate patch to remove  the clamping part?
> 
> No, I think we should keep cpu_util_wake clamped to not affect the existing
> call sites. I just need to remove it where not needed (done) and add it where
> needed (will do on the next iteration).

cpu_util_wake() is called only from capacity_spare_wake(). There are no other
callsites. The capacity_spare_wake() is clamping the return value of
cpu_util_wake() to CPU capacity. The clamping is not needed, I think.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/fair: Invoke cpufreq hooks for CONFIG_SMP unset
Date: Sat, 7 May 2016 08:30:51 +0200
Message-ID: <20160507063051.GA23722@gmail.com>
References: <6282396.VVEdgVYxO3@vostro.rjw.lan>
 <20160507061310.GA15728@worktop.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36299 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbcEGGa4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 May 2016 02:30:56 -0400
Content-Disposition: inline
In-Reply-To: <20160507061310.GA15728@worktop.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, May 06, 2016 at 02:58:43PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Commit 34e2c555f3e1 (cpufreq: Add mechanism for registering utilization
> > update callbacks) overlooked the fact that update_load_avg(), where
> > CFS invokes cpufreq utilization update hooks, becomes an empty stub for
> > CONFIG_SMP unset.  In consequence, if CONFIG_SMP is not set, cpufreq
> > governors are never invoked from CFS and they do not have a chance to
> > evaluate CPU performace levels and update them often enough.  Needless
> > to say, things don't work as expected then.
> > 
> > Fix the problem by making the !CONFIG_SMP stub of update_load_avg()
> > invoke cpufreq update hooks too.
> > 
> > Fixes: 34e2c555f3e1 (cpufreq: Add mechanism for registering utilization update callbacks)
> > Reported-by: Steve Muckle <steve.muckle@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rafael; feel free to push this through the pm tree.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I already have it in sched/urgent.

Thanks,

	Ingo

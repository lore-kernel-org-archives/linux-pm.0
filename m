From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Thu, 21 Dec 2017 13:04:05 +0530
Message-ID: <20171221073405.GD19815@vireshk-i7>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35269 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdLUHeK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Dec 2017 02:34:10 -0500
Received: by mail-pl0-f65.google.com with SMTP id b96so10532604pli.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2017 23:34:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 20-12-17, 16:30, Peter Zijlstra wrote:
> 
> So I ended up with the below (on top of Juri's cpufreq-dl patches).

Nice :)

There are two things that I noticed in your tree.

Firstly, there is no need of the following patch as we shouldn't have
the problem mentioned in the commit anymore:

38e19dbe1286 cpufreq: schedutil: ignore sugov kthreads

And maybe we can apply the below patch after that (only compile
tested).

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 21 Dec 2017 12:52:50 +0530
Subject: [PATCH] cpufreq/schedutil: Call sugov_get_util() only when required

sugov_update_shared() doesn't use the updated values of max, util_cfs
and util_dl, unless we try to find the next frequency by calling
sugov_next_freq_shared() and so there is no need to call it directly
from sugov_update_shared(). Rather postpone it until the time
sugov_next_freq_shared() is called for one of the CPUs that share the
policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ab84d2261554..f2f4df26b954 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -315,8 +315,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		unsigned long j_util, j_max;
 		s64 delta_ns;
 
-		if (j_sg_cpu != sg_cpu)
-			sugov_get_util(j_sg_cpu);
+		sugov_get_util(j_sg_cpu);
 
 		/*
 		 * If the CFS CPU utilization was last updated before the
@@ -354,7 +353,6 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-	sugov_get_util(sg_cpu);
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 

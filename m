From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 5/6] cpufreq: schedutil: avoid utilisation update when not necessary
Date: Thu,  2 Mar 2017 15:45:06 +0000
Message-ID: <1488469507-32463-6-git-send-email-patrick.bellasi@arm.com>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753003AbdCBPql (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Mar 2017 10:46:41 -0500
In-Reply-To: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

Under certain conditions (i.e. CPU entering idle and current task being
the sugov thread) we can skip a frequency update.
Thus, let's postpone the collection of the FAIR utilisation when really
needed.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 44bff37..c8ed645 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -296,8 +296,6 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	unsigned int next_f;
 	bool rt_mode;
 
-	sugov_get_util(&util, &max);
-
 	raw_spin_lock(&sg_policy->update_lock);
 
 	/* CPU is entering IDLE, reset flags without triggering an update */
@@ -323,6 +321,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	else
 		sg_cpu->flags = flags;
 
+	sugov_get_util(&util, &max);
 	sg_cpu->util = util;
 	sg_cpu->max = max;
 
-- 
2.7.4

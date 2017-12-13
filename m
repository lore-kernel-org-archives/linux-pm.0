From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/4] cpufreq: schedutil: Don't call sugov_get_util() unnecessarily
Date: Wed, 13 Dec 2017 15:23:23 +0530
Message-ID: <7b0698a61bcb959704f58dbabe8c70d657210301.1513158452.git.viresh.kumar@linaro.org>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513158452.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513158452.git.viresh.kumar@linaro.org>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

sugov_update_shared() may get called to clear the scheduling class flags
and we would return immediately in that case. Calling sugov_get_util()
in that case isn't going to be of any use then. Move invocation of
sugov_get_util() after the clear flag is checked.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7edfdc59ee8f..b69c37c867fe 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -349,8 +349,6 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	unsigned long util, max;
 	unsigned int next_f;
 
-	sugov_get_util(&util, &max, sg_cpu->cpu);
-
 	raw_spin_lock(&sg_policy->update_lock);
 
 	if (unlikely(flags & SCHED_CPUFREQ_CLEAR)) {
@@ -358,6 +356,8 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 		goto unlock;
 	}
 
+	sugov_get_util(&util, &max, sg_cpu->cpu);
+
 	sg_cpu->util = util;
 	sg_cpu->max = max;
 	sg_cpu->flags |= flags;
-- 
2.15.0.194.g9af6a3dea062

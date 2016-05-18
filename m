From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/6] cpufreq: schedutil: Improve prints messages with pr_fmt
Date: Wed, 18 May 2016 17:55:28 +0530
Message-ID: <30cb533c2e24d22832cbc2953c51fa3cf60cd202.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Prefix print messages with KBUILD_MODNAME, i.e 'cpufreq_schedutil: '.
This helps to keep similar formatting for all the print messages
particular to a file and identify those easily in kernel logs.

Its already done this way for rest of the governors.

Along with that, remove the (now) redundant bits from a print message.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 154ae3a51e86..14c4aa25cc45 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -9,6 +9,8 @@
  * published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/cpufreq.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -388,7 +390,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	mutex_unlock(&global_tunables_lock);
 
 	sugov_policy_free(sg_policy);
-	pr_err("cpufreq: schedutil governor initialization failed (error %d)\n", ret);
+	pr_err("initialization failed (error %d)\n", ret);
 	return ret;
 }
 
-- 
2.7.1.410.g6faf27b

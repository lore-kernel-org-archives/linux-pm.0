From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v3 4/5] Revert "cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications"
Date: Mon,  2 Mar 2015 17:17:22 +0000
Message-ID: <1425316643-31991-5-git-send-email-javi.merino@arm.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, lina.iyer@linaro.org, broonie@kernel.org, tixy@linaro.org, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

This reverts commit d9f354460db8 ("cpufreq: remove
CPUFREQ_UPDATE_POLICY_CPU notifications").  When the lead cpu of a group
of cpus managed by cpufreq is hotplugged out, the cpu device cached in
drivers/thermal/cpu_cooling.c needs to be updated accordingly.

Bring back the CPUFREQ_UPDATE_POLICY_CPU notifier so that we can react
to it.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
Hi Viresh,

We just noticed that you removed this from v4.0-rc1 when we were
planning on using it, that's why are reverting the patch.  The user is
introduced in the next patch: "[PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when cpufreq updates the policy cpu".

 drivers/cpufreq/cpufreq.c | 3 +++
 include/linux/cpufreq.h   | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 28e59a48b35f..215147050c3d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1095,6 +1095,9 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
 	policy->cpu = cpu;
 	up_write(&policy->rwsem);
 
+	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+			CPUFREQ_UPDATE_POLICY_CPU, policy);
+
 	return 0;
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2ee4888c1f47..7e1a389b4e92 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -368,8 +368,9 @@ static inline void cpufreq_resume(void) {}
 #define CPUFREQ_INCOMPATIBLE		(1)
 #define CPUFREQ_NOTIFY			(2)
 #define CPUFREQ_START			(3)
-#define CPUFREQ_CREATE_POLICY		(4)
-#define CPUFREQ_REMOVE_POLICY		(5)
+#define CPUFREQ_UPDATE_POLICY_CPU	(4)
+#define CPUFREQ_CREATE_POLICY		(5)
+#define CPUFREQ_REMOVE_POLICY		(6)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
1.9.1

From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 04/19] cpufreq: bring data structures close to their locks
Date: Mon, 11 Jan 2016 17:35:45 +0000
Message-ID: <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

Currently it is not easy to figure out which lock/mutex protects which data
structure. Clean things up by moving data structures and their locks/mutexs
closer; also, change comments to document relations further.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2e41356..00a00cd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -31,7 +31,25 @@
 #include <linux/tick.h>
 #include <trace/events/power.h>
 
+/**
+ * Iterate over governors
+ *
+ * cpufreq_governor_list is protected by cpufreq_governor_mutex.
+ */
+static LIST_HEAD(cpufreq_governor_list);
+static DEFINE_MUTEX(cpufreq_governor_mutex);
+#define for_each_governor(__governor)				\
+	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
+
+/**
+ * The "cpufreq driver" - the arch- or hardware-dependent low
+ * level driver of CPUFreq support, and its spinlock (cpufreq_driver_lock).
+ * This lock also protects cpufreq_cpu_data array and cpufreq_policy_list.
+ */
+static struct cpufreq_driver *cpufreq_driver;
+static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static LIST_HEAD(cpufreq_policy_list);
+static DEFINE_RWLOCK(cpufreq_driver_lock);
 
 static inline bool policy_is_inactive(struct cpufreq_policy *policy)
 {
@@ -86,21 +104,6 @@ static struct cpufreq_policy *first_policy(bool active)
 #define for_each_inactive_policy(__policy)		\
 	for_each_suitable_policy(__policy, false)
 
-/* Iterate over governors */
-static LIST_HEAD(cpufreq_governor_list);
-#define for_each_governor(__governor)				\
-	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
-
-/**
- * The "cpufreq driver" - the arch- or hardware-dependent low
- * level driver of CPUFreq support, and its spinlock. This lock
- * also protects the cpufreq_cpu_data array.
- */
-static struct cpufreq_driver *cpufreq_driver;
-static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
-static DEFINE_RWLOCK(cpufreq_driver_lock);
-static DEFINE_MUTEX(cpufreq_governor_mutex);
-
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
-- 
2.2.2

From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv6 PATCH 02/10] cpufreq: introduce cpufreq_driver_is_slow
Date: Tue,  8 Dec 2015 22:19:23 -0800
Message-ID: <1449641971-20827-3-git-send-email-smuckle@linaro.org>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34419 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbbLIGTj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 01:19:39 -0500
Received: by pfbg73 with SMTP id g73so25315068pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 22:19:38 -0800 (PST)
In-Reply-To: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Michael Turquette <mturquette@baylibre.com>

Some architectures and platforms perform CPU frequency transitions
through a non-blocking method, while some might block or sleep. Even
when frequency transitions do not block or sleep they may be very slow.
This distinction is important when trying to change frequency from
a non-interruptible context in a scheduler hot path.

Describe this distinction with a cpufreq driver flag,
CPUFREQ_DRIVER_FAST. The default is to not have this flag set,
thus erring on the side of caution.

cpufreq_driver_is_slow() is also introduced in this patch. Setting
the above flag will allow this function to return false.

[smuckle@linaro.org: change flag/API to include drivers that are too
 slow for scheduler hot paths, in addition to those that block/sleep]

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++++++
 include/linux/cpufreq.h   | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7c48e73..8482820 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -154,6 +154,12 @@ bool have_governor_per_policy(void)
 }
 EXPORT_SYMBOL_GPL(have_governor_per_policy);
 
+bool cpufreq_driver_is_slow(void)
+{
+	return !(cpufreq_driver->flags & CPUFREQ_DRIVER_FAST);
+}
+EXPORT_SYMBOL_GPL(cpufreq_driver_is_slow);
+
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
 {
 	if (have_governor_per_policy())
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index ef4c5b1..7f8c63d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -159,6 +159,7 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 int cpufreq_update_policy(unsigned int cpu);
 bool have_governor_per_policy(void);
+bool cpufreq_driver_is_slow(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 #else
 static inline unsigned int cpufreq_get(unsigned int cpu)
@@ -316,6 +317,14 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NEED_INITIAL_FREQ_CHECK	(1 << 5)
 
+/*
+ * Indicates that it is safe to call cpufreq_driver_target from
+ * non-interruptable context in scheduler hot paths.  Drivers must
+ * opt-in to this flag, as the safe default is that they might sleep
+ * or be too slow for hot path use.
+ */
+#define CPUFREQ_DRIVER_FAST		(1 << 6)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.4.10


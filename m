From: Konstantin Krivyakin <k.krivyakin@samsung.com>
Subject: [PATCH RFC 1/3] Add interface to receive current cpu power
Date: Tue, 30 Jul 2013 12:17:37 +0400
Message-ID: <1375172259-9641-2-git-send-email-k.krivyakin@samsung.com>
References: <1375172259-9641-1-git-send-email-k.krivyakin@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38486 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976Ab3G3IR4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 04:17:56 -0400
In-reply-to: <1375172259-9641-1-git-send-email-k.krivyakin@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, rjw@sisk.pl, viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org, kgene.kim@samsung.com, linux-pm@vger.kernel.org
Cc: k.krivyakin@samsung.com, i.zhbanov@samsung.com, e.voevodin@samsung.com, kyungmin.park@samsung.com, akpm@linux-foundation.org

Signed-off-by: Konstantin Krivyakin <k.krivyakin@samsung.com>
---
 drivers/cpufreq/cpufreq.c |   17 +++++++++++++++++
 include/linux/cpufreq.h   |    6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6a015ad..4180e89 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1538,6 +1538,23 @@ int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list)
 }
 EXPORT_SYMBOL(cpufreq_unregister_notifier);
 
+/**
+ * cpu_power_get - get current CPU power
+ * @cpu: CPU number
+ */
+u64 cpu_power_get(int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	u64 ret_power = 0;
+
+	if (policy) {
+		ret_power = policy->current_power;
+		cpufreq_cpu_put(policy);
+	}
+
+	return ret_power;
+}
+EXPORT_SYMBOL(cpu_power_get);
 
 /*********************************************************************
  *                              GOVERNORS                            *
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 4d7390b..67323af 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -107,6 +107,7 @@ struct cpufreq_policy {
 	unsigned int		max;    /* in kHz */
 	unsigned int		cur;    /* in kHz, only needed if cpufreq
 					 * governors are used */
+	u64			current_power;
 	unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
@@ -365,6 +366,7 @@ static inline unsigned int cpufreq_get(unsigned int cpu)
 #ifdef CONFIG_CPU_FREQ
 unsigned int cpufreq_quick_get(unsigned int cpu);
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
+u64 cpu_power_get(int cpu);
 #else
 static inline unsigned int cpufreq_quick_get(unsigned int cpu)
 {
@@ -374,6 +376,10 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
 {
 	return 0;
 }
+static inline u64 cpu_power_get(unsigned int cpu)
+{
+	return 0;
+}
 #endif
 
 /*********************************************************************
-- 
1.7.9.5


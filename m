From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/5] Thermal: Introduce cpu cooling table
Date: Wed,  6 Feb 2013 12:30:03 +0800
Message-ID: <1360125006-25018-3-git-send-email-rui.zhang@intel.com>
References: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19511 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756944Ab3BFEaP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Feb 2013 23:30:15 -0500
In-Reply-To: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.daniel@samsung.com, gu1@aeroxteam.fr, hongbo.zhang@linaro.org, Zhang Rui <rui.zhang@intel.com>

CPU cooling table is a cleaned cpufreq_frequency_table that
1. each entry represents a cooling state,
   aka, each entry has a different frequency.
2. does not have invalid entry.
3. does not have duplicate entry.
4. the frequencies of all the entries are in descending order.

we should use this table inside thermal layer and thermal drivers.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c |   63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 455c77a..08f12c7 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -115,6 +115,69 @@ static int is_cpufreq_valid(int cpu)
 	return !cpufreq_get_policy(&policy, cpu);
 }
 
+/*
+ * get the cleaned cpufreq_frequency_table that
+ * 1) does not have invalid entries
+ * 2) does not have duplicate entries
+ * 3) the frequency of the entries are in descending order
+ */
+static struct cpufreq_frequency_table *
+get_cpu_cooling_table(unsigned int cpu)
+{
+	int i = 0;
+	int level;
+	struct cpufreq_frequency_table *old, *new;
+	unsigned int freq = CPUFREQ_ENTRY_INVALID;
+	int descend = -1;
+
+	old = cpufreq_frequency_get_table(cpu);
+	if (!old)
+		return ERR_PTR(-EINVAL);
+
+	while (old[i].frequency != CPUFREQ_TABLE_END)
+		i++;
+
+	i++; /* one more entry for CPUFREQ_TABLE_END */
+
+	new = kzalloc(i * sizeof(struct cpufreq_frequency_table), GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0, level = 0; old[i].frequency != CPUFREQ_TABLE_END; i++) {
+		/* ignore invalid entry */
+		if (old[i].frequency == CPUFREQ_ENTRY_INVALID)
+			continue;
+
+		/* ignore duplicate entry */
+		if (freq == old[i].frequency)
+			continue;
+
+		/* found an valid entry */
+		new[level].frequency = old[i].frequency;
+
+		if (freq != CPUFREQ_ENTRY_INVALID && descend == -1)
+			descend = !!(freq > old[i].frequency);
+
+		/* freq always equals the last valid frequency */
+		freq = new[level].frequency;
+
+		level++;
+	}
+	new[level].frequency = CPUFREQ_ENTRY_INVALID;
+
+	/* convert to decending if in ascending order */
+	if (!descend) {
+		for(i = 0; i < (level - i - 1); i++) {
+			int j = level - i - 1;
+			freq = new[i].frequency;
+			new[i].frequency = new[j].frequency;
+			new[j].frequency = freq;
+		}
+	}
+
+	return new;
+}
+
 /**
  * get_cpu_frequency - get the absolute value of frequency from level.
  * @cpu: cpu for which frequency is fetched.
-- 
1.7.9.5


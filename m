From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 01/44] cpufreq: Add new helper cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:03 +0530
Message-ID: <da0b370692a107bc767bf1e57beba0a30d405703.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Almost every cpufreq driver is required to validate its frequency table with:
cpufreq_frequency_table_cpuinfo() and then expose it to cpufreq core with:
cpufreq_frequency_table_get_attr().

This patch creates another helper routine cpufreq_table_validate_and_show() that
will do both these steps in a single call and will return 0 for success, error
otherwise.

This also fixes potential bugs in cpufreq drivers where people have called
cpufreq_frequency_table_get_attr() before calling
cpufreq_frequency_table_cpuinfo(), as the later may fail.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/freq_table.c | 12 ++++++++++++
 include/linux/cpufreq.h      |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index f111454a..11f6fa9 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -219,6 +219,18 @@ void cpufreq_frequency_table_put_attr(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_put_attr);
 
+int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
+				      struct cpufreq_frequency_table *table)
+{
+	int ret = cpufreq_frequency_table_cpuinfo(policy, table);
+
+	if (!ret)
+		cpufreq_frequency_table_get_attr(table, policy->cpu);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpufreq_table_validate_and_show);
+
 void cpufreq_frequency_table_update_policy_cpu(struct cpufreq_policy *policy)
 {
 	pr_debug("Updating show_table for new_cpu %u from last_cpu %u\n",
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index fcabc42..6b199ed 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -410,5 +410,7 @@ extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *table,
 				      unsigned int cpu);
 void cpufreq_frequency_table_put_attr(unsigned int cpu);
+int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
+				      struct cpufreq_frequency_table *table);
 
 #endif /* _LINUX_CPUFREQ_H */
-- 
1.7.12.rc2.18.g61b472e


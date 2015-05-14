From: Ruchi Kandoi <kandoiruchi@google.com>
Subject: [PATCH 1/2] cpufreq_stats: Adds sysfs file /sys/devices/system/cpu/cpufreq/current_in_state
Date: Thu, 14 May 2015 16:55:47 -0700
Message-ID: <1431647748-13221-2-git-send-email-kandoiruchi@google.com>
References: <1431647748-13221-1-git-send-email-kandoiruchi@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431647748-13221-1-git-send-email-kandoiruchi@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kandoiruchi@google.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Adds the sysfs file for userspace to initialize the active current
values for all the cores at each of the frequencies.

The format for storing the values is as follows:
echo "CPU<cpu#>:<freq1>=<current in uA> <freq2>=<current>,CPU<cpu#>:
..." > /sys/devices/system/cpu/cpufreq/current_in_state

Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
---
 drivers/cpufreq/cpufreq_stats.c | 163 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 5e370a3..6f0b562 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -30,6 +30,14 @@ struct cpufreq_stats {
 #endif
 };
 
+struct cpufreq_power_stats {
+	unsigned int state_num;
+	unsigned int *curr;
+	unsigned int *freq_table;
+};
+
+static DEFINE_PER_CPU(struct cpufreq_power_stats *, cpufreq_power_stats);
+
 static int cpufreq_stats_update(struct cpufreq_stats *stats)
 {
 	unsigned long long cur_time = get_jiffies_64();
@@ -61,6 +69,87 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	return len;
 }
 
+static void store_current_value(struct cpufreq_power_stats *powerstats,
+		int freq, int curr)
+{
+	int i;
+
+	/* freq_table doesn't contain any CPU_FREQ_INVALID */
+	for (i = 0; i < powerstats->state_num; i++) {
+		if (powerstats->freq_table[i] == freq) {
+			powerstats->curr[i] = curr;
+			break;
+		}
+	}
+}
+
+static ssize_t store_current_in_state(struct cpufreq_policy *policy,
+		const char *buf, size_t len)
+{
+	char *cp, *cp2, *start, *buffer;
+	unsigned int cpu_num, ret, curr, freq;
+	struct cpufreq_power_stats *powerstats;
+
+	if (!buf || len < 0)
+		return len;
+
+	buffer = kzalloc(len + 1, GFP_KERNEL);
+	if (!buffer)
+		return len;
+
+	strncpy(buffer, buf, len);
+	buffer[len] = '\0';
+	cp = buffer;
+	spin_lock(&cpufreq_stats_lock);
+	while ((start = strsep(&cp, ","))) {
+		ret = sscanf(start, "CPU%u:", &cpu_num);
+		if (ret != 1 || cpu_num > (num_possible_cpus() - 1)) {
+			ret = -EINVAL;
+			goto error;
+		}
+		powerstats = per_cpu(cpufreq_power_stats, cpu_num);
+		if (!powerstats)
+			continue;
+
+		/* sscanf makes sure that strchr doesn't return a NULL */
+		cp2 = strchr(start, ':') + 1;
+		while ((start = strsep(&cp2, " "))) {
+			if (sscanf(start, "%u=%u", &freq, &curr) != 2) {
+				ret = -EINVAL;
+				goto error;
+			}
+			store_current_value(powerstats, freq, curr);
+		}
+	}
+	ret = len;
+error:
+	spin_unlock(&cpufreq_stats_lock);
+	kfree(buffer);
+	return ret;
+}
+
+static ssize_t show_current_in_state(struct cpufreq_policy *policy, char *buf)
+{
+	ssize_t len = 0;
+	unsigned int i, cpu;
+	struct cpufreq_power_stats *powerstats;
+
+	spin_lock(&cpufreq_stats_lock);
+	for_each_possible_cpu(cpu) {
+		powerstats = per_cpu(cpufreq_power_stats, cpu);
+		if (!powerstats)
+			continue;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "CPU%d:", cpu);
+		for (i = 0; i < powerstats->state_num; i++)
+			len += scnprintf(buf + len, PAGE_SIZE - len,
+					"%d=%d ", powerstats->freq_table[i],
+					powerstats->curr[i]);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+	}
+	spin_unlock(&cpufreq_stats_lock);
+	return len;
+}
+
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 {
@@ -107,6 +196,7 @@ cpufreq_freq_attr_ro(trans_table);
 
 cpufreq_freq_attr_ro(total_trans);
 cpufreq_freq_attr_ro(time_in_state);
+cpufreq_freq_attr_rw(current_in_state);
 
 static struct attribute *default_attrs[] = {
 	&total_trans.attr,
@@ -159,6 +249,67 @@ static void cpufreq_stats_free_table(unsigned int cpu)
 	cpufreq_cpu_put(policy);
 }
 
+static void cpufreq_powerstats_free(void)
+{
+	int cpu;
+	struct cpufreq_power_stats *powerstats;
+
+	sysfs_remove_file(cpufreq_global_kobject, &current_in_state.attr);
+
+	for_each_possible_cpu(cpu) {
+		powerstats = per_cpu(cpufreq_power_stats, cpu);
+		if (!powerstats)
+			continue;
+		kfree(powerstats->curr);
+		kfree(powerstats);
+		per_cpu(cpufreq_power_stats, cpu) = NULL;
+	}
+}
+
+static void cpufreq_powerstats_create(unsigned int cpu)
+{
+	unsigned int alloc_size, i = 0, j = 0, count = 0;
+	struct cpufreq_power_stats *powerstats;
+	struct cpufreq_frequency_table *pos, *table;
+
+	/* We need cpufreq table for creating power stats table */
+	table = cpufreq_frequency_get_table(cpu);
+	if (unlikely(!table))
+		return;
+
+	powerstats = kzalloc(sizeof(struct cpufreq_power_stats),
+			GFP_KERNEL);
+	if (!powerstats)
+		return;
+
+	/* Find total allocation size */
+	cpufreq_for_each_valid_entry(pos, table)
+		count++;
+
+	/* Allocate memory for freq table per cpu as well as clockticks per
+	 * freq*/
+	alloc_size = count * sizeof(unsigned int) +
+		count * sizeof(unsigned int);
+	powerstats->curr = kzalloc(alloc_size, GFP_KERNEL);
+	if (!powerstats->curr) {
+		kfree(powerstats);
+		return;
+	}
+	powerstats->freq_table = powerstats->curr + count;
+
+	spin_lock(&cpufreq_stats_lock);
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END && j < count; i++) {
+		unsigned int freq = table[i].frequency;
+
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		powerstats->freq_table[j++] = freq;
+	}
+	powerstats->state_num = j;
+	per_cpu(cpufreq_power_stats, cpu) = powerstats;
+	spin_unlock(&cpufreq_stats_lock);
+}
+
 static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 {
 	unsigned int i = 0, count = 0, ret = -ENOMEM;
@@ -249,9 +400,11 @@ static int cpufreq_stat_notifier_policy(struct notifier_block *nb,
 	int ret = 0;
 	struct cpufreq_policy *policy = data;
 
-	if (val == CPUFREQ_CREATE_POLICY)
+	if (val == CPUFREQ_CREATE_POLICY) {
 		ret = __cpufreq_stats_create_table(policy);
-	else if (val == CPUFREQ_REMOVE_POLICY)
+		if (!per_cpu(cpufreq_power_stats, policy->cpu))
+			cpufreq_powerstats_create(policy->cpu);
+	} else if (val == CPUFREQ_REMOVE_POLICY)
 		__cpufreq_stats_free_table(policy);
 
 	return ret;
@@ -335,8 +488,13 @@ static int __init cpufreq_stats_init(void)
 		return ret;
 	}
 
+	ret = sysfs_create_file(cpufreq_global_kobject, &current_in_state.attr);
+	if (ret)
+		pr_warn("Cannot create sysfs file for cpufreq current stats\n");
+
 	return 0;
 }
+
 static void __exit cpufreq_stats_exit(void)
 {
 	unsigned int cpu;
@@ -347,6 +505,7 @@ static void __exit cpufreq_stats_exit(void)
 			CPUFREQ_TRANSITION_NOTIFIER);
 	for_each_online_cpu(cpu)
 		cpufreq_stats_free_table(cpu);
+	cpufreq_powerstats_free();
 }
 
 MODULE_AUTHOR("Zou Nan hai <nanhai.zou@intel.com>");
-- 
2.2.0.rc0.207.ga3a616c

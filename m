From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: [PATCH] cpufreq: Add scaling frequency range support
Date: Tue, 28 Jul 2015 11:32:19 +0800
Message-ID: <55B6F7C3.8040405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16319 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934AbbG1Der (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jul 2015 23:34:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

From: Pan Xinhui <xinhuix.pan@intel.com>

Userspace at most time do cpufreq tests very much inconveniently.
Currently they have to echo min and max cpu freq separately like below:
echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

Add scaling_freq_range cpufreq attr to support userspace's demand.
Therefore it's easier for testers to write readable scripts like below: 
echo 480000-2240000 >
/sys/devices/system/cpu/cpu0/cpufreq/scaling_freq_range

Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
---
 drivers/cpufreq/cpufreq.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 26063af..6424e05 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -812,6 +812,35 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
 }
 
+static ssize_t store_scaling_freq_range(struct cpufreq_policy *policy,
+					char *buf, size_t count)
+{
+	int ret, temp_min, temp_max;
+	struct cpufreq_policy new_policy;
+
+	ret = cpufreq_get_policy(&new_policy, policy->cpu);
+	if (ret)
+		return -EINVAL;
+
+	ret = sscanf(buf, "%u-%u", &new_policy.min, &new_policy.max);
+	if (ret != 2)
+		return -EINVAL;
+
+	temp_min = new_policy.min;
+	temp_max = new_policy.max;
+	ret = cpufreq_set_policy(policy, &new_policy);
+	if (!ret) {
+		policy->user_policy.min = temp_min;
+		policy->user_policy.max = temp_max;
+	}
+	return ret ? ret : count;
+}
+
+static ssize_t show_scaling_freq_range(struct cpufreq_policy *policy, char *buf)
+{
+	return sprintf(buf, "%u-%u\n", policy->min, policy->max);
+}
+
 cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
 cpufreq_freq_attr_ro(cpuinfo_min_freq);
 cpufreq_freq_attr_ro(cpuinfo_max_freq);
@@ -826,6 +855,7 @@ cpufreq_freq_attr_rw(scaling_min_freq);
 cpufreq_freq_attr_rw(scaling_max_freq);
 cpufreq_freq_attr_rw(scaling_governor);
 cpufreq_freq_attr_rw(scaling_setspeed);
+cpufreq_freq_attr_rw(scaling_freq_range);
 
 static struct attribute *default_attrs[] = {
 	&cpuinfo_min_freq.attr,
@@ -839,6 +869,7 @@ static struct attribute *default_attrs[] = {
 	&scaling_driver.attr,
 	&scaling_available_governors.attr,
 	&scaling_setspeed.attr,
+	&scaling_freq_range.attr,
 	NULL
 };
 
-- 
1.9.1

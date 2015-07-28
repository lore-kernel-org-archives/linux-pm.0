From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: [PATCH V2] cpufreq: Add scaling frequency range support
Date: Tue, 28 Jul 2015 15:02:59 +0800
Message-ID: <55B72923.7030101@intel.com>
References: <55B6F7C3.8040405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45778 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbbG1HFb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jul 2015 03:05:31 -0400
In-Reply-To: <55B6F7C3.8040405@intel.com>
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
Change from V1:
	update cpu-freq documentation.
---
 Documentation/cpu-freq/user-guide.txt |  7 +++++++
 drivers/cpufreq/cpufreq.c             | 31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
index 109e97b..ac6dd7b 100644
--- a/Documentation/cpu-freq/user-guide.txt
+++ b/Documentation/cpu-freq/user-guide.txt
@@ -212,6 +212,13 @@ bios_limit :			If the BIOS tells the OS to limit a CPU to
 				which can be detected through the generic
 				thermal driver.
 
+scaling_freq_range :	show the current cpufreq range of policy (in
+				kHz) with format "%u-%u". In other words it shows the
+				scaling_min_freq and scaling_max_freq at same time. By
+				echoing new values with format "%u-%u" into this file,
+				you can change this range. first %u stands for
+				scaling_min_freq, second %u stands for scaling_max_freq.
+
 If you have selected the "userspace" governor which allows you to
 set the CPU operating frequency to a specific value, you can read out
 the current frequency in
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

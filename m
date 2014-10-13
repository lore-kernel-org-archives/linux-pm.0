From: dirk.brandewie@gmail.com
Subject: [PATCH 1/5] cpufreq: expose scaling_cur_freq sysfs file for set_policy() drivers
Date: Mon, 13 Oct 2014 08:37:40 -0700
Message-ID: <1413214664-17687-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:50782 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbaJMPhy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Oct 2014 11:37:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Currently the core does not expose scaling_cur_freq for set_policy()
drivers this breaks some userspace monitoring tools.
Change the core to expose this file for all drivers and if the
set_policy() driver supports the get() callback use it to retrieve the
current frequency.

References: https://bugzilla.kernel.org/show_bug.cgi?id=73741
Cc: stable@vger.kernel.org
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/cpufreq.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 61190f6..c05821e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -512,7 +512,18 @@ show_one(cpuinfo_max_freq, cpuinfo.max_freq);
 show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
 show_one(scaling_min_freq, min);
 show_one(scaling_max_freq, max);
-show_one(scaling_cur_freq, cur);
+
+static ssize_t show_scaling_cur_freq(
+	struct cpufreq_policy *policy, char *buf)
+{
+	ssize_t ret;
+
+	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
+		ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
+	else
+		ret = sprintf(buf, "%u\n", policy->cur);
+	return ret;
+}
 
 static int cpufreq_set_policy(struct cpufreq_policy *policy,
 				struct cpufreq_policy *new_policy);
@@ -906,11 +917,11 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 		if (ret)
 			goto err_out_kobj_put;
 	}
-	if (has_target()) {
-		ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
-		if (ret)
-			goto err_out_kobj_put;
-	}
+
+	ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
+	if (ret)
+		goto err_out_kobj_put;
+
 	if (cpufreq_driver->bios_limit) {
 		ret = sysfs_create_file(&policy->kobj, &bios_limit.attr);
 		if (ret)
-- 
1.9.3


From: Muhammad Falak R Wani <falakreyaz@gmail.com>
Subject: [PATCH 1/1] fix cpufreq/cpufreq.c some coding style issues
Date: Sun, 23 Aug 2015 21:09:19 +0530
Message-ID: <1440344359-7051-1-git-send-email-falakreyaz@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32968 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbHWPei (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2015 11:34:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Muhammad Falak R Wani <falakreyaz@gmail.com>

Hi,

	This patch fixes issues in coding style, of a missing blank line after
declarations.

Best,
mfrw

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8ae655c..5aea659 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -718,6 +718,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 {
 	unsigned int limit;
 	int ret;
+
 	if (cpufreq_driver->bios_limit) {
 		ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
 		if (!ret)
@@ -815,6 +816,7 @@ unlock:
 static void cpufreq_sysfs_release(struct kobject *kobj)
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
+
 	pr_debug("last reference is dropped\n");
 	complete(&policy->kobj_unregister);
 }
@@ -2129,6 +2131,7 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
 {
 	struct cpufreq_policy *cpu_policy;
+
 	if (!policy)
 		return -EINVAL;
 
-- 
1.9.1


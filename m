From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/17] cpufreq: s/__find_governor/find_governor
Date: Fri,  2 Jan 2015 12:34:26 +0530
Message-ID: <69fc0679af15f82572dfb74c1aed67021dfc36fe.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34432 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbbABHFO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:14 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so23337652pab.26
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:13 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Remove unnecessary __ present in find_governor's name.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4309b075df06..c9ba1d64015c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -432,7 +432,7 @@ static ssize_t store_boost(struct kobject *kobj, struct attribute *attr,
 }
 define_one_global_rw(boost);
 
-static struct cpufreq_governor *__find_governor(const char *str_governor)
+static struct cpufreq_governor *find_governor(const char *str_governor)
 {
 	struct cpufreq_governor *t;
 
@@ -468,7 +468,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 
 		mutex_lock(&cpufreq_governor_mutex);
 
-		t = __find_governor(str_governor);
+		t = find_governor(str_governor);
 
 		if (t == NULL) {
 			int ret;
@@ -478,7 +478,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 			mutex_lock(&cpufreq_governor_mutex);
 
 			if (ret == 0)
-				t = __find_governor(str_governor);
+				t = find_governor(str_governor);
 		}
 
 		if (t != NULL) {
@@ -935,7 +935,7 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
 	memcpy(&new_policy, policy, sizeof(*policy));
 
 	/* Update governor of new_policy to the governor used before hotplug */
-	gov = __find_governor(per_cpu(cpufreq_cpu_governor, policy->cpu));
+	gov = find_governor(per_cpu(cpufreq_cpu_governor, policy->cpu));
 	if (gov)
 		pr_debug("Restoring governor %s for cpu %d\n",
 				policy->governor->name, policy->cpu);
@@ -2089,7 +2089,7 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
 
 	governor->initialized = 0;
 	err = -EBUSY;
-	if (__find_governor(governor->name) == NULL) {
+	if (!find_governor(governor->name)) {
 		err = 0;
 		list_add(&governor->governor_list, &cpufreq_governor_list);
 	}
-- 
2.2.0


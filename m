From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Drop unnecessary check from cpufreq_policy_alloc()
Date: Wed, 31 Aug 2016 03:11:31 +0200
Message-ID: <3010935.IpTCVVCXDt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44320 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751499AbcHaBGb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 21:06:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since cpufreq_policy_alloc() doesn't use its dev variable for
anything useful, drop that variable from there along with the
NULL check against it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1073,13 +1073,9 @@ static void handle_update(struct work_st
 
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
-	struct device *dev = get_cpu_device(cpu);
 	struct cpufreq_policy *policy;
 	int ret;
 
-	if (WARN_ON(!dev))
-		return NULL;
-
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
 		return NULL;


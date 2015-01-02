From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/17] cpufreq: check cpufreq_policy_list instead of scanning policies for all CPUs
Date: Fri,  2 Jan 2015 12:34:35 +0530
Message-ID: <c7ce73584f4946ced7923f89538f312383cad1e2.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:49305 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHFs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:48 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so23779532pab.30
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:47 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

CPUFREQ_STICKY flag is set by drivers which don't want to get unregistered even
if cpufreq-core isn't able to initialize policy for any CPU.

When this flag isn't set, we try to unregister the driver. To find out which
CPUs are registered and which are not, we try to check per_cpu cpufreq_cpu_data
for all CPUs. Because we have a list of valid policies available now, we better
check if the list is empty or not instead of the 'for' loop. That will be much
more efficient.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 74169ad47546..09426671eb79 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2442,23 +2442,12 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	if (ret)
 		goto err_boost_unreg;
 
-	if (!(cpufreq_driver->flags & CPUFREQ_STICKY)) {
-		int i;
-		ret = -ENODEV;
-
-		/* check for at least one working CPU */
-		for (i = 0; i < nr_cpu_ids; i++)
-			if (cpu_possible(i) && per_cpu(cpufreq_cpu_data, i)) {
-				ret = 0;
-				break;
-			}
-
+	if (!(cpufreq_driver->flags & CPUFREQ_STICKY) &&
+	    list_empty(&cpufreq_policy_list)) {
 		/* if all ->init() calls failed, unregister */
-		if (ret) {
-			pr_debug("no CPU initialized for driver %s\n",
-				 driver_data->name);
-			goto err_if_unreg;
-		}
+		pr_debug("%s: No CPU initialized for driver %s\n", __func__,
+			 driver_data->name);
+		goto err_if_unreg;
 	}
 
 	register_hotcpu_notifier(&cpufreq_cpu_notifier);
-- 
2.2.0


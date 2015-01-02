From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/17] cpufreq: use light-weight cpufreq_cpu_get_raw() in __cpufreq_add_dev
Date: Fri,  2 Jan 2015 12:34:33 +0530
Message-ID: <0c3bdb11bedca250f4d60db7a1e1983e0f3d9072.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56294 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHFk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:40 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so23389956pdi.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:40 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

We just need to check if a 'policy' is already present for the cpu we are
adding. We don't need to take all the locks and do kobject usage updates. Use
the light-weight cpufreq_cpu_get_raw() routine instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3061a5823e3c..788016cded33 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1109,11 +1109,9 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	/* check whether a different CPU already registered this
 	 * CPU because it is in the same boat. */
-	policy = cpufreq_cpu_get(cpu);
-	if (unlikely(policy)) {
-		cpufreq_cpu_put(policy);
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(policy))
 		return 0;
-	}
 
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return 0;
-- 
2.2.0


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/17] cpufreq: remove extra parenthesis
Date: Fri,  2 Jan 2015 12:34:23 +0530
Message-ID: <d360be8235493fb5b9ba0d1a5fe3e840b7131132.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35670 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbbABHFD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:03 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so23597164pad.41
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:02 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

We can live without it and so we should.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 891672b913c8..8417313943d5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -902,7 +902,7 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 
 	/* set up files for this cpu device */
 	drv_attr = cpufreq_driver->attr;
-	while ((drv_attr) && (*drv_attr)) {
+	while (drv_attr && *drv_attr) {
 		ret = sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
 		if (ret)
 			return ret;
-- 
2.2.0


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/13] cpufreq: stats: don't break strings into multiple lines
Date: Thu, 18 Dec 2014 17:30:18 +0530
Message-ID: <e1260d5f189f0c38253ccdfe3a919087ac47dd08.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:47108 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaLRMBF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:05 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so1284354pdb.22
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:05 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

The MODULE_DESCRIPTION() string is broken into multiple lines just to make
checkpatch happy. Its less readable now and prone to errors. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 0cd9b4dcef99..81be4d637ab4 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -374,8 +374,7 @@ static void __exit cpufreq_stats_exit(void)
 }
 
 MODULE_AUTHOR("Zou Nan hai <nanhai.zou@intel.com>");
-MODULE_DESCRIPTION("'cpufreq_stats' - A driver to export cpufreq stats "
-				"through sysfs filesystem");
+MODULE_DESCRIPTION("'cpufreq_stats' - exports cpufreq stats through sysfs filesystem");
 MODULE_LICENSE("GPL");
 
 module_init(cpufreq_stats_init);
-- 
2.2.0


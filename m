From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 01/16] cpufreq: stats: Improve module description string
Date: Tue,  6 Jan 2015 21:09:00 +0530
Message-ID: <a067bce5f131fc81c132c1d91791e4ed62a0948f.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34394 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbAFPjb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:39:31 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so31124057pac.36
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:39:31 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

The MODULE_DESCRIPTION() string is just too long and then is broken into
multiple lines just to make checkpatch happy.

Rewrite it to make it more precise.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 0cd9b4dcef99..80801f880dd8 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -374,8 +374,7 @@ static void __exit cpufreq_stats_exit(void)
 }
 
 MODULE_AUTHOR("Zou Nan hai <nanhai.zou@intel.com>");
-MODULE_DESCRIPTION("'cpufreq_stats' - A driver to export cpufreq stats "
-				"through sysfs filesystem");
+MODULE_DESCRIPTION("Export cpufreq stats via sysfs");
 MODULE_LICENSE("GPL");
 
 module_init(cpufreq_stats_init);
-- 
2.2.0


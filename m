From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/17] cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg/err()
Date: Tue, 22 Dec 2015 15:50:08 +0530
Message-ID: <3d3628d7dab6f5bca0e911ab60544a919c2d4075.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35636 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329AbbLVKUU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:20:20 -0500
Received: by mail-pa0-f48.google.com with SMTP id jx14so87461463pad.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:20:20 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

We have the device structure available now, lets use it for better print
messages.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Resend:
- Mail was blocked by linux-pm due to XXX in $Subject :)

 drivers/cpufreq/cpufreq-dt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 1ceece9d6711..45ff7671a883 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -246,7 +246,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 */
 	ret = dev_pm_opp_get_opp_count(cpu_dev);
 	if (ret <= 0) {
-		pr_debug("OPP table is not ready, deferring probe\n");
+		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
 	}
@@ -325,7 +325,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
-		pr_err("failed to init cpufreq table: %d\n", ret);
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
 		goto out_free_priv;
 	}
 
-- 
2.7.0.rc1.186.g94414c4


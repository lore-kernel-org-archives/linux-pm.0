From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 8/8] PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()
Date: Thu, 20 Oct 2016 14:15:02 +0530
Message-ID: <3017eefdae58adc192ccb9c829fa32ee9b58c799.1476952750.git.viresh.kumar@linaro.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36623 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934582AbcJTIpq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 04:45:46 -0400
Received: by mail-pf0-f180.google.com with SMTP id e6so32522280pfk.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2016 01:45:46 -0700 (PDT)
In-Reply-To: <cover.1476952750.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1476952750.git.viresh.kumar@linaro.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

If a platform specific OPP driver has called this routine first and set
the regulators, then the second call from cpufreq-dt driver will hit the
WARN_ON(). Remove the WARN_ON(), but continue to return error in such
cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index f7c4ef194aac..51dd71d16269 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1469,7 +1469,7 @@ int dev_pm_opp_set_regulators(struct device *dev, const char *names[],
 	}
 
 	/* Already have regulators set */
-	if (WARN_ON(opp_table->regulators)) {
+	if (opp_table->regulators) {
 		ret = -EBUSY;
 		goto err;
 	}
-- 
2.7.1.410.g6faf27b


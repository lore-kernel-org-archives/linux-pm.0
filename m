From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 09/10] PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()
Date: Thu, 24 Nov 2016 17:06:18 +0530
Message-ID: <0d981ba7f4069a8f55ae309d038d055ebeaabe1f.1479986492.git.viresh.kumar@linaro.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35870 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965587AbcKXLg7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 06:36:59 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so17834398pgc.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Nov 2016 03:36:58 -0800 (PST)
In-Reply-To: <cover.1479986491.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1479986491.git.viresh.kumar@linaro.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

If a platform specific OPP driver has called this routine first and set
the regulators, then the second call from cpufreq-dt driver will hit the
WARN_ON(). Remove the WARN_ON(), but continue to return error in such
cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 7c945d5950bf..d3f4c625b809 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1469,7 +1469,7 @@ int dev_pm_opp_set_regulators(struct device *dev, const char * const names[],
 	}
 
 	/* Already have regulators set */
-	if (WARN_ON(opp_table->regulators)) {
+	if (opp_table->regulators) {
 		ret = -EBUSY;
 		goto err;
 	}
-- 
2.7.1.410.g6faf27b


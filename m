From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 8/9] PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()
Date: Wed, 26 Oct 2016 12:03:03 +0530
Message-ID: <d922b4be0bcfb17f1a3cefa1ad9a1598b659de4f.1477463128.git.viresh.kumar@linaro.org>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34783 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754064AbcJZGeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 02:34:09 -0400
Received: by mail-pf0-f172.google.com with SMTP id n85so17482073pfi.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 23:34:09 -0700 (PDT)
In-Reply-To: <cover.1477463128.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1477463128.git.viresh.kumar@linaro.org>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

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
index f4f6b1fdbe06..3298fac01bb0 100644
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


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 09/10] PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()
Date: Tue, 29 Nov 2016 12:06:56 +0530
Message-ID: <2b7f54b32e1a07d8dbfcdbccf1c71aa8657f32f8.1480401041.git.viresh.kumar@linaro.org>
References: <cover.1480401041.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33878 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755971AbcK2Ghd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2016 01:37:33 -0500
Received: by mail-pf0-f173.google.com with SMTP id c4so30067754pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2016 22:37:32 -0800 (PST)
In-Reply-To: <cover.1480401041.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1480401041.git.viresh.kumar@linaro.org>
References: <cover.1480401041.git.viresh.kumar@linaro.org>
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
index ddd4915ffd4f..3c9f223709ab 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1484,7 +1484,7 @@ int dev_pm_opp_set_regulators(struct device *dev, const char * const names[],
 	}
 
 	/* Already have regulators set */
-	if (WARN_ON(opp_table->regulators)) {
+	if (opp_table->regulators) {
 		ret = -EBUSY;
 		goto err;
 	}
-- 
2.7.1.410.g6faf27b


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 8/8] PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()
Date: Tue,  4 Oct 2016 17:26:50 +0530
Message-ID: <7299375cc6bf038e2ed2c7c497d350513bb3d428.1475581665.git.viresh.kumar@linaro.org>
References: <cover.1475581665.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34944 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753942AbcJDL5h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2016 07:57:37 -0400
Received: by mail-pf0-f177.google.com with SMTP id s13so75225026pfd.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2016 04:57:37 -0700 (PDT)
In-Reply-To: <cover.1475581665.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1475581665.git.viresh.kumar@linaro.org>
References: <cover.1475581665.git.viresh.kumar@linaro.org>
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


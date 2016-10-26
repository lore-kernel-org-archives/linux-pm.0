From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 9/9] PM / OPP: Don't assume platform doesn't have regulators
Date: Wed, 26 Oct 2016 12:03:04 +0530
Message-ID: <f1fa8223ab9b9a1183626ec42608ec966a4bc425.1477463128.git.viresh.kumar@linaro.org>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34800 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754161AbcJZGeM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 02:34:12 -0400
Received: by mail-pf0-f179.google.com with SMTP id n85so17482976pfi.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 23:34:12 -0700 (PDT)
In-Reply-To: <cover.1477463128.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1477463128.git.viresh.kumar@linaro.org>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

If the regulators aren't set explicitly by the platform, the OPP core
assumes that the platform doesn't have any regulator and uses the
clk-only callback.

If the platform failed to register a regulator with the core, then this
can turn out to be a dangerous assumption as the OPP core will try to
change clk without changing regulators.

Handle that properly by making sure that the DT didn't had any entries
for supply voltages as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 3298fac01bb0..34cd48dfe89e 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -734,7 +734,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!regulators) {
-		rcu_read_unlock();
+		/*
+		 * DT contained supply ratings? Consider platform failed to set
+		 * regulators.
+		 */
+		if (unlikely(opp->supplies[0].u_volt)) {
+			rcu_read_unlock();
+			dev_err(dev, "%s: Regulator not registered with OPP core\n",
+				__func__);
+			return -EINVAL;
+		}
+
 		return _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	}
 
-- 
2.7.1.410.g6faf27b


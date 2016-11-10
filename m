From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 9/9] PM / OPP: Don't assume platform doesn't have regulators
Date: Thu, 10 Nov 2016 10:46:28 +0530
Message-ID: <16ac92a9fcc4adbc146d2dff19b3d24b23ad745f.1478752125.git.viresh.kumar@linaro.org>
References: <20161110011728.GV16026@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34478 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbcKJFQm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 00:16:42 -0500
Received: by mail-pf0-f182.google.com with SMTP id n85so139647614pfi.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2016 21:16:42 -0800 (PST)
In-Reply-To: <20161110011728.GV16026@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

If the regulators aren't set explicitly by the platform, the OPP core
assumes that the platform doesn't have any regulator and uses the
clk-only callback.

If the platform failed to register a regulator with the core, then this
can turn out to be a dangerous assumption as the OPP core will try to
change clk without changing regulators.

Handle that properly by making sure that the DT didn't have any entries
for supply voltages as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V4:
- s/had/have
- fix missing rcu_read_unlock()

 drivers/base/power/opp/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 3298fac01bb0..cb33f8b2b56d 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -734,7 +734,20 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!regulators) {
+		unsigned long u_volt = opp->supplies[0].u_volt;
+
 		rcu_read_unlock();
+
+		/*
+		 * DT contained supply ratings? Consider platform failed to set
+		 * regulators.
+		 */
+		if (unlikely(u_volt)) {
+			dev_err(dev, "%s: Regulator not registered with OPP core\n",
+				__func__);
+			return -EINVAL;
+		}
+
 		return _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	}
 
-- 
2.7.1.410.g6faf27b


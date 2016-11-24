From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 10/10] PM / OPP: Don't assume platform doesn't have regulators
Date: Thu, 24 Nov 2016 17:06:19 +0530
Message-ID: <82cc855c7abb5d0583abe4cc9132c7e589434814.1479986492.git.viresh.kumar@linaro.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1479986491.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1479986491.git.viresh.kumar@linaro.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
 drivers/base/power/opp/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d3f4c625b809..337057783e73 100644
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

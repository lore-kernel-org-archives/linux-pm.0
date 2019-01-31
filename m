From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Remove unused parameter of _generic_set_opp_clk_only()
Date: Thu, 31 Jan 2019 13:55:13 +0530
Message-ID: <e2e83f314120f078f7e24fbd5393decb9940a067.1548923105.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The previous frequency value isn't getting used in the routine
_generic_set_opp_clk_only(), drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d455b84cce5a..fa15aa8e00b0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -533,9 +533,8 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	return ret;
 }
 
-static inline int
-_generic_set_opp_clk_only(struct device *dev, struct clk *clk,
-			  unsigned long old_freq, unsigned long freq)
+static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
+					    unsigned long freq)
 {
 	int ret;
 
@@ -572,7 +571,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 	}
 
 	/* Change frequency */
-	ret = _generic_set_opp_clk_only(dev, opp_table->clk, old_freq, freq);
+	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
 	if (ret)
 		goto restore_voltage;
 
@@ -586,7 +585,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 	return 0;
 
 restore_freq:
-	if (_generic_set_opp_clk_only(dev, opp_table->clk, freq, old_freq))
+	if (_generic_set_opp_clk_only(dev, opp_table->clk, old_freq))
 		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
 			__func__, old_freq);
 restore_voltage:
@@ -759,7 +758,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 						 opp->supplies);
 	} else {
 		/* Only frequency scaling */
-		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+		ret = _generic_set_opp_clk_only(dev, clk, freq);
 	}
 
 	/* Scaling down? Configure required OPPs after frequency */
-- 
2.20.1.321.g9e740568ce00

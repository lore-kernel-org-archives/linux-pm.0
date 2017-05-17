From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/4] PM / OPP: opp-microvolt is not optional if regulators are set
Date: Wed, 17 May 2017 10:10:34 +0530
Message-ID: <0e9ac75f0e94d7b0bff9a398b501e2fe4f409051.1494995911.git.viresh.kumar@linaro.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494995911.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1494995911.git.viresh.kumar@linaro.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

If dev_pm_opp_set_regulators() is called for a device and its regulators
are set in the OPP core, the OPP nodes for the device must contain the
"opp-microvolt" property, otherwise there is something wrong and we
better error out.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/of.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 779428676f63..c6fc8cbad10d 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -131,8 +131,15 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 		prop = of_find_property(opp->np, name, NULL);
 
 		/* Missing property isn't a problem, but an invalid entry is */
-		if (!prop)
-			return 0;
+		if (!prop) {
+			/* The regulator-count must be zero here */
+			if (!opp_table->regulator_count)
+				return 0;
+
+			dev_err(dev, "%s: opp-microvolt missing even if regulators are available\n",
+				__func__);
+			return -EINVAL;
+		}
 	}
 
 	vcount = of_property_count_u32_elems(opp->np, name);
-- 
2.13.0.303.g4ebf3021692d

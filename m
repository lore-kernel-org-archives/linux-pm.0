From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/4] PM / OPP: opp-microvolt is not optional if regulators are set
Date: Tue, 23 May 2017 09:32:12 +0530
Message-ID: <dcb9872771568fec4c7d8d11ba4939cd8da279c0.1495511998.git.viresh.kumar@linaro.org>
References: <b9f67b2be37d5e9740a5e1ed85b0e8b4e5c0eb91.1495511998.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b9f67b2be37d5e9740a5e1ed85b0e8b4e5c0eb91.1495511998.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1495511998.git.viresh.kumar@linaro.org>
References: <cover.1495511998.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

If dev_pm_opp_set_regulators() is called for a device and its regulators
are set in the OPP core, the OPP nodes for the device must contain the
"opp-microvolt" property, otherwise there is something wrong and we
better error out.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/of.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 779428676f63..57eec1ca0569 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -131,8 +131,14 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 		prop = of_find_property(opp->np, name, NULL);
 
 		/* Missing property isn't a problem, but an invalid entry is */
-		if (!prop)
-			return 0;
+		if (!prop) {
+			if (!opp_table->regulator_count)
+				return 0;
+
+			dev_err(dev, "%s: opp-microvolt missing although OPP managing regulators\n",
+				__func__);
+			return -EINVAL;
+		}
 	}
 
 	vcount = of_property_count_u32_elems(opp->np, name);
-- 
2.13.0.70.g6367777092d9

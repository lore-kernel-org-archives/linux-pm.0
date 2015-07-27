From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 09/11] OPP: Add support for opp-suspend
Date: Mon, 27 Jul 2015 10:32:39 +0530
Message-ID: <ec715e6ab8c026340cad992a79eea34c64a3f05a.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

With "operating-points-v2" bindings, its possible to specify the OPP to
which the device must be switched, before suspending.

This patch adds support for getting that information.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index d6ab6af7e847..22b1e6ae7a94 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -133,6 +133,7 @@ struct device_opp {
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
 	bool shared_opp;
+	struct dev_pm_opp *suspend_opp;
 };
 
 /*
@@ -909,6 +910,16 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	if (ret)
 		goto free_opp;
 
+	/* OPP to select on device suspend */
+	if (of_property_read_bool(np, "opp-suspend")) {
+		if (dev_opp->suspend_opp)
+			dev_warn(dev, "%s: Multiple suspend OPPs found (%lu %lu)\n",
+				 __func__, dev_opp->suspend_opp->rate,
+				 new_opp->rate);
+		else
+			dev_opp->suspend_opp = new_opp;
+	}
+
 	if (new_opp->clock_latency_ns > dev_opp->clock_latency_ns_max)
 		dev_opp->clock_latency_ns_max = new_opp->clock_latency_ns;
 
-- 
2.4.0

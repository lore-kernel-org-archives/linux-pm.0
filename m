From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/10] OPP: Add support for opp-suspend
Date: Mon, 15 Jun 2015 17:27:34 +0530
Message-ID: <6a4a0da974d5944a111af6f0b57bcba63a91fe40.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33016 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbbFOL6Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 07:58:25 -0400
Received: by pdjn11 with SMTP id n11so71617518pdj.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:58:25 -0700 (PDT)
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

With "operating-points-v2" bindings, its possible to specify the OPP to
which the device must be switched, before suspending.

This patch adds support for getting that information.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 6b554e417b1f..0022453e4b60 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -137,6 +137,7 @@ struct device_opp {
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
 	bool shared_opp;
+	struct dev_pm_opp *suspend_opp;
 };
 
 /*
@@ -1218,6 +1219,8 @@ static int _of_init_opp_table_v2(struct device *dev,
 		goto put_opp_np;
 
 	if (!ret) {
+		const phandle *handle;
+
 		if (!dev_opp) {
 			dev_opp = _find_device_opp(dev);
 			if (WARN_ON(!dev_opp))
@@ -1227,6 +1230,25 @@ static int _of_init_opp_table_v2(struct device *dev,
 		dev_opp->np = opp_np;
 		if (of_get_property(opp_np, "opp-shared", NULL))
 			dev_opp->shared_opp = true;
+
+		/* OPP to select on device suspend */
+		handle = of_get_property(opp_np, "opp-suspend", NULL);
+		if (handle) {
+			struct device_node *suspend_opp_np;
+			struct dev_pm_opp *opp;
+
+			suspend_opp_np = of_find_node_by_phandle(be32_to_cpup(handle));
+
+			list_for_each_entry_rcu(opp, &dev_opp->opp_list, node)
+				if (opp->np == suspend_opp_np) {
+					dev_opp->suspend_opp = opp;
+					break;
+				}
+
+			if (!dev_opp->suspend_opp)
+				dev_err(dev, "%s: Invalid opp-suspend\n",
+					__func__);
+		}
 	} else {
 		of_free_opp_table(dev);
 	}
-- 
2.4.0


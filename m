From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v2 2/5] PM / OPP: add support to specify phandle of another node for OPP
Date: Tue,  1 Oct 2013 14:32:59 +0100
Message-ID: <1380634382-15609-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Currently we need to replicate the OPP entries in all the nodes even
though they share OPPs being in the same clock domain.

Few drivers like cpufreq depend on physical cpu0 node to specify the
OPPs and only that node is referred irrespective of the logical cpu
accessing it. Alternatively to support cpuhotplug path, few drivers
parse all the cpu nodes for OPPs. Instead we can specify the phandle
of the node which contains the OPP tuples.

This patch adds support to the new property 'operating-points-phandle'
which specifies the phandle pointing to another node which contains the
actual OPP tuples.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/base/power/opp.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index ef89897..bb6ff64 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -708,12 +708,20 @@ struct srcu_notifier_head *opp_get_notifier(struct device *dev)
 int of_init_opp_table(struct device *dev)
 {
 	const struct property *prop;
+	struct device_node *opp_node;
 	const __be32 *val;
 	int nr;
 
-	prop = of_find_property(dev->of_node, "operating-points", NULL);
-	if (!prop)
+	opp_node = of_parse_phandle(dev->of_node,
+					"operating-points-phandle", 0);
+	if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
+		opp_node = dev->of_node;
+	prop = of_find_property(opp_node, "operating-points", NULL);
+	if (!prop) {
+		dev_warn(dev, "node %s missing operating-points property\n",
+							opp_node->full_name);
 		return -ENODEV;
+	}
 	if (!prop->value)
 		return -ENODATA;
 
@@ -740,6 +748,9 @@ int of_init_opp_table(struct device *dev)
 		nr -= 2;
 	}
 
+	if (opp_node != dev->of_node)
+		of_node_put(opp_node);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_init_opp_table);
-- 
1.8.1.2


From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] PM / OPP: Refactor counting of added OPPs for v2 to avoid unsupported OPPs
Date: Tue, 21 Aug 2018 22:10:35 -0500
Message-ID: <20180822031035.6937-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-pm@vger.kernel.org

Currently the _of_add_opp_table_v2 call loops through the OPP nodes in
the operating-points-v2 table in the device tree and calls
_opp_add_static_v2 for each to add them to the table. It counts each
iteration through this loop as an added OPP, however on platforms making
use of the opp-supported-hw property, _opp_add_static_v2 does not add
OPPs that are not seen as supported on the platform but still returns
success, as this is valid. Because of this the count variable will
contain the number of OPP nodes in the table in device tree but not
necessarily the ones that are supported and actually added.

As this count value is what is checked to determine if there are any
valid OPPs, if a platform has an operating-points-v2 table with all OPP
nodes containing opp-supported-hw values that are not currently
supported then _of_add_opp_table_v2 will fail to abort as it should due
to an empty table.

Additionally, since commit 3ba98324e81a ("PM / OPP: Get
performance state using genpd helper"), the same count variable is
compared against the number of OPPs containing performance states and
requires that either all or none have pstates set, however in the case
of any opp table that has any entries that do not get added by
_opp_add_static_v2 due to incompatible opp-supported-hw fields, these
numbers will not match and _of_add_opp_table_v2 will incorrectly fail.

In order to ensure the count variable reflects the number of OPPs
actually in the table, increment it during the existing loop which walks
the opp table to check if pstate is set and then use that for the
aforementioned checks.

Fixes: 3ba98324e81a ("PM / OPP: Get performance state using genpd helper")
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/opp/of.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 7af0ddec936b..f288f83a2e62 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -399,8 +399,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
-		count++;
-
 		ret = _opp_add_static_v2(opp_table, dev, np);
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
@@ -411,15 +409,22 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		}
 	}
 
+	/*
+	 * Iterate over the list of OPPs that were actually added, as
+	 * OPPs not supported by the hardware will be ignored by
+	 * _opp_add_static_v2 above.
+	 */
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
+		count++;
+		pstate_count += !!opp->pstate;
+	}
+
 	/* There should be one of more OPP defined */
 	if (WARN_ON(!count)) {
 		ret = -ENOENT;
 		goto put_opp_table;
 	}
 
-	list_for_each_entry(opp, &opp_table->opp_list, node)
-		pstate_count += !!opp->pstate;
-
 	/* Either all or none of the nodes shall have performance state set */
 	if (pstate_count && pstate_count != count) {
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
-- 
2.16.1

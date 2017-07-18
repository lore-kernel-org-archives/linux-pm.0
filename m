From: Rob Herring <robh@kernel.org>
Subject: [PATCH] PM / Domains: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:42:50 -0500
Message-ID: <20170718214339.7774-10-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/base/power/domain.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3b8210ebb50e..d0989f9b5e67 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1743,7 +1743,7 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 	mutex_lock(&of_genpd_mutex);
 	list_add(&cp->link, &of_genpd_providers);
 	mutex_unlock(&of_genpd_mutex);
-	pr_debug("Added domain provider from %s\n", np->full_name);
+	pr_debug("Added domain provider from %pOF\n", np);

 	return 0;
 }
@@ -2149,16 +2149,16 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 	err = of_property_read_u32(state_node, "entry-latency-us",
 						&entry_latency);
 	if (err) {
-		pr_debug(" * %s missing entry-latency-us property\n",
-						state_node->full_name);
+		pr_debug(" * %pOF missing entry-latency-us property\n",
+						state_node);
 		return -EINVAL;
 	}

 	err = of_property_read_u32(state_node, "exit-latency-us",
 						&exit_latency);
 	if (err) {
-		pr_debug(" * %s missing exit-latency-us property\n",
-						state_node->full_name);
+		pr_debug(" * %pOF missing exit-latency-us property\n",
+						state_node);
 		return -EINVAL;
 	}

@@ -2212,8 +2212,8 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 		ret = genpd_parse_state(&st[i++], np);
 		if (ret) {
 			pr_err
-			("Parsing idle state node %s failed with err %d\n",
-							np->full_name, ret);
+			("Parsing idle state node %pOF failed with err %d\n",
+							np, ret);
 			of_node_put(np);
 			kfree(st);
 			return ret;
--
2.11.0

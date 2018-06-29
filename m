From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/10] OPP: Identify and mark genpd OPP tables
Date: Fri, 29 Jun 2018 11:49:32 +0530
Message-ID: <c24cb556bd674933df19bff0acc596d73e510706.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We need to handle genpd OPP tables differently, this is already the case
at one location and will be extended going forward. Add another field to
the OPP table to check if the table belongs to a genpd or not.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c  | 6 ++++--
 drivers/opp/opp.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 44a6b81fd228..218b8997d817 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -88,6 +88,9 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
 	of_property_read_u32(np, "voltage-tolerance",
 			     &opp_table->voltage_tolerance_v1);
 
+	if (of_find_property(np, "#power-domain-cells", NULL))
+		opp_table->is_genpd = true;
+
 	/* Get OPP table node */
 	opp_np = _opp_of_get_opp_desc_node(np, 0);
 	of_node_put(np);
@@ -314,8 +317,7 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	ret = of_property_read_u64(np, "opp-hz", &rate);
 	if (ret < 0) {
 		/* "opp-hz" is optional for devices like power domains. */
-		if (!of_find_property(dev->of_node, "#power-domain-cells",
-				      NULL)) {
+		if (!opp_table->is_genpd) {
 			dev_err(dev, "%s: opp-hz not found\n", __func__);
 			goto free_opp;
 		}
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 7c540fd063b2..3cd3b7b167b5 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -138,6 +138,7 @@ enum opp_table_access {
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators
  * @genpd_performance_state: Device's power domain support performance state.
+ * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -174,6 +175,7 @@ struct opp_table {
 	struct regulator **regulators;
 	unsigned int regulator_count;
 	bool genpd_performance_state;
+	bool is_genpd;
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
-- 
2.18.0.rc1.242.g61856ae69a2c

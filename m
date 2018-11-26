From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/5] OPP: Improve _find_table_of_opp_np()
Date: Mon, 26 Nov 2018 13:40:00 +0530
Message-ID: <24e67ba3145090fb73609a6f681c4f8ff8f73594.1543219386.git.viresh.kumar@linaro.org>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1543219386.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, rnayak@codeaurora.org, niklas.cassel@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Make _find_table_of_opp_np() more efficient by using of_get_parent() to
find the parent OPP table node.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 840f85181a37..04968b6a9708 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -114,19 +114,25 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
 static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *opp;
+	struct device_node *opp_table_np;
 
 	lockdep_assert_held(&opp_table_lock);
 
+	opp_table_np = of_get_parent(opp_np);
+	if (!opp_table_np)
+		goto err;
+
+	/* It is safe to put the node now as all we need now is its address */
+	of_node_put(opp_table_np);
+
 	list_for_each_entry(opp_table, &opp_tables, node) {
-		opp = _find_opp_of_np(opp_table, opp_np);
-		if (opp) {
-			dev_pm_opp_put(opp);
+		if (opp_table_np == opp_table->np) {
 			_get_opp_table_kref(opp_table);
 			return opp_table;
 		}
 	}
 
+err:
 	return ERR_PTR(-ENODEV);
 }
 
-- 
2.19.1.568.g152ad8e3369a

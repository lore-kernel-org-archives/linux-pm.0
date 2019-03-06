From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] OPP: Fix handling of multiple power domains
Date: Wed,  6 Mar 2019 09:37:26 +0530
Message-ID: <20190306040726.1930-1-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

We seem to rely on the number of phandles specified in the
'required-opps' property to identify cases where a device is
associated with multiple power domains and hence would have
multiple virtual devices that have to be dealt with.

In cases where we do have devices with multiple power domains
but with only one of them being scalable, this logic seems to
fail.

Instead read the number of power domains from DT to identify
such cases.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/opp/of.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 06f0f632ec47..443c305ae100 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -172,7 +172,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	struct opp_table **required_opp_tables;
 	struct device **genpd_virt_devs = NULL;
 	struct device_node *required_np, *np;
-	int count, i;
+	int count, count_pd, i;
 
 	/* Traversing the first OPP node is all we need */
 	np = of_get_next_available_child(opp_np, NULL);
@@ -185,7 +185,19 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	if (!count)
 		goto put_np;
 
-	if (count > 1) {
+	/*
+	 * Check the number of power-domains to know if we need to deal
+	 * with virtual devices. In some cases we have devices with multiple
+	 * power domains but with only one of them being scalable, hence
+	 * 'count' could be 1, but we still have to deal with multiple genpds
+	 * and virtual devices.
+	 */
+	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
+					      "#power-domain-cells");
+	if (!count_pd)
+		goto put_np;
+
+	if (count_pd > 1) {
 		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
 					GFP_KERNEL);
 		if (!genpd_virt_devs)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

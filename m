From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v2] PM / AVS: rockchip-io: add io selectors and supplies for RV1108
Date: Mon, 21 Aug 2017 18:58:33 +0800
Message-ID: <1503313113-31056-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:55471 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdHUKxp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2017 06:53:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@baylibre.com, rafael.j.wysocki@intel.com, nm@ti.com, heiko@sntech.de
Cc: huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

This adds the necessary data for handling io voltage domains on the RV1108.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
change in v2:
 - Alphabetic order for the binding string

 .../bindings/power/rockchip-io-domain.txt          |  2 ++
 drivers/power/avs/rockchip-io-domain.c             | 38 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index 43c21fb..4a4766e 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -39,6 +39,8 @@ Required properties:
   - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
   - "rockchip,rk3399-io-voltage-domain" for rk3399
   - "rockchip,rk3399-pmu-io-voltage-domain" for rk3399 pmu-domains
+  - "rockchip,rv1108-io-voltage-domain" for rv1108
+  - "rockchip,rv1108-pmu-io-voltage-domain" for rv1108 pmu-domains
 
 Deprecated properties:
 - rockchip,grf: phandle to the syscon managing the "general register files"
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 031a343..75f63e3 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -349,6 +349,36 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 	.init = rk3399_pmu_iodomain_init,
 };
 
+static const struct rockchip_iodomain_soc_data soc_data_rv1108 = {
+	.grf_offset = 0x404,
+	.supply_names = {
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		"vccio1",
+		"vccio2",
+		"vccio3",
+		"vccio5",
+		"vccio6",
+	},
+
+};
+
+static const struct rockchip_iodomain_soc_data soc_data_rv1108_pmu = {
+	.grf_offset = 0x104,
+	.supply_names = {
+		"pmu",
+	},
+};
+
 static const struct of_device_id rockchip_iodomain_match[] = {
 	{
 		.compatible = "rockchip,rk3188-io-voltage-domain",
@@ -382,6 +412,14 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 		.compatible = "rockchip,rk3399-pmu-io-voltage-domain",
 		.data = (void *)&soc_data_rk3399_pmu
 	},
+	{
+		.compatible = "rockchip,rv1108-io-voltage-domain",
+		.data = (void *)&soc_data_rv1108
+	},
+	{
+		.compatible = "rockchip,rv1108-pmu-io-voltage-domain",
+		.data = (void *)&soc_data_rv1108_pmu
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_iodomain_match);
-- 
1.9.1

From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for rk3228
Date: Fri,  9 Jun 2017 17:36:14 +0800
Message-ID: <1497000974-12696-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:52695 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdFIJcy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 05:32:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@baylibre.com, rafael.j.wysocki@intel.com, nm@ti.com, heiko@sntech.de
Cc: huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

This adds the necessary data for handling io voltage domains on the rk3228.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 .../devicetree/bindings/power/rockchip-io-domain.txt       |  7 +++++++
 drivers/power/avs/rockchip-io-domain.c                     | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index d3a5a93..43c21fb 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -32,6 +32,7 @@ SoC is on the same page.
 Required properties:
 - compatible: should be one of:
   - "rockchip,rk3188-io-voltage-domain" for rk3188
+  - "rockchip,rk3228-io-voltage-domain" for rk3228
   - "rockchip,rk3288-io-voltage-domain" for rk3288
   - "rockchip,rk3328-io-voltage-domain" for rk3328
   - "rockchip,rk3368-io-voltage-domain" for rk3368
@@ -59,6 +60,12 @@ Possible supplies for rk3188:
 - vccio1-supply: The supply connected to VCCIO1.
                  Sometimes also labeled VCCIO1 and VCCIO2.
 
+Possible supplies for rk3228:
+- vccio1-supply: The supply connected to VCCIO1.
+- vccio2-supply: The supply connected to VCCIO2.
+- vccio3-supply: The supply connected to VCCIO3.
+- vccio4-supply: The supply connected to VCCIO4.
+
 Possible supplies for rk3288:
 - audio-supply:  The supply connected to APIO4_VDD.
 - bb-supply:     The supply connected to APIO5_VDD.
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 8581252..031a343 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -253,6 +253,16 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 	},
 };
 
+static const struct rockchip_iodomain_soc_data soc_data_rk3228 = {
+	.grf_offset = 0x418,
+	.supply_names = {
+		"vccio1",
+		"vccio2",
+		"vccio3",
+		"vccio4",
+	},
+};
+
 static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
 	.grf_offset = 0x380,
 	.supply_names = {
@@ -345,6 +355,10 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 		.data = (void *)&soc_data_rk3188
 	},
 	{
+		.compatible = "rockchip,rk3228-io-voltage-domain",
+		.data = (void *)&soc_data_rk3228
+	},
+	{
 		.compatible = "rockchip,rk3288-io-voltage-domain",
 		.data = (void *)&soc_data_rk3288
 	},
-- 
1.9.1

From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 1/5] PM / AVS: rockchip-io: make io-domains a child of the GRF
Date: Thu, 31 Mar 2016 15:48:42 +0200
Message-ID: <1459432126-6395-2-git-send-email-heiko@sntech.de>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51215 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbcCaNtF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 31 Mar 2016 09:49:05 -0400
In-Reply-To: <1459432126-6395-1-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>

IO-domain handling is part of the general register files, so should live
under the grf directly. This change allows the grf to be a simple-mfd and
the io-domains fetching the syscon regmap from that parent-node.

The old binding is of course preserved, though deprecated.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: David Wu <david.wu@rock-chips.com>
---
 Documentation/devicetree/bindings/power/rockchip-io-domain.txt |  4 +++-
 drivers/power/avs/rockchip-io-domain.c                         | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index c84fb47..d23dc00 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -37,8 +37,10 @@ Required properties:
   - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
   - "rockchip,rk3399-io-voltage-domain" for rk3399
   - "rockchip,rk3399-pmu-io-voltage-domain" for rk3399 pmu-domains
-- rockchip,grf: phandle to the syscon managing the "general register files"
 
+Deprecated properties:
+- rockchip,grf: phandle to the syscon managing the "general register files"
+    Systems should move the io-domains to a sub-node of the grf simple-mfd.
 
 You specify supplies using the standard regulator bindings by including
 a phandle the relevant regulator.  All specified supplies must be able
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 8986382..01b6d3f 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -336,6 +336,7 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
 	struct rockchip_iodomain *iod;
+	struct device *parent;
 	int i, ret = 0;
 
 	if (!np)
@@ -351,7 +352,14 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 	match = of_match_node(rockchip_iodomain_match, np);
 	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
 
-	iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	parent = pdev->dev.parent;
+	if (parent && parent->of_node) {
+		iod->grf = syscon_node_to_regmap(parent->of_node);
+	} else {
+		dev_dbg(&pdev->dev, "falling back to old binding\n");
+		iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	}
+
 	if (IS_ERR(iod->grf)) {
 		dev_err(&pdev->dev, "couldn't find grf regmap\n");
 		return PTR_ERR(iod->grf);
-- 
2.6.4


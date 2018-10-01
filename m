From: Rob Herring <robh@kernel.org>
Subject: [PATCH] power: reset: Convert to using %pOFn instead of device_node.name
Date: Mon,  1 Oct 2018 16:43:50 -0500
Message-ID: <20181001214351.13230-3-robh@kernel.org>
References: <20181001214351.13230-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001214351.13230-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/power/reset/axxia-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/axxia-reset.c b/drivers/power/reset/axxia-reset.c
index 4e4cd1c8fe50..b16013265142 100644
--- a/drivers/power/reset/axxia-reset.c
+++ b/drivers/power/reset/axxia-reset.c
@@ -65,7 +65,7 @@ static int axxia_reset_probe(struct platform_device *pdev)
 
 	syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
 	if (IS_ERR(syscon)) {
-		pr_err("%s: syscon lookup failed\n", dev->of_node->name);
+		pr_err("%pOFn: syscon lookup failed\n", dev->of_node);
 		return PTR_ERR(syscon);
 	}
 
-- 
2.17.1

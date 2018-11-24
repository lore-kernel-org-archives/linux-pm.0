From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] power/reset: axxia: Convert to using %pOFn instead of device_node.name
Date: Sat, 24 Nov 2018 09:31:38 -0500
Message-ID: <20181124143138.28999-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org, sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
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
2.17.0

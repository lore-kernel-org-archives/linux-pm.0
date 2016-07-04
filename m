From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v2 1/1] devfreq: exynos-bus: add missing of_node_put after calling of_parse_phandle
Date: Mon, 4 Jul 2016 10:47:46 +0800
Message-ID: <1467600466-13667-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---

Changes at v2:
- It should define node as pointer, kbuild test robot reports it


 drivers/devfreq/exynos-bus.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 2363d0a..4b4c63c 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -383,7 +383,7 @@ err_clk:
 static int exynos_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
+	struct device_node *node, *np = dev->of_node;
 	struct devfreq_dev_profile *profile;
 	struct devfreq_simple_ondemand_data *ondemand_data;
 	struct devfreq_passive_data *passive_data;
@@ -415,10 +415,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (of_parse_phandle(dev->of_node, "devfreq", 0))
+	node = of_parse_phandle(dev->of_node, "devfreq", 0);
+	if (node) {
+		of_node_put(node);
 		goto passive;
-	else
+	} else {
 		ret = exynos_bus_parent_parse_of(np, bus);
+	}
 
 	if (ret < 0)
 		goto err;
-- 
1.9.1

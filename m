From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 1/2] power: supply: fix leaked of_node refs in ab8500_bm_of_probe
Date: Wed, 17 Apr 2019 10:43:02 +0800
Message-ID: <1555468983-34952-2-git-send-email-wen.yang99@zte.com.cn>
References: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

492 int ab8500_bm_of_probe(struct device *dev,
493                        struct device_node *np,
494                        struct abx500_bm_data *bm)
495 {
496         const struct batres_vs_temp *tmp_batres_tbl;
497         struct device_node *battery_node;
    ...
501         /* get phandle to 'battery-info' node */
502         battery_node = of_parse_phandle(np, "battery", 0);
    ...
509         if (!btech) {
510                 dev_warn(dev, "missing property battery-name/type\n");
511                 return -EINVAL;    ---> leaked here
512         }
    ...
540         of_node_put(battery_node);   ---> released here
541
542         return 0;
543 }

Detected by coccinelle with the following warnings:
./drivers/power/supply/ab8500_bmdata.c:511:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 502, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/power/supply/ab8500_bmdata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 7b2b699..f6a6697 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -508,6 +508,7 @@ int ab8500_bm_of_probe(struct device *dev,
 	btech = of_get_property(battery_node, "stericsson,battery-type", NULL);
 	if (!btech) {
 		dev_warn(dev, "missing property battery-name/type\n");
+		of_node_put(battery_node);
 		return -EINVAL;
 	}
 
-- 
2.9.5

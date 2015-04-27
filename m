From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v6 5/7] PM / Domains: Add helper variable np = dev->of_node
Date: Mon, 27 Apr 2015 14:43:40 +0200
Message-ID: <1430138622-14029-6-git-send-email-geert+renesas@glider.be>
References: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam@baylibre.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Just a cleanup, no functional changes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kevin Hilman <khilman@linaro.org>
---
v6:
  - Rebased on top of v4.1-rc1 for new RFC,

v4:
  - Add more explanations,
  - Add Acked-by,

v3:
  - No changes,

v2:
  - New.
---
 drivers/base/power/domain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d1531602ae64528d..d20caa2c92b57edf 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2190,17 +2190,18 @@ static void genpd_dev_pm_sync(struct device *dev)
  */
 int genpd_dev_pm_attach(struct device *dev)
 {
+	struct device_node *np = dev->of_node;
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
 	int ret;
 
-	if (!dev->of_node)
+	if (!np)
 		return -ENODEV;
 
 	if (dev->pm_domain)
 		return -EEXIST;
 
-	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
+	ret = of_parse_phandle_with_args(np, "power-domains",
 					"#power-domain-cells", 0, &pd_args);
 	if (ret < 0) {
 		if (ret != -ENOENT)
@@ -2211,8 +2212,7 @@ int genpd_dev_pm_attach(struct device *dev)
 		 * (for backwards compatibility of DT ABI)
 		 */
 		pd_args.args_count = 0;
-		pd_args.np = of_parse_phandle(dev->of_node,
-						"samsung,power-domain", 0);
+		pd_args.np = of_parse_phandle(np, "samsung,power-domain", 0);
 		if (!pd_args.np)
 			return -ENOENT;
 	}
@@ -2221,7 +2221,7 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (IS_ERR(pd)) {
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		of_node_put(dev->of_node);
+		of_node_put(np);
 		return PTR_ERR(pd);
 	}
 
@@ -2237,7 +2237,7 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (ret < 0) {
 		dev_err(dev, "failed to add to PM domain %s: %d",
 			pd->name, ret);
-		of_node_put(dev->of_node);
+		of_node_put(np);
 		return ret;
 	}
 
-- 
1.9.1

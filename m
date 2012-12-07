From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] drivers/thermal/spear_thermal.c: use devm_clk_get
Date: Fri,  7 Dec 2012 11:29:32 +0100
Message-ID: <1354876172-1634-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

devm_clk_get allocates a resource that is released when a driver detaches.
This patch uses devm_clk_get for data that is allocated in the probe
function of a platform device and is only released in the remove function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
I was not able to compile this code.  At one point, devm_clk_get was not
supported for all architectures.  If that is still the case, and the code
doesn't compile, then just ignore the patch.

 drivers/thermal/spear_thermal.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 6b2d8b2..3c5ee56 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -131,7 +131,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	stdev->clk = clk_get(&pdev->dev, NULL);
+	stdev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(stdev->clk)) {
 		dev_err(&pdev->dev, "Can't get clock\n");
 		return PTR_ERR(stdev->clk);
@@ -140,7 +140,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	ret = clk_enable(stdev->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable clock\n");
-		goto put_clk;
+		return ret;
 	}
 
 	stdev->flags = val;
@@ -163,8 +163,6 @@ static int spear_thermal_probe(struct platform_device *pdev)
 
 disable_clk:
 	clk_disable(stdev->clk);
-put_clk:
-	clk_put(stdev->clk);
 
 	return ret;
 }
@@ -183,7 +181,6 @@ static int spear_thermal_exit(struct platform_device *pdev)
 	writel_relaxed(actual_mask & ~stdev->flags, stdev->thermal_base);
 
 	clk_disable(stdev->clk);
-	clk_put(stdev->clk);
 
 	return 0;
 }

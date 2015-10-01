From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] dmaengine: usb-dmac: Fix pm_runtime_{enable,disable}() imbalance
Date: Thu,  1 Oct 2015 09:22:18 +0200
Message-ID: <1443684138-32252-3-git-send-email-geert+renesas@glider.be>
References: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

If the call to pm_runtime_get_sync() failed, Runtime PM was left
enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/usb-dmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index f305738b5adf8cc9..f1bcc2a163b30cef 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -802,7 +802,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
-		return ret;
+		goto error_pm;
 	}
 
 	ret = usb_dmac_init(dmac);
@@ -859,6 +859,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
 error:
 	of_dma_controller_free(pdev->dev.of_node);
 	pm_runtime_put(&pdev->dev);
+error_pm:
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
-- 
1.9.1


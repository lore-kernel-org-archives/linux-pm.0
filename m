From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: shdma: Runtime-resume device in .shutdown()
Date: Wed, 19 Nov 2014 16:15:46 +0100
Message-ID: <1416410146-29652-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:50025 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbaKSPPv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 10:15:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

During system reboot, the sh-dma-engine device may be runtime-suspended,
causing a crash:

    Unhandled fault: imprecise external abort (0x1406) at 0x0002c02c
    Internal error: : 1406 [#1] SMP ARM
    ...
    PC is at sh_dmae_ctl_stop+0x28/0x64
    LR is at sh_dmae_ctl_stop+0x24/0x64

If the sh-dma-engine is runtime-suspended, its module clock is turned
off, and its registers cannot be accessed. Runtime-resume the device in
the driver's .shutdown() callback to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/shdmac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index b65317c6ea4e722c..a13c6ba7468f12a6 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -585,7 +585,10 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
 static void sh_dmae_shutdown(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
+
+	pm_runtime_get_sync(&pdev->dev);
 	sh_dmae_ctl_stop(shdev);
+	pm_runtime_put(&pdev->dev);
 }
 
 static int sh_dmae_runtime_suspend(struct device *dev)
-- 
1.9.1


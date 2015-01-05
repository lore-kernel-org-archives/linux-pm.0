From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dmaengine: shdma: Runtime-resume device in .shutdown()
Date: Mon,  5 Jan 2015 11:46:29 +0100
Message-ID: <1420454789-11547-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

During system reboot, the sh-dma-engine device may be runtime-suspended,
causing a crash:

    Unhandled fault: imprecise external abort (0x1406) at 0x0002c02c
    Internal error: : 1406 [#1] SMP ARM
    ...
    PC is at sh_dmae_ctl_stop+0x28/0x64
    LR is at sh_dmae_ctl_stop+0x24/0x64

If the sh-dma-engine is runtime-suspended, its module clock is turned
off, and its registers cannot be accessed.

To fix this, change the driver's .shutdown() callback:
  - If the device is runtime suspended, do nothing,
  - Else, explicitly runtime-resume the device, to avoid the device from
    being suspended while sh_dmae_ctl_stop() is being executed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Do nothing if we're runtime suspended.
---
 drivers/dma/sh/shdmac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index aec8a84784a469d7..2de30e8e7d9290b9 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -585,7 +585,13 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
 static void sh_dmae_shutdown(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
+
+	if (pm_runtime_suspended(&pdev->dev))
+		return;
+
+	pm_runtime_get_sync(&pdev->dev);
 	sh_dmae_ctl_stop(shdev);
+	pm_runtime_put(&pdev->dev);
 }
 
 static int sh_dmae_runtime_suspend(struct device *dev)
-- 
1.9.1


From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] thermal: rockchip: fix error return code in
 rockchip_thermal_probe()
Date: Mon, 7 Aug 2017 23:35:17 -0500
Message-ID: <20170808043517.GA13356@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

platform_get_irq() returns an error code, but the rockchip_thermal driver
ignores it and always returns -EINVAL. This is not correct and, prevents
-EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/thermal/rockchip_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 4c77965..6ca9747 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1068,8 +1068,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
-		return -EINVAL;
+		dev_err(&pdev->dev, "no irq resource: %d\n", irq);
+		return irq;
 	}
 
 	thermal = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_thermal_data),
-- 
2.5.0

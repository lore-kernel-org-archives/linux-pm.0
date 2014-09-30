From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 03/10] power/reset: xgene: Drop devm_kfree
Date: Tue, 30 Sep 2014 10:48:29 -0700
Message-ID: <1412099316-23167-4-git-send-email-linux@roeck-us.net>
References: <1412099316-23167-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412099316-23167-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Loc Ho <lho@apm.com>
List-Id: linux-pm@vger.kernel.org

Calling devm_kfree is unnecessary. Drop it.

Cc: Loc Ho <lho@apm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/xgene-reboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index 20cf7c3..aac0287 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -66,7 +66,6 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 
 	ctx->csr = of_iomap(pdev->dev.of_node, 0);
 	if (!ctx->csr) {
-		devm_kfree(&pdev->dev, ctx);
 		dev_err(&pdev->dev, "can not map resource\n");
 		return -ENODEV;
 	}
-- 
1.9.1

From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/10] power/reset: xgene: Return -ENOMEM if out of memory
Date: Fri, 26 Sep 2014 17:57:10 -0700
Message-ID: <1411779438-23127-3-git-send-email-linux@roeck-us.net>
References: <1411779438-23127-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411779438-23127-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Loc Ho <lho@apm.com>
List-Id: linux-pm@vger.kernel.org

It is customary to return an error code of -ENOMEM if the system
is out of memory. Also, in that case, the infrastructure will report
an error, so it is unnecessary to report it again.

Cc: Loc Ho <lho@apm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/xgene-reboot.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index ecd55f8..20cf7c3 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -61,10 +61,8 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 	struct xgene_reboot_context *ctx;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx) {
-		dev_err(&pdev->dev, "out of memory for context\n");
-		return -ENODEV;
-	}
+	if (!ctx)
+		return -ENOMEM;
 
 	ctx->csr = of_iomap(pdev->dev.of_node, 0);
 	if (!ctx->csr) {
-- 
1.9.1

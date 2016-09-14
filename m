From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] power: reset: xgene-reboot: Unmap region obtained by of_iomap
Date: Wed, 14 Sep 2016 16:25:39 +0530
Message-ID: <1473850539-15721-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <y>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36570 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbcINK42 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2016 06:56:28 -0400
In-Reply-To: <y>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

Free memory mapping, if probe is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/power/reset/xgene-reboot.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index f07e93c..73c3d93 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -81,8 +81,10 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 	ctx->restart_handler.notifier_call = xgene_restart_handler;
 	ctx->restart_handler.priority = 128;
 	err = register_restart_handler(&ctx->restart_handler);
-	if (err)
+	if (err) {
+		iounmap(ctx->csr);
 		dev_err(dev, "cannot register restart handler (err=%d)\n", err);
+	}
 
 	return err;
 }
-- 
1.7.9.5


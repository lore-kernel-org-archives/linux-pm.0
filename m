From: arvind.yadav.cs@gmail.com
Subject: [PATCH] power: reset: zx-reboot: Unmap region obtained by of_iomap
Date: Wed, 14 Sep 2016 16:35:31 +0530
Message-ID: <57d92f28.8796620a.e4584.df58@mx.google.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33491 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbcINLGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2016 07:06:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

Free memory mapping, if probe is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/power/reset/zx-reboot.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
index a5b0096..b0b1eb3 100644
--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -58,9 +58,12 @@ static int zx_reboot_probe(struct platform_device *pdev)
 	}
 
 	err = register_restart_handler(&zx_restart_nb);
-	if (err)
+	if (err) {
+		iounmap(base);
+		iounmap(pcu_base);
 		dev_err(&pdev->dev, "Register restart handler failed(err=%d)\n",
 			err);
+	}
 
 	return err;
 }
-- 
1.7.9.5


From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power: ab8500_charger: fix spelling mistake: "prechage" -> "precharge"
Date: Sat, 29 Apr 2017 22:56:49 +0100
Message-ID: <20170429215649.11845-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60572 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031500AbdD2V4v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Apr 2017 17:56:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_error message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 5cee9aa87aa3..4ebbcce45c48 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3238,7 +3238,7 @@ static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
 			BUS_PP_PRECHG_CURRENT_MASK, 0);
 		if (ret) {
 			dev_err(di->dev,
-				"failed to setup usb power path prechage current\n");
+				"failed to setup usb power path precharge current\n");
 			goto out;
 		}
 	}
-- 
2.11.0

From: "James A. MacInnes" <james.a.macinnes@gmail.com>
Subject: [PATCH] power:sbs-manager: Fix double shift of select reg
Date: Thu, 15 Feb 2018 15:13:33 -0800
Message-ID: <1518736413-4797-1-git-send-email-james.a.macinnes@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35439 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756495AbeBOXNr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Feb 2018 18:13:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "James A. MacInnes" <james.a.macinnes@gmail.com>

1 << BIT() causes double shift when the macro is unwrapped
removed extra "1 <<"
---
 drivers/power/supply/sbs-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index ccb4217..cb6e8f6 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -183,7 +183,7 @@ static int sbsm_select(struct i2c_mux_core *muxc, u32 chan)
 		return ret;
 
 	/* chan goes from 1 ... 4 */
-	reg = 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
+	reg = BIT(SBSM_SMB_BAT_OFFSET + chan);
 	ret = sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
 	if (ret)
 		dev_err(dev, "Failed to select channel %i\n", chan);
-- 
2.7.4

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] power: reset: at91-poweroff: fix clobber list
Date: Wed, 31 May 2017 11:49:14 +0200
Message-ID: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35147 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdEaJtd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 05:49:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Assembly in at91_lpddr_poweroff has r0 in the clobber list but uses r6.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index c6c3beea72f9..c30c40193aaa 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -97,7 +97,7 @@ static void at91_lpddr_poweroff(void)
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
 		  "r" (at91_shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
-		: "r0");
+		: "r6");
 }
 
 static int at91_poweroff_get_wakeup_mode(struct device_node *np)
-- 
2.11.0

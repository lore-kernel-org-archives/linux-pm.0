From: Michael Heinemann <posted@heine.so>
Subject: [PATCH] sbs-battery: correct capacity mode selection bits
Date: Fri, 07 Jul 2017 16:23:54 +0200
Message-ID: <1a1c52f56a9e530ae2d0bf825e67f6a6@heine.so>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:47098 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbdGGOX5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 10:23:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 6310B4380064
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2017 16:23:56 +0200 (CEST)
Received: from _ (frachter.stresser.de [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id F379D4380063
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2017 16:23:54 +0200 (CEST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

The capacity mode bit is bit 15. Currently it is written as
default initialized enum and never shifted. This leads to
a behaviour where the BATTERY_MODE is not correctly
recognized and set again.

This commit initializes the enum accordingly.

Signed-off-by: Michael Heinemann <committed@heine.so>
---
  drivers/power/supply/sbs-battery.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c 
b/drivers/power/supply/sbs-battery.c
index 8bb2eb3..498e9af 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -60,8 +60,8 @@ enum {
  #define BATTERY_MODE_OFFSET		0x03
  #define BATTERY_MODE_MASK		0x8000
  enum sbs_battery_mode {
-	BATTERY_MODE_AMPS,
-	BATTERY_MODE_WATTS
+	BATTERY_MODE_AMPS = 0,
+	BATTERY_MODE_WATTS = 0x8000
  };

  /* manufacturer access defines */
-- 
2.7.4

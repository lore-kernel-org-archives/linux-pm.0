From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] power: axp288_charger: remove duplicated include from axp288_charger.c
Date: Sat, 13 Aug 2016 09:07:07 +0000
Message-ID: <1471079227-9753-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33280 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbcHMJH6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Aug 2016 05:07:58 -0400
Received: by mail-pa0-f65.google.com with SMTP id vy10so654200pac.0
        for <linux-pm@vger.kernel.org>; Sat, 13 Aug 2016 02:07:16 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Chen-Yu Tsai <wens@csie.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-pm@vger.kernel.org

Remove duplicated include.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/power/supply/axp288_charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 4030eeb..75b8e0c 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -23,7 +23,6 @@
 #include <linux/usb/otg.h>
 #include <linux/notifier.h>
 #include <linux/power_supply.h>
-#include <linux/notifier.h>
 #include <linux/property.h>
 #include <linux/mfd/axp20x.h>
 #include <linux/extcon.h>


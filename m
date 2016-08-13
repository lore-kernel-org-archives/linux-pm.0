From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] power: axp288_fuel_gauge: remove duplicated include from axp288_fuel_gauge.c
Date: Sat, 13 Aug 2016 09:06:47 +0000
Message-ID: <1471079207-9668-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33887 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbcHMJZM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Aug 2016 05:25:12 -0400
Received: by mail-pa0-f66.google.com with SMTP id hh10so672295pac.1
        for <linux-pm@vger.kernel.org>; Sat, 13 Aug 2016 02:25:11 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Chen-Yu Tsai <wens@csie.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-pm@vger.kernel.org

Remove duplicated include.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 50c0110..5bdde69 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -22,7 +22,6 @@
 #include <linux/regmap.h>
 #include <linux/jiffies.h>
 #include <linux/interrupt.h>
-#include <linux/device.h>
 #include <linux/workqueue.h>
 #include <linux/mfd/axp20x.h>
 #include <linux/platform_device.h>


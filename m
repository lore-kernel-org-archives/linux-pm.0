From: <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v1 04/16] mfd: mt6397: add MT6323 RTC support into MT6397
 driver
Date: Fri, 23 Mar 2018 17:15:01 +0800
Message-ID: <90320622cb491b9d3251e2ce9d0501422f47660f.1521794177.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1521794176.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Add compatible string as "mt6323-rtc" that will make the OF core spawn
child devices for the RTC subnode of that MT6323 MFD node.

Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mfd/mt6397-core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 77b64bd..f71874a 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2014-2018 MediaTek Inc.
  * Author: Flora Fu, MediaTek
  *
  * This program is free software; you can redistribute it and/or modify
@@ -23,6 +23,9 @@
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/mfd/mt6323/registers.h>
 
+#define MT6323_RTC_BASE		0x8000
+#define MT6323_RTC_SIZE		0x3e
+
 #define MT6397_RTC_BASE		0xe000
 #define MT6397_RTC_SIZE		0x3e
 
@@ -30,6 +33,19 @@
 #define MT6391_CID_CODE		0x91
 #define MT6397_CID_CODE		0x97
 
+static const struct resource mt6323_rtc_resources[] = {
+	{
+		.start = MT6323_RTC_BASE,
+		.end   = MT6323_RTC_BASE + MT6323_RTC_SIZE,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = MT6323_IRQ_STATUS_RTC,
+		.end   = MT6323_IRQ_STATUS_RTC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
 static const struct resource mt6397_rtc_resources[] = {
 	{
 		.start = MT6397_RTC_BASE,
@@ -55,6 +71,11 @@ static const struct resource mt6397_keys_resources[] = {
 
 static const struct mfd_cell mt6323_devs[] = {
 	{
+		.name = "mt6323-rtc",
+		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
+		.resources = mt6323_rtc_resources,
+		.of_compatible = "mediatek,mt6323-rtc",
+	}, {
 		.name = "mt6323-regulator",
 		.of_compatible = "mediatek,mt6323-regulator"
 	}, {
-- 
2.7.4

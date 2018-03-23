From: <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v1 13/16] rtc: mediatek: update license converting to using
 SPDX identifiers
Date: Fri, 23 Mar 2018 17:15:10 +0800
Message-ID: <86450fc8dcc53c658e97ac739aac2bf7d1f94b64.1521794177.git.sean.wang@mediatek.com>
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

Update the license and as well convert to using SPDX identifiers.

Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/rtc/rtc-mt6397.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index f5dc70d..ad336a4 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -1,16 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
-* Copyright (c) 2014-2015 MediaTek Inc.
-* Author: Tianping.Fang <tianping.fang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License version 2 as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-* GNU General Public License for more details.
-*/
+ * MediaTek PMIC RTC driver
+ *
+ * Copyright (C) 2014-2018 MediaTek Inc.
+ *
+ * Author: Tianping.Fang <tianping.fang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ *	   Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ */
 
 #include <linux/err.h>
 #include <linux/interrupt.h>
-- 
2.7.4

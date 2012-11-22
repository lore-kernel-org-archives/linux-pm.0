From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2 1/3] Introduce THERMAL_TREND_RAISE_FULL and
 THERMAL_TREND_DROP_FULL
Date: Thu, 22 Nov 2012 15:51:49 +0800
Message-ID: <1353570709.2297.4.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57420 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965124Ab2KVTR4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 22 Nov 2012 14:17:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, durga <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

>From cd05abc4929c21275e3674fb303ca6007f8415a0 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Mon, 19 Nov 2012 15:33:51 +0800
Subject: [PATCH 1/3] Introduce THERMAL_TREND_RAISE_FULL and
 THERMAL_TREND_DROP_FULL

These two new thermal_trend types are used to tell the governor
that the temeprature is raising/dropping quickly.

Thermal cooling governors should handle this situation and make
proper decisions, e.g. set cooling state to upper/lower limit directly
instead of one step each time.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/thermal.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 807f214..dcaa400 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -68,6 +68,8 @@ enum thermal_trend {
 	THERMAL_TREND_STABLE, /* temperature is stable */
 	THERMAL_TREND_RAISING, /* temperature is raising */
 	THERMAL_TREND_DROPPING, /* temperature is dropping */
+	THERMAL_TREND_RAISE_FULL, /* apply highest cooling action */
+	THERMAL_TREND_DROP_FULL, /* apply lowest cooling action */
 };
 
 /* Events supported by Thermal Netlink */
-- 
1.7.9.5




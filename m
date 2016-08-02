From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0961/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:03:02 +0800
Message-ID: <20160802120302.14126-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2845 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966116AbcHBN60 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 09:58:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, gregkh@linuxfoundation.org, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, heiko@sntech.de, s.hauer@pengutronix.de

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/thermal/intel_soc_dts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_soc_dts_thermal.c b/drivers/thermal/intel_soc_dts_thermal.c
index 4ebb31a3..61974c0 100644
--- a/drivers/thermal/intel_soc_dts_thermal.c
+++ b/drivers/thermal/intel_soc_dts_thermal.c
@@ -23,7 +23,7 @@
 #define CRITICAL_OFFSET_FROM_TJ_MAX	5000
 
 static int crit_offset = CRITICAL_OFFSET_FROM_TJ_MAX;
-module_param(crit_offset, int, 0644);
+module_param(crit_offset, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(crit_offset,
 	"Critical Temperature offset from tj max in millidegree Celsius.");
 
-- 
2.9.2


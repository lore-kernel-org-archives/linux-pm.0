From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0251/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:53:19 +0800
Message-ID: <20160802105319.30471-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, davem@davemloft.net, linux@roeck-us.net, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aduggan@synaptics.com, dianders@chromium.org
List-Id: linux-pm@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c966492..77a1263 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1441,7 +1441,7 @@ static void __exit intel_idle_exit(void)
 module_init(intel_idle_init);
 module_exit(intel_idle_exit);
 
-module_param(max_cstate, int, 0444);
+module_param(max_cstate, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 MODULE_AUTHOR("Len Brown <len.brown@intel.com>");
 MODULE_DESCRIPTION("Cpuidle driver for Intel Hardware v" INTEL_IDLE_VERSION);
-- 
2.9.2

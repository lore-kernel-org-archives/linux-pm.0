From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0122/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:42:20 +0800
Message-ID: <20160802104220.21883-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com, hpa@zytor.com, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jslaby@suse.cz, peter@korsgaard.com, lee.jones@linaro.org
List-Id: linux-pm@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/cpufreq/powernow-k7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 9f013ed..2c7d73a 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -683,7 +683,7 @@ static void __exit powernow_exit(void)
 	cpufreq_unregister_driver(&powernow_driver);
 }
 
-module_param(acpi_force,  int, 0444);
+module_param(acpi_force,  int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(acpi_force, "Force ACPI to be used.");
 
 MODULE_AUTHOR("Dave Jones");
-- 
2.9.2

From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0117/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:41:56 +0800
Message-ID: <20160802104156.21551-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36015 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755211AbcHBLTo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 07:19:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com, hpa@zytor.com, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jslaby@suse.cz, peter@korsgaard.com, lee.jones@linaro.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/cpufreq/e_powersaver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index cdf097b..65467d0 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -414,15 +414,15 @@ static void __exit eps_exit(void)
 
 /* Allow user to overclock his machine or to change frequency to higher after
  * unloading module */
-module_param(freq_failsafe_off, int, 0644);
+module_param(freq_failsafe_off, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(freq_failsafe_off, "Disable current vs max frequency check");
-module_param(voltage_failsafe_off, int, 0644);
+module_param(voltage_failsafe_off, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(voltage_failsafe_off, "Disable current vs max voltage check");
 #if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
-module_param(ignore_acpi_limit, int, 0644);
+module_param(ignore_acpi_limit, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ignore_acpi_limit, "Don't check ACPI's processor speed limit");
 #endif
-module_param(set_max_voltage, int, 0644);
+module_param(set_max_voltage, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(set_max_voltage, "Set maximum CPU voltage (mV) C7-M only");
 
 MODULE_AUTHOR("Rafal Bilski <rafalbilski@interia.pl>");
-- 
2.9.2


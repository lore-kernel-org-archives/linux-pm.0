From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0120/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:42:11 +0800
Message-ID: <20160802104211.21751-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8910 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947AbcHBLTw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 07:19:52 -0400
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
 drivers/cpufreq/longhaul.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index c46a12d..2f77e30 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -978,20 +978,20 @@ static void __exit longhaul_exit(void)
 /* Even if BIOS is exporting ACPI C3 state, and it is used
  * with success when CPU is idle, this state doesn't
  * trigger frequency transition in some cases. */
-module_param(disable_acpi_c3, int, 0644);
+module_param(disable_acpi_c3, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(disable_acpi_c3, "Don't use ACPI C3 support");
 /* Change CPU voltage with frequency. Very useful to save
  * power, but most VIA C3 processors aren't supporting it. */
-module_param(scale_voltage, int, 0644);
+module_param(scale_voltage, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(scale_voltage, "Scale voltage of processor");
 /* Force revision key to 0 for processors which doesn't
  * support voltage scaling, but are introducing itself as
  * such. */
-module_param(revid_errata, int, 0644);
+module_param(revid_errata, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(revid_errata, "Ignore CPU Revision ID");
 /* By default driver is disabled to prevent incompatible
  * system freeze. */
-module_param(enable, int, 0644);
+module_param(enable, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable driver");
 
 MODULE_AUTHOR("Dave Jones");
-- 
2.9.2


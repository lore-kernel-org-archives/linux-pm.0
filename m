From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0123/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:42:24 +0800
Message-ID: <20160802104224.21949-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:36618 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933817AbcHBMHq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 08:07:46 -0400
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
 drivers/cpufreq/speedstep-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 1b80621..9a375de 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -470,7 +470,7 @@ out:
 EXPORT_SYMBOL_GPL(speedstep_get_freqs);
 
 #ifdef CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK
-module_param(relaxed_check, int, 0444);
+module_param(relaxed_check, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(relaxed_check,
 		"Don't do all checks for speedstep capability.");
 #endif
-- 
2.9.2


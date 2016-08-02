From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0121/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:42:15 +0800
Message-ID: <20160802104215.21817-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6521 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935105AbcHBN0W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 09:26:22 -0400
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
 drivers/cpufreq/loongson2_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 6bbdac1..c81509f 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -195,7 +195,7 @@ static void __exit cpufreq_exit(void)
 module_init(cpufreq_init);
 module_exit(cpufreq_exit);
 
-module_param(nowait, uint, 0644);
+module_param(nowait, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nowait, "Disable Loongson-2F specific wait");
 
 MODULE_AUTHOR("Yanhua <yanh@lemote.com>");
-- 
2.9.2

